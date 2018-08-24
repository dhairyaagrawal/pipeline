/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(input CLK, output nRST, register_file_if.tb tbif);
  initial begin
    // initialize test input signals
    nRST = 1'b1;
    rfif.tb.WEN = 1'b0;
    rfif.tb.wdat = '0;
    rfif.tb.wsel = '0;
    rfif.tb.rsel1 = '0;
    rfif.tb.rsel2 = '0;
    @(posedge CLK);

    nRST = 1'b0;
    @(posedge CLK);

    nRST = 1'b1;
    @(posedge CLK);

    // write to register 05
    rfif.tb.wdat = '1;
    rfif.tb.wsel = 5;
    rfif.tb.WEN = 1'b1;
    @(posedge CLK);
    rfif.tb.WEN = 1'b0;
    rfif.tb.rsel1 = 5;
    @(posedge CLK);
    if(rfif.tb.rdat1 == '1) begin
      $info("write on 05 works");
    end else begin
      $error("write on 05 failed");
    end

    // write to register 29
    rfif.tb.wdat = 32'hAABBCCDD;
    rfif.tb.wsel = 29;
    rfif.tb.WEN = 1'b1;
    @(posedge CLK);
    rfif.tb.WEN = 1'b0;
    rfif.tb.rsel2 = 29;
    @(posedge CLK);
    if(rfif.tb.rdat2 == 32'hAABBCCDD) begin
      $info("write on 29 works");
    end else begin
      $error("write on 29 failed");
    end

    // write to register 00
    rfif.tb.wdat = '1;
    rfif.tb.wsel = 0;
    rfif.tb.WEN = 1'b1;
    @(posedge CLK);
    rfif.tb.WEN = 1'b0;
    rfif.tb.rsel1 = 0;
    @(posedge CLK);
    if(rfif.tb.rdat1 == '0) begin
      $info("write on 00 works so all 0s");
    end else begin
      $error("write on 00 failed so written over");
    end

    //async reset
    rfif.tb.nRST = 1'b0;
    @(negedge CLK);
    rfif.tb.rsel2 = 29;
    @(posedge CLK);
    rfif.tb.nRST = 1'b1;
    if(rfif.tb.rdat1 == '0) begin
      $info("write on 00 works so all 0s");
    end else begin
      $error("write on 00 failed so written over");
    end



  end
endprogram
