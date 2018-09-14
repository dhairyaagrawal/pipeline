/*
  control unit test bench
*/

// mapped needs this
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module control_unit_tb;

  // interface
  control_unit_if cuif ();

  // test program
  test PROG (cuif);

  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`else
  control_unit DUT(
    .\cuif.zero (cuif.zero),
    .\cuif.overflow (cuif.overflow),
    .\cuif.negative (cuif.negative),
    .\cuif.opcode (cuif.opcode),
    .\cuif.funct (cuif.funct),
    //outputs now
    .\cuif.dmemreq (cuif.dmemreq),
    .\cuif.imemreq (cuif.imemreq),
    .\cuif.dmemwreq (cuif.dmemwreq),
    .\cuif.PCSrc (cuif.PCSrc),
    .\cuif.RegWEN (cuif.RegWEN),
    .\cuif.RegDest (cuif.RegDest),
    .\cuif.ExtOp (cuif.ExtOp),
    .\cuif.ALUSrc (cuif.ALUSrc),
    .\cuif.ALUOP (cuif.ALUOP),
    .\cuif.MemtoReg (cuif.MemtoReg),
    .\cuif.halt (cuif.halt)
  );
`endif

endmodule

program test(control_unit_if.tb cuif);
  import cpu_types_pkg::*;
  initial begin
    // initialize inactive input signals
    cuif.negative = 0;
    cuif.overflow = 0;

//dmemreq, imemreq, dmemwreq, PCSrc, RegWEN, RegDest, ExtOp, ALUSrc, MemtoReg, halt
  //R-TYPES - use funct
    $display("R-TYPE tests");
    //ADD
    cuif.opcode = RTYPE;
    cuif.funct = ADD;
    cuif.zero = 0;
    #5;
    check_out(0,1,0,0,1,0,1,0,0,0);
    if(cuif.ALUOP != ALU_ADD) begin
      $display("ALUOP error");
    end

    //SUB
    cuif.funct = SUB;
    #5;
    check_out(0,1,0,0,1,0,1,0,0,0);
    if(cuif.ALUOP != ALU_SUB) begin
      $display("ALUOP error");
    end

    //XOR
    cuif.funct = XOR;
    #5;
    check_out(0,1,0,0,1,0,1,0,0,0);
    if(cuif.ALUOP != ALU_XOR) begin
      $display("ALUOP error");
    end

    //SLT
    cuif.funct = SLT;
    #5;
    check_out(0,1,0,0,1,0,1,0,0,0);
    if(cuif.ALUOP != ALU_SLT) begin
      $display("ALUOP error");
    end

    //SLLV
    cuif.funct = SLLV;
    #5;
    check_out(0,1,0,0,1,0,1,0,0,0);
    if(cuif.ALUOP != ALU_SLL) begin
      $display("ALUOP error");
    end
    
    //JR
    cuif.funct = JR;
    #5;
    check_out(0,1,0,3,0,0,1,0,0,0);

  //I-TYPES
    $display("I-TYPE tests");
    //ADDIU
    cuif.opcode = ADDIU;
    #5;
    check_out(0,1,0,0,1,1,1,1,0,0);
    if(cuif.ALUOP != ALU_ADD) begin
      $display("ALUOP error");
    end

    //BEQ
    cuif.opcode = BEQ;
    cuif.zero = 1;
    #5;
    check_out(0,1,0,1,0,1,1,0,0,0);
    if(cuif.ALUOP != ALU_SUB) begin
      $display("ALUOP error");
    end

    //BNE
    cuif.opcode = BNE;
    cuif.zero = 1;
    #5;
    check_out(0,1,0,0,0,1,1,0,0,0);
    if(cuif.ALUOP != ALU_SUB) begin
      $display("ALUOP error");
    end

    //LUI
    cuif.opcode = LUI;
    #5;
    check_out(0,1,0,0,1,1,1,1,2,0);

    //LW
    cuif.opcode = LW;
    #5;
    check_out(1,1,0,0,1,1,1,1,1,0);
    if(cuif.ALUOP != ALU_ADD) begin
      $display("ALUOP error");
    end

    //SW
    cuif.opcode = SW;
    #5;
    check_out(0,1,1,0,0,1,1,1,0,0);
    if(cuif.ALUOP != ALU_ADD) begin
      $display("ALUOP error");
    end

    //ANDI
    cuif.opcode = ANDI;
    #5;
    check_out(0,1,0,0,1,1,0,1,0,0);
    if(cuif.ALUOP != ALU_AND) begin
      $display("ALUOP error");
    end

    //SLTIU
    cuif.opcode = SLTIU;
    #5;
    check_out(0,1,0,0,1,1,1,1,0,0);
    if(cuif.ALUOP != ALU_SLTU) begin
      $display("ALUOP error");
    end

  //J-TYPES
    $display("J-TYPE tests");
    //J
    cuif.opcode = J;
    #5;
    check_out(0,1,0,2,0,1,1,1,0,0);

    //JAL
    cuif.opcode = JAL;
    #5;
    check_out(0,1,0,2,1,2,1,1,3,0);
  end

  task check_out(dmemreq, imemreq, dmemwreq, [1:0]PCSrc, RegWEN, [1:0]RegDest, ExtOp, ALUSrc, [1:0]MemtoReg, halt);
    if(cuif.dmemreq != dmemreq) begin
      $display("dmemreq error");
    end
    if(cuif.imemreq != imemreq) begin
      $display("imemreq error");
    end
    if(cuif.dmemwreq != dmemwreq) begin
      $display("dmemwreq error");
    end
    if(cuif.PCSrc != PCSrc) begin
      $display("PCSrc error");
    end
    if(cuif.RegWEN != RegWEN) begin
      $display("RegWEN error");
    end
    if(cuif.RegDest != RegDest) begin
      $display("RegDest error");
    end
    if(cuif.ExtOp != ExtOp) begin
      $display("ExtOp error");
    end
    if(cuif.ALUSrc != ALUSrc) begin
      $display("ALUSrc error");
    end
    if(cuif.MemtoReg != MemtoReg) begin
      $display("MemtoReg error");
    end
    if(cuif.halt != halt) begin
      $display("halt error");
    end
  endtask

/*  task set_init(opcode, funct, zero);
    cuif.opcode = opcode_t'(opcode);
    cuif.funct = funct_t'(funct);
    cuif.zero = zero;
  endtask*/
endprogram
