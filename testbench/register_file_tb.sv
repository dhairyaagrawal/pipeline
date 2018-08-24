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
  register_file_if rfif (); //shouldn't this be .rf??
  // test program
  test PROG (CLK, nRST, rfif); //edited, do i declare another reg_file_if??
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

program test(input logic CLK, output logic nRST, register_file_if.tb tbif);
  initial begin
    $monitor("wdat = %h, rdat1 = %h, rdat2 = %h", tbif.wdat, tbif.rdat1,
tbif.rdat2);
    // initialize test input signals
    nRST = 1'b1;
    tbif.WEN = 1'b0;
    tbif.wdat = '0;
    tbif.wsel = '0;
    tbif.rsel1 = '0;
    tbif.rsel2 = '0;
    @(posedge CLK);

    nRST = 1'b0;
    @(posedge CLK);

    nRST = 1'b1;
    @(posedge CLK);

    // write to register 05
    tbif.wdat = '1;
    tbif.wsel = 5;
    tbif.WEN = 1'b1;
    @(posedge CLK);
    tbif.WEN = 1'b0;
    tbif.rsel1 = 5;
    @(posedge CLK);
    if(tbif.rdat1 == '1) begin
      $info("write on 05 works");
    end else begin
      $error("write on 05 failed");
    end

    // write to register 29
    tbif.wdat = 32'hAABBCCDD;
    tbif.wsel = 29;
    tbif.WEN = 1'b1;
    @(posedge CLK);
    tbif.WEN = 1'b0;
    tbif.rsel2 = 29;
    @(posedge CLK);
    if(tbif.rdat2 == 32'hAABBCCDD) begin
      $info("write on 29 works");
    end else begin
      $error("write on 29 failed");
    end

    // write to register 00
    tbif.wdat = '1;
    tbif.wsel = 0;
    tbif.WEN = 1'b1;
    @(posedge CLK);
    tbif.WEN = 1'b0;
    tbif.rsel1 = 0;
    @(posedge CLK);
    if(tbif.rdat1 == '0) begin
      $info("write on 00 works so all 0s");
    end else begin
      $error("write on 00 failed so written over");
    end

    //async reset
    nRST = 1'b0;
    @(negedge CLK);
    tbif.rsel2 = 29;
    @(posedge CLK);
    nRST = 1'b1;
    if(tbif.rdat1 == '0) begin
      $info("write on 00 works so all 0s");
    end else begin
      $error("write on 00 failed so written over");
    end



  end
endprogram
