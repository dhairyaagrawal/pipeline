`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forward_unit_if;
  import cpu_types_pkg::*;

  logic      wenMEM, wenWB;
  logic [4:0] rsEX, rtEX, destWB, destMEM;
  logic [1:0] selA, selB;
  opcode_t opcodeMEM, opcodeWB;

  // control unit ports
  modport fu (
    output   selA, selB,
    input    rsEX, rtEX, destWB, destMEM, wenMEM, wenWB, opcodeMEM, opcodeWB
  );
  // control unit tb
  modport tb (
    input   selA, selB,
    output  rsEX, rtEX, destWB, destMEM, wenMEM, wenWB, opcodeMEM, opcodeWB
  );
endinterface

`endif //FORWARD_UNIT_IF_VH
