`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module icache (
  input logic CLK, nRST,
  datapath_cache_if.icache dpif,
  caches_if.icache icif
);
  //comment
  icache_frame [15:0] icache;
  icachef_t frameIn;
  word_t cacheData;
  logic miss;
  integer i;

  assign frameIn.tag = dpif.imemaddr[31:6];
  assign frameIn.idx = dpif.imemaddr[5:2];
  assign frameIn.bytoff = '0;
  assign cacheData = icache[frameIn.idx].data;
  //assign icacheif.miss = miss;
  //assign icacheif.icacheFrame = icache;

  always_ff @(posedge CLK, negedge nRST) begin
    if(nRST == 0) begin
      for(i=0; i<16; i++) begin
        icache[i].valid <= '0;
        icache[i].tag <= '0;
        icache[i].data <= '0;
      end
    end else if(icif.iwait == 0) begin
      icache[frameIn.idx].valid <= 1;
      icache[frameIn.idx].tag <= frameIn.tag;
      icache[frameIn.idx].data = icif.iload;
    end
  end

  always_comb begin
    //miss logic
    miss = 1;
    if(icache[frameIn.idx].tag == frameIn.tag & icache[frameIn.idx].valid & dpif.imemREN) begin
      miss = 0;
    end

    //iREN
    icif.iREN = '0;
    if(miss == 1) begin
      icif.iREN = dpif.imemREN;
    end

    //iaddr
    icif.iaddr = '0;
    if(miss == 1) begin
      icif.iaddr = dpif.imemaddr;
    end

    //imemload
    dpif.imemload = cacheData;
    if(miss == 1) begin
      dpif.imemload = icif.iload;
    end

    //ihit
    dpif.ihit = 1;
    if(miss == 1) begin
      dpif.ihit = ~icif.iwait;
    end
  end

endmodule

//on a miss
//miss = 1
//iREN = imemREN
//iaddr=imemaddr
//imemload = iload


//iload gets loaded into table on dpif.ihit == 1 (icif.iwait == 0)
//icache[idx].valid <= 1
//icache[idx].tag <= tagIN
//icache[idx].data <= dataIn
//becuase tagIN == icache[idx].tag now
  //miss = 0
  //iREN = 0
  //iaddr = 0
  //imemload = data most recently put into the cache
