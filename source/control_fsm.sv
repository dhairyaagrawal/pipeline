`include "cpu_types_pkg.vh"
`include "control_fsm_if.vh"

import cpu_types_pkg::*;

module control_fsm (
  input logic CLK,
  input logic nRST,
  control_fsm_if.cf cfif
);

  typedef enum logic [3:0] {IDLE, WRAM0, WRAM1, RRAM0, RRAM1, CHK0, FWRAM0, FWRAM1, CHK1, FWRAM2, FWRAM3, INCR, STOREHIT, WRAMHIT, FLUSH} stateType;
  stateType state;
  stateType nextstate;

  logic [3:0] ct_reg;
  logic [3:0] nextct;

  logic access;
  logic dirty;
  word_t [1:0] data;
  logic [25:0] tag;

  assign access = (cfif.dmemREN || cfif.dmemWEN);
  assign dirty = (cfif.LRU == 0) ? cfif.dirty0 : cfif.dirty1;
  assign data = (cfif.LRU == 0) ? cfif.data0 : cfif.data1;
  assign tag = (cfif.LRU == 0) ? cfif.tag0 : cfif.tag1;

  //STORE STATE
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      state <= IDLE;
      ct_reg <= '0;
    end else begin
      state <= nextstate;
      ct_reg <= nextct;
    end
  end
  assign cfif.ct = ct_reg[2:0];

  //NEXT STATE LOGIC
  always_comb begin
    nextstate = state;
    case(state)
      IDLE : if(cfif.miss && dirty && access) begin
               nextstate = WRAM0;
             end else if(cfif.miss && !dirty && access) begin
               nextstate = RRAM0;
             end else if(cfif.halt) begin
               nextstate = CHK0;
             end
      WRAM0 : if(!cfif.dwait) begin
                nextstate = WRAM1;
              end 
      WRAM1 : if(!cfif.dwait) begin
                nextstate = RRAM0;
              end
      RRAM0 : if(!cfif.dwait) begin
                nextstate = RRAM1;
              end
      RRAM1 : if(!cfif.dwait) begin
                nextstate = IDLE;
              end
      CHK0 : if(cfif.dirty0) begin
               nextstate = FWRAM0;
             end else if(!cfif.dirty0) begin
               nextstate = CHK1;
             end
      FWRAM0 : if(!cfif.dwait) begin
                 nextstate = FWRAM1;
               end 
      FWRAM1 : if(!cfif.dwait) begin
                 nextstate = CHK1;
               end 
      CHK1 : if(cfif.dirty1) begin
               nextstate = FWRAM2;
             end else if(!cfif.dirty1) begin
               nextstate = INCR;
             end 
      FWRAM2 : if(!cfif.dwait) begin
                 nextstate = FWRAM3;
               end
      FWRAM3 : if(!cfif.dwait) begin
                 nextstate = INCR;
               end 
      INCR : nextstate = STOREHIT;
      STOREHIT : if(ct_reg == 8) begin
                   nextstate = WRAMHIT;
                 end else begin
                   nextstate = CHK0;
                 end
      WRAMHIT : if(!cfif.dwait) begin
                  nextstate = FLUSH;
                end
      FLUSH : nextstate = state;
    endcase
  end

  //OUTPUT STATE LOGIC
  //dREN, dWEN, daddr, nextct, store, storesel, flushing, control_offset, flushed
  always_comb begin
    cfif.dREN = 1'b0;
    cfif.dWEN = 1'b0;
    cfif.daddr = '0;
    nextct = ct_reg;
    cfif.store = '0;
    cfif.storesel = 1'b0;
    cfif.flushing = 1'b0;
    cfif.control_offset = 1'b0;
    cfif.flushed = 1'b0;
    cfif.tagWEN = 1'b0;
    case(state)
      IDLE : cfif.flushed = 1'b0;
      WRAM0 : begin 
              cfif.dWEN = 1;
              cfif.daddr = {tag, cfif.dmemaddr[5:3], 3'b000};
              cfif.store = data[0];
      end
      WRAM1 : begin
              cfif.dWEN = 1;
              cfif.daddr = {tag, cfif.dmemaddr[5:3], 3'b100};
              cfif.store = data[1];
      end
      RRAM0 : begin
              cfif.dREN = 1;
              cfif.daddr = {cfif.dmemaddr[31:3], 3'b000};
              cfif.control_offset = 0;
      end
      RRAM1 : begin
              cfif.dREN = 1;
              cfif.daddr = {cfif.dmemaddr[31:3], 3'b100};
              cfif.control_offset = 1;
              cfif.tagWEN = 1'b1;
      end
      CHK0 : cfif.flushing = 1'b1;
      FWRAM0 : begin
               cfif.flushing = 1'b1;
               cfif.dWEN = 1;
               cfif.daddr = {cfif.tag0, ct_reg[2:0], 3'b000};
               cfif.store = cfif.data0[0];
      end
      FWRAM1 : begin
               cfif.flushing = 1'b1;
               cfif.dWEN = 1;
               cfif.daddr = {cfif.tag0, ct_reg[2:0], 3'b100};
               cfif.store = cfif.data0[1];
      end
      CHK1 : cfif.flushing = 1'b1;
      FWRAM2 : begin
               cfif.flushing = 1'b1;
               cfif.dWEN = 1;
               cfif.daddr = {cfif.tag1, ct_reg[2:0], 3'b000};
               cfif.store = cfif.data1[0];
      end
      FWRAM3 : begin
               cfif.flushing = 1'b1;
               cfif.dWEN = 1;
               cfif.daddr = {cfif.tag1, ct_reg[2:0], 3'b100};
               cfif.store = cfif.data1[1];
      end
      INCR : nextct = ct_reg + 1;
      STOREHIT : cfif.flushing = 1'b1;
      WRAMHIT : begin 
                cfif.dWEN = 1;
                cfif.daddr = 32'h00003100;
                cfif.storesel = 1'b1;
      end
      FLUSH : cfif.flushed = 1'b1;
    endcase
  end

endmodule
