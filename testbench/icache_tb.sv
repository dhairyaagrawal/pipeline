/*
  icache test bench
*/

// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "icache_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dpif();
  caches_if icif();
  icache_if icacheif();
  // test program
  test PROG ();

  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dpif, icif, icacheif);
`else
  icache DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\dpif.halt (dpif.halt),
    .\dpif.imemREN (dpif.imemREN),
    .\dpif.imemaddr (dpif.imemaddr),
    .\dpif.dhit (dpif.dhit),
    .\dpif.datomic (dpif.datomic),
    .\dpif.dREN (dpif.dREN),
    .\dpif.dWEN (dpif.dWEN),
    .\dpif.dmemload (dpif.dmemload),
    .\dpif.dmemstore (dpif.dmemstore),
    .\icif.dwait (icif.dwait),
    .\icif.dload (icif.dload),
    .\icif.iload (icif.iload),
    .\icif.iwait (icif.iwait),
    .\icif.iREN (icif.iREN),
    .\icif.iaddr (icif.iaddr),
    .\icif.icache (icif.icache)
    .\icacheif.miss (icacheif.miss),
    .\icacheif.icacheFrame (icacheif.icacheFrame)
  );
`endif

endmodule

program test();

  initial begin
    //reset
    @(negedge icache_tb.CLK);
    icache_tb.nRST = 0;
    @(posedge icache_tb.CLK);
    icache_tb.nRST = 1;
    @(negedge icache_tb.CLK);

    //test 1
    //misses on index 3, tag = 5, data = FFFF
    //set iwait to 1
    icache_tb.dpif.imemREN = 1;
    icache_tb.icif.iwait = 1;
    icache_tb.dpif.imemaddr = {26'h5, 4'h3, 2'b00};
    icache_tb.icif.iload = 32'hFFFF;
    @(posedge icache_tb.CLK);
    #2;
    assert(icache_tb.icacheif.miss == 1 & icache_tb.icif.iaddr == {26'h5, 4'h3, 2'b00})
     else $display("test 1 miss error");
    @(negedge icache_tb.CLK);
    //set iwait to 0
    icache_tb.icif.iwait = 0;
    @(posedge icache_tb.CLK);
    #2;
    assert(icache_tb.icacheif.miss == 0 & icache_tb.icacheif.icacheFrame[3].tag == 5 &
icache_tb.icacheif.icacheFrame[3].valid == 1 & icache_tb.icacheif.icacheFrame[3].data == 32'hFFFF &
icache_tb.dpif.ihit == 1 & icache_tb.icif.iload == 32'hFFFF)
     else $display("test 1 icache error miss: %d, tag: %d, valid: %d, data: %h,
ihit: %d, iload: %h", icache_tb.icacheif.miss,
icache_tb.icacheif.icacheFrame[3].tag,icache_tb.icacheif.icacheFrame[3].valid,icache_tb.icacheif.icacheFrame[3].data,icache_tb.dpif.ihit,icache_tb.icif.iload);

    //test 2
    //hits on index 3, tag = 5
    icache_tb.icif.iwait = 1;
    icache_tb.dpif.imemaddr = {26'h5, 4'h3, 2'b00};
    icache_tb.icif.iload = 32'hBAD0;
    @(posedge icache_tb.CLK);
    assert(icache_tb.icacheif.miss == 0 & icache_tb.icif.iaddr == '0)
     else $display("test 2 miss error");
    @(negedge icache_tb.CLK);
    @(posedge icache_tb.CLK);
    #2;
    //add assertion check here
    assert(icache_tb.icacheif.miss == 0 & icache_tb.icacheif.icacheFrame[3].tag == 5 &
icache_tb.icacheif.icacheFrame[3].valid == 1 &
icache_tb.icacheif.icacheFrame[3].data == 32'hffff &
icache_tb.dpif.ihit == 1 & icache_tb.dpif.imemload == 32'hffff)
     else $display("test 2 icache error miss: %d, tag: %d, valid: %d, data: %h,
ihit: %d, imemload: %h", icache_tb.icacheif.miss,
icache_tb.icacheif.icacheFrame[3].tag,icache_tb.icacheif.icacheFrame[3].valid,icache_tb.icacheif.icacheFrame[3].data,icache_tb.dpif.ihit,icache_tb.dpif.imemload);

    //test 3
    //misses on index 3, tag = 5, data = FFFF
    //set iwait to 1
    icache_tb.dpif.imemREN = 0;
    icache_tb.icif.iwait = 1;
    icache_tb.dpif.imemaddr = {26'h5, 4'h3, 2'b00};
    icache_tb.icif.iload = 32'hDDDD;
    @(posedge icache_tb.CLK);
    #2;
    assert(icache_tb.icacheif.miss == 1 & icache_tb.icif.iaddr == {26'h5, 4'h3, 2'b00})
     else $display("test 3 miss error");
    @(negedge icache_tb.CLK);
    //set iwait to 0
    icache_tb.icif.iwait = 0;
    @(posedge icache_tb.CLK);
    #2;
    assert(icache_tb.icacheif.miss == 1 & icache_tb.icacheif.icacheFrame[3].tag == 5 &
icache_tb.icacheif.icacheFrame[3].valid == 1 &
icache_tb.icacheif.icacheFrame[3].data == 32'hDDDD &
icache_tb.dpif.ihit == ~icache_tb.icif.iwait & icache_tb.dpif.imemload ==
32'hDDDD)
     else $display("test 3 icache error miss: %d, tag: %d, valid: %d, data: %h,
ihit: %d, imemload: %h", icache_tb.icacheif.miss,
icache_tb.icacheif.icacheFrame[3].tag,icache_tb.icacheif.icacheFrame[3].valid,icache_tb.icacheif.icacheFrame[3].data,icache_tb.dpif.ihit,icache_tb.dpif.imemload);

  end
endprogram
