
// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "access_logic_if.vh"
`include "control_fsm_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dcif,
  caches_if.dcache cif
);

  import cpu_types_pkg::*;

  //interfaces
  access_logic_if alif();
  control_fsm_if cfif();

  //modules
  access_logic AL (alif);
  control_fsm CF (CLK, nRST, cfif);

  //declare d-cache & other regs
  dcache_frame [7:0] set0, set1;
  logic [7:0] lru_reg;
  logic [31:0] hitct;
  logic last_dREN;

  //easier access to signals
  logic [25:0] tagbits;
  logic offset;
  logic [2:0] index_in;

  assign tagbits = dcif.dmemaddr[31:6];
  assign offset = dcif.dmemaddr[2];
  assign index_in = (cfif.flushing == 1) ? cfif.ct : dcif.dmemaddr[5:3]; //INDEX MUX

  //ACCESS LOGIC
  assign alif.tagbits = tagbits;
  assign alif.offset = offset;
  assign alif.dmemREN = dcif.dmemREN;
  assign alif.dmemWEN = dcif.dmemWEN;
  assign alif.valid0 = set0[index_in].valid;
  assign alif.tag0 = set0[index_in].tag;
  assign alif.data0 = set0[index_in].data;
  assign alif.valid1 = set1[index_in].valid;
  assign alif.tag1 = set1[index_in].tag;
  assign alif.data1 = set1[index_in].data;

  assign dcif.dmemload = alif.data_out;
  assign dcif.dhit = ~alif.miss;

  //DCACHE
  integer i;
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      for(i = 0; i < 8; i++) begin
        set0[i].tag <= '0;
        set0[i].data <= '0;
        set0[i].dirty <= 1'b0;
        set0[i].valid <= 1'b0;
        set1[i].tag <= '0;
        set1[i].data <= '0;
        set1[i].dirty <= 1'b0;
        set1[i].valid <= 1'b0;
        lru_reg[i] <= 1'b0;
      end
    end else if(cfif.flushing) begin
      set0[index_in].valid <= 1'b0;
      set1[index_in].valid <= 1'b0;
    end else if(alif.WENcache) begin
      if(alif.setsel) begin
        set1[index_in].data[offset] <= dcif.dmemstore;
        set1[index_in].dirty <= 1'b1;
        lru_reg[index_in] <= ~alif.setsel;
      end else if(~alif.setsel) begin
        set0[index_in].data[offset] <= dcif.dmemstore;
        set0[index_in].dirty <= 1'b1;
        lru_reg[index_in] <= ~alif.setsel;
      end
    end else if(~cif.dwait) begin
      if(lru_reg[index_in] == 1'b1) begin
        set1[index_in].data[cfif.control_offset] = cif.dload;
        set1[index_in].tag = tagbits;
        set1[index_in].valid = 1'b1;
        set1[index_in].dirty = 1'b0;
      end else if(lru_reg[index_in] == 1'b0) begin
        set0[index_in].data[cfif.control_offset] = cif.dload;
        set0[index_in].tag = tagbits;
        set0[index_in].valid = 1'b1;
        set0[index_in].dirty = 1'b0;
      end
    end
  end
  
  //CONTROL FSM
  assign cfif.LRU = lru_reg[index_in];
  assign cfif.dirty0 = set0[index_in].dirty;
  assign cfif.tag0 = set0[index_in].tag;
  assign cfif.data0 = set0[index_in].data;
  assign cfif.dirty1 = set1[index_in].dirty;
  assign cfif.tag1 = set1[index_in].tag;
  assign cfif.data1 = set1[index_in].data;
  assign cfif.dwait = cif.dwait;
  assign cfif.dmemaddr = dcif.dmemaddr;
  assign cfif.dmemREN = dcif.dmemREN;
  assign cfif.dmemWEN = dcif.dmemWEN;
  assign cfif.halt = dcif.halt;
  assign cfif.miss = alif.miss;

  assign dcif.flushed = cfif.flushed;
  assign cif.dREN = cfif.dREN;
  assign cif.dWEN = cfif.dWEN;
  assign cif.daddr = cfif.daddr;
  assign cif.dstore = (cfif.storesel == 1) ? hitct : cfif.store; //STORE MUX

  //HIT COUNTER
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      hitct <= '0;
      last_dREN <= 1'b0;
    end else begin
      last_dREN <= cfif.dREN;
      if(~last_dREN && ~alif.miss) begin
        hitct <= hitct + 1;
      end
    end
  end

endmodule
