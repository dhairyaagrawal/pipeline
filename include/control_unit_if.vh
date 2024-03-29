`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic      RegWEN, ALUSrc, ExtOp, zero, overflow, negative, dmemREN, dmemWEN, halt, branch, lui; //imemreq to imemREN chnaged
  logic [1:0] tmpPC;
  logic [1:0] RegDest, MemtoReg;
  opcode_t  opcode;
  funct_t   funct;
  aluop_t   ALUOP;

  // control unit ports
  modport cu (
    output   dmemWEN, dmemREN, tmpPC, RegWEN, RegDest, ExtOp, ALUSrc, ALUOP, MemtoReg, halt, branch, lui, 
    input    zero, overflow, negative, opcode, funct
  );
  // control unit tb
  modport tb (
    input   dmemWEN, dmemREN, tmpPC, RegWEN, RegDest, ExtOp, ALUSrc, ALUOP, MemtoReg, halt, branch, lui,
    output  zero, overflow, negative, opcode, funct
  );
endinterface

`endif //CONTROL_UNIT_IF_VH
