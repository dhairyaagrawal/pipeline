
// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "access_logic_if.vh"
`include "control_fsm_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dpif,
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
  logic flush_latch;

  //easier access to signals
  logic [25:0] tagbits;
  logic offset;
  logic [2:0] index_in;
  word_t addr_in;

  assign addr_in = (cfif.snoop) ? cfif.snoopaddr : dpif.dmemaddr;
  assign tagbits = addr_in[31:6];
  assign offset = addr_in[2];
  assign index_in = (cfif.flushing == 1) ? cfif.ct : addr_in[5:3]; //INDEX MUX

  //ACCESS LOGIC
  assign alif.tagbits = tagbits;
  assign alif.offset = offset;
  assign alif.dmemREN = dpif.dmemREN;
  assign alif.dmemWEN = dpif.dmemWEN;
  assign alif.valid0 = set0[index_in].valid;
  assign alif.dirty0 = set0[index_in].dirty;
  assign alif.tag0 = set0[index_in].tag;
  assign alif.data0 = set0[index_in].data;
  assign alif.valid1 = set1[index_in].valid;
  assign alif.dirty1 = set1[index_in].dirty;
  assign alif.tag1 = set1[index_in].tag;
  assign alif.data1 = set1[index_in].data;
  assign alif.halt = dpif.halt;
  assign alif.ccinv = cif.ccinv;
  assign alif.snoop = cfif.snoop;
  assign alif.mytrans = cfif.mytrans;

  assign cif.ccwrite = alif.ccwrite;
  assign cif.cctrans = alif.cctrans;
  assign dpif.dmemload = alif.data_out;

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
    end else if(alif.WENcache && alif.snoop) begin
      if(alif.setsel) begin
        set1[index_in].dirty <= alif.newValid;
        set1[index_in].valid <= alif.newDirty;
      end else if(~alif.setsel) begin
        set0[index_in].valid <= alif.newValid;
        set0[index_in].dirty <= alif.newDirty;
      end
    end else if(alif.WENcache) begin
      if(alif.setsel) begin
        set1[index_in].data[offset] <= dpif.dmemstore;
        set1[index_in].dirty <= 1'b1;
        lru_reg[index_in] <= ~alif.setsel;
      end else if(~alif.setsel) begin
        set0[index_in].data[offset] <= dpif.dmemstore;
        set0[index_in].dirty <= 1'b1;
        lru_reg[index_in] <= ~alif.setsel;
      end
    end else if(~cif.dwait && cif.dREN) begin
      if(lru_reg[index_in] == 1'b1) begin
        set1[index_in].data[cfif.control_offset] <= cif.dload;
        set1[index_in].dirty <= 1'b0;
        if(cfif.tagWEN) begin
          set1[index_in].tag <= tagbits;
          set1[index_in].valid <= 1'b1;
        end
      end else if(lru_reg[index_in] == 1'b0) begin
        set0[index_in].data[cfif.control_offset] <= cif.dload;
        set0[index_in].dirty <= 1'b0;
        if(cfif.tagWEN) begin
          set0[index_in].tag <= tagbits;
          set0[index_in].valid <= 1'b1;
        end
      end
    end else if(~cif.dwait && cif.dWEN && cif.flushing) begin
      if(cfif.control_offset == 1'b1) begin
        set1[index_in].dirty <= 1'b0;
      end else begin
        set0[index_in].dirty <= 1'b0;
      end
    end else if(~cif.dwait && cif.dWEN) begin
      if(lru_reg[index_in] == 1'b1) begin
        set1[index_in].dirty <= 1'b0;
      end else begin
        set0[index_in].dirty <= 1'b0;
      end
    end else if(~alif.miss && ~alif.snoop) begin
      lru_reg[index_in] <= ~alif.setsel;
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
  assign cfif.dmemaddr = dpif.dmemaddr;
  assign cfif.dmemREN = dpif.dmemREN;
  assign cfif.dmemWEN = dpif.dmemWEN;
  assign cfif.halt = dpif.halt;
  assign cfif.miss = alif.miss;
  assign cfif.flush_latch = 1'b0;
  assign cfif.ccwait = cif.ccwait;
  assign cfif.ccwrite = alif.ccwrite;
  assign cfif.cctrans = alif.cctrans;
  assign cfif.ccsnoopaddr = cif.ccsnoopaddr;

  assign dpif.dhit = cfif.hit;
  assign dpif.flushed = cfif.flushed;
  assign cif.dREN = cfif.dREN;
  assign cif.dWEN = cfif.dWEN;
  assign cif.daddr = cfif.daddr;
  assign cif.dstore = (cfif.snoop) ? alif.data_out : cfif.store; //STORE MUX

  //FLUSH LATCH
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      flush_latch <= 1'b0;
    end else begin
      if(cfif.flushing) begin
        flush_latch <= 1;
      end else begin
        flush_latch <= flush_latch;
      end
    end
  end

endmodule
