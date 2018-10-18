/*
  dcache test bench
*/

// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dpif();
  caches_if cif();
  caches_if cif2();
  cache_control_if ccif(cif, cif2);
  cpu_ram_if ramif();

  logic flushed;

  // test program
  test PROG (CLK, nRST, dpif, cif);
  dcache DUT(CLK, nRST, dpif, cif);

  assign flushed = dpif.flushed;

  memory_control MC(CLK, nRST, ccif);
  ram RAM(CLK, nRST, ramif);

  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramREN = ccif.ramREN;
  assign ccif.ramload = ramif.ramload;
  assign ccif.ramstate = ramif.ramstate;

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if.dp dpif, caches_if.icache cif);
  initial begin
  //inputs to datapath -- dhit, dmemload, "flushed"
  //outputs from datapath -- halt, dmemREN, dmemWEN, datomic, dmemstore, dmemaddr
    int i;
    //RESET
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    nRST = 1'b0;
    @(posedge CLK);
    @(posedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    //INITALIZE
    i = 0;
    dpif.datomic = '0;
    cif.iREN = '0;
    cif.iaddr = '0;
    dpif.halt = 1'b0;
    dpif.dmemREN = 1'b0;
    dpif.dmemWEN = 1'b0;
    dpif.dmemstore = '0;
    dpif.dmemaddr = '0;
    @(posedge CLK);
    @(negedge CLK);

    //TEST1 -- WRITE TO RAM
    dpif.dmemstore = 32'hffff0000;
    dpif.dmemaddr = 32'h00000000;
    dpif.dmemWEN = 1'b1;
    @(posedge CLK);
    #1;
    while(dpif.dhit != 1'b1) begin
      @(posedge CLK);
    end
    @(posedge CLK);
    dpif.dmemWEN = 1'b0;
    @(negedge CLK);
    @(posedge CLK);

    //TEST2 -- READ FROM PREVIOUS LOCATION, MATCH DATA AND RECORD A HIT
    dpif.dmemREN = 1'b1;
    dpif.dmemstore = '0;
    @(posedge CLK);
    @(negedge CLK);
    assert(dpif.dmemload == 32'hffff0000)
      else $display("Error TEST2, dmemload differs");
    assert(dpif.dhit == 1'b1)
      else $display("Error TEST2, dhit not asserted");
    @(posedge CLK);
    dpif.dmemREN = 1'b0;

    //READ NEW WORD, HIT
    @(posedge CLK);
    dpif.dmemREN = 1'b1;
    dpif.dmemaddr = 32'h00000004;
    @(posedge CLK);
    @(negedge CLK);
    assert(dpif.dhit == 1'b1)
      else $display("Error TEST2b, dhit not asserted");
    @(posedge CLK);
    dpif.dmemREN = 1'b0;

    //TEST3 -- WRITE TO THE SAME INDEX, record hit
    @(posedge CLK);
    dpif.dmemWEN = 1'b1;
    dpif.dmemaddr = 32'h00000004;
    dpif.dmemstore = 32'h10101010;
    #1;
    while(dpif.dhit != 1'b1) begin
      @(posedge CLK);
    end
    @(posedge CLK);
    dpif.dmemWEN = 1'b0;

    @(posedge CLK);
    dpif.dmemREN = 1'b1;
    dpif.dmemaddr = 32'h00000000;
    @(posedge CLK);
    @(negedge CLK);
    #1;
    assert(dpif.dmemload == 32'hffff0000)
      else $display("Error TEST3, dmemload differs, check asm used, dependent value");
    assert(dpif.dhit == 1'b1)
      else $display("Error TEST3, dhit not asserted");

    @(posedge CLK);
    dpif.dmemREN = 1'b0;

    //TEST -- HALT AND DUMP RAM
    dpif.halt = 1'b1;
    while(dcache_tb.flushed != 1'b1) begin
      @(posedge CLK);
    end
    @(posedge CLK);
    nRST = 0;
  end

endprogram



