/*
  Eric Villasenor
  evillase@gmail.com

  alu interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic     negative, overflow, zero;
  aluop_t   ALUOP;
  word_t    portA, portB, outputport;

  // alu ports
  modport rf (
    input   portA, portB, ALUOP,
    output  negative, overflow, zero, outputport
  );
  // alu tb
  modport tb (
    output  portA, portB, ALUOP,
    input   negative, overflow, zero, outputport
  );
endinterface

`endif //ALU_IF_VH
