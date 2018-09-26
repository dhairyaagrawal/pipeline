/*
  hazard unit test bench
*/

// mapped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif (); //shouldn't this be .rf??
  // test program
  test PROG (CLK, huif); //edited, do i declare another reg_file_if??
  // DUT
`ifndef MAPPED
  hazard_unit DUT (huif);
`else
  hazard_unit DUT(
    .\huif.IDEX_tmpPC (huif.IDEX_tmpPC),
    .\huif.EXMEM_tmpPC (huif.EXMEM_tmpPC),
    .\huif.destMEM (huif.destMEM),
    .\huif.destEX (huif.destEX),
    .\huif.rt (huif.rt),
    .\huif.rs (huif.rs),
    .\huif.flush_IDEX (huif.flush_IDEX),
    .\huif.flush_IFID (huif.flush_IFID),
    .\huif.stall_PC (huif.stall_PC),
    .\huif.stall_IFID (huif.stall_IFID),
    .\huif.PCSrc (huif.PCSrc),
    .\huif.tmpPC (huif.tmpPC)
  );
`endif

endmodule

//tmppc
//0: pc+4
//1: b
//2: j / jal
//3: jr
program test(input logic CLK, hazard_unit_if.tb huif);
  initial begin
    // initialize test input signals
    huif.IDEX_tmpPC = '0;
    huif.EXMEM_tmpPC = '0;
    huif.destMEM = '0;
    huif.destEX = '0;
    huif.rt = '0;
    huif.rs = '0;
    huif.tmpPC = '0;
    huif.PCSrc = '0;
    @(posedge CLK);

   //RAW dependency between IFID and IDEX
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("RAW IFID - IDEX error");

   //RAW dependency between IFID and EXMEM
   huif.rs = 1;
   huif.destMEM = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("RAW IFID - EXMEM error");

   huif.IDEX_tmpPC = '0;
   huif.EXMEM_tmpPC = '0;
   huif.destMEM = '0;
   huif.destEX = '0;
   huif.rt = '0;
   huif.rs = '0;
   huif.tmpPC = '0;
   huif.PCSrc = '0;

   //JUMP IN ID
   huif.tmpPC = 2;
   huif.destMEM = 31;
   huif.destEX = 31;   
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1)
    else $display("JUMP ID error");

   huif.tmpPC = 0;

   //JUMP IN EX
   huif.IDEX_tmpPC = 2;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1 & huif.flush_IDEX == 1)
    else $display("JUMP EX error");

   huif.IDEX_tmpPC = 0;

   //JUMP IN MEM
   huif.EXMEM_tmpPC = 2;
   huif.PCSrc = 2;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.flush_IFID == 1)
    else $display("JUMP MEM error");

   huif.EXMEM_tmpPC = 0;

   //BR IN ID no dependencies
   huif.tmpPC = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1)
    else $display("BR ID no depedencies error");

   huif.tmpPC = 0;

   //BR IN EX no dependencies
   huif.IDEX_tmpPC = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1 & huif.flush_IDEX == 1)
    else $display("BR EX no dependencies error");

   huif.IDEX_tmpPC = 0;

   //BR IN MEM no dependencies -- Taken
   huif.EXMEM_tmpPC = 1;
   huif.PCSrc = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IFID == 1 & huif.flush_IDEX == 1)
    else $display("BR MEM no dependencies error");

   //BR IN MEM no dependencies -- Not Taken
   huif.EXMEM_tmpPC = 1;
   huif.PCSrc = 0;
   @(posedge CLK);
   #2;
   assert(huif.stall_IFID == 1 & huif.flush_IDEX)
    else $display("BR MEM no dependencies error not taken");

   //BR IN ID dependencies
   huif.tmpPC = 1;
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR ID depedencies error");

   //BR IN EX dependencies
   huif.IDEX_tmpPC = 1;
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX dependencies error");

   //BR IN MEM no dependencies
   huif.EXMEM_tmpPC = 1;
   huif.rs = 1;
   huif.destMEM = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX dependencies error");
  end
endprogram
