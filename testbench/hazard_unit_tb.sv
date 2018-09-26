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
  hazard_unit DUT(CLK, huif);
`else
  hazard_unit DUT(
    .\huif.instr (huif.instr),
    .\huif.IDEX_tempPC (huif.IDEX_tempPC),
    .\huif.EXMEM_tempPC (huif.EXMEM_tempPC),
    .\huif.destMEM (huif.destMEM),
    .\huif.destEX (huif.destEX),
    .\huif.rt (huif.rt),
    .\huif.rs (huif.rs),
    .\huif.flush_IDEX (huif.flush_IDEX),
    .\huif.flush_IFID (huif.flush_IFID),
    .\huif.stall_PC (huif.stall_PC),
    .\huif.stall_IFID (huif.stall_IFID)
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
    huif.instr = '0;
    huif.IDEX_tempPC = '0;
    huif.EXMEM_tempPC = '0;
    huif.destMEM = '0;
    huif.destEX = '0;
    huif.rt = '0;
    huif.rs = '0;
    @(posedge CLK);

   //RAW dependency between IFID and IDEX
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("RAW IFID - IDEX error")

   //RAW dependency between IFID and EXMEM
   huif.rs = 1;
   huif.destMEM = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("RAW IFID - EXMEM error")

   //JUMP IN ID
   huif.tmpPC = 2;
   @(posedge CLK);
   #2;
   assert(huif.flush_IFID == 1 & huif.stall_PC == 1)
    else $display("JUMP ID error")

   //JUMP IN EX
   huif.IDEX_tmpPC = 2;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("JUMP EX error")

   //JUMP IN MEM
   huif.EXMEM_tmpPC = 2;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("JUMP EX error")

   //BR IN ID no dependencies
   huif.tmpPC = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IFID == 1 & huif.stall_PC == 1)
    else $display("BR ID no depedencies error")

   //BR IN EX no dependencies
   huif.IDEX_tmpPC = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX no dependencies error")

   //BR IN MEM no dependencies
   huif.EXMEM_tmpPC = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX no dependencies error")

   //BR IN ID dependencies
   huif.tmpPC = 1;
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.flush_IDEX == 1 & huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR ID depedencies error")

   //BR IN EX dependencies
   huif.IDEX_tmpPC = 1;
   huif.rs = 1;
   huif.destEX = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX dependencies error")

   //BR IN MEM no dependencies
   huif.EXMEM_tmpPC = 1;
   huif.rs = 1;
   huif.destMEM = 1;
   @(posedge CLK);
   #2;
   assert(huif.stall_PC == 1 & huif.stall_IFID == 1)
    else $display("BR EX dependencies error")
  end
endprogram
