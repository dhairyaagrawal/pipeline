`ifndef PROGRAM_COUNTER_UNIT_IF_VH
`define PROGRAM_COUNTER_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_unit_if;
  // import types
  import cpu_types_pkg::*;

  word_t reg31;
  logic [1:0] PCSrc;
  logic [25:0] jaddr;
  logic [15:0] imm16;
  word_t    imemaddr;
  logic ihit;
  
  // counter unit ports
  modport pcu (
    input   reg31, jaddr, imm16, PCSrc, ihit,
    output  imemaddr
  );
  // counter unit tb
  modport tb (
    output   reg31, jaddr, imm16, PCSrc, ihit,
    input    imemaddr
  );
endinterface

`endif //PROGRAM_COUNTER_UNIT_IF_VH