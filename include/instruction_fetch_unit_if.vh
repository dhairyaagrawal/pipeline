`ifndef INSTRUCTION_FETCH_UNIT_IF_VH
`define INSTRUCTION_FETCH_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface instruction_fetch_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic [31:0] reg31;
  logic [2:0] PCSrc
  logic [25:0] jaddr;
  logic [15:0] imm16;
  word_t    imemaddr;
  
  // fetch unit ports
  modport ifu (
    input   reg31, jaddr, imm16, PCSrc
    output  imemaddr
  );
  // fetch unit tb
  modport tb (
    output   reg31, jaddr, imm16, PCSrc
    input    imemaddr
  );
endinterface

`endif //INSTRUCTION_FILE_IF_VH