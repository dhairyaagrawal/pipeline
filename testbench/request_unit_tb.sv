/*
  request unit test bench
*/

// mapped needs this
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif (); //shouldn't this be .rf??
  // test program
  test PROG (CLK, nRST, ruif); //edited, do i declare another reg_file_if??
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  reuest_unit DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.dmemreq (ruif.dmemreq),
    .\ruif.dmemwreq (ruif.dmemwreq),
    .\ruif.imemreq (ruif.imemreq),
    .\ruif.imemREN (ruif.imemREN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN)
  );
`endif

endmodule

program test(input logic CLK, output logic nRST, request_unit_if.tb ruif);
  initial begin
    // initialize test input signals
    nRST = 1'b1;
    ruif.ihit = 1'b0;
    ruif.dhit = '0;
    ruif.dmemreq = '0;
    ruif.dmemwreq = '0;
    ruif.imemreq = '0;
    @(posedge CLK);

    nRST = 1'b0;
    @(posedge CLK);

    nRST = 1'b1;
    @(posedge CLK);

   //~ihit & imemreq
   ruif.imemreq = 1'b1;
   @(posedge CLK);
   #2;
   assert(ruif.imemREN == 1'b1 & ruif.dmemREN == 1'b0)
    else $display("imem Error");

   //ihit & imemreq
   ruif.ihit = 1'b1;
   @(posedge CLK);
   #2;
   assert(ruif.imemREN == 1'b1 & ruif.dmemREN == 1'b0)
    else $display("ihit Error");

   //~dhit & dmemreq & ihit
   ruif.dmemreq = 1'b1;
   @(posedge CLK);
   #2;
   assert(ruif.imemREN == 1'b1 & ruif.dmemREN == 1'b1 & ruif.dmemWEN == 1'b0)
    else $display("dmemreq error Error");

   //dhit & dmemreq
   ruif.dmemreq = 1'b1;
   ruif.ihit = 1'b0;
   ruif.dhit = 1'b1;
   @(posedge CLK);
   #2;
   assert(ruif.imemREN == 1'b1 & ruif.dmemREN == 1'b0 & ruif.dmemWEN == 1'b0)
    else $display("dmemreq error Error2");

   //~dhit & dmemwreq
   ruif.dmemreq = 1'b0;
   ruif.dmemwreq = 1'b1;
   ruif.dhit = 1'b0;
   ruif.ihit = 1'b1;
   @(posedge CLK);
   #2;
   assert(ruif.imemREN == 1'b1 & ruif.dmemREN == 1'b0 & ruif.dmemWEN == 1'b1)
    else $display("dmemwreq error Error");

  end
endprogram
