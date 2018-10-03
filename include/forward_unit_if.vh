`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forward_unit_if;

  logic      wenMEM, wenWB;
  logic [4:0] rsEX, rtEX, destWB, destMEM;
  logic [1:0] selA, selB;

  // control unit ports
  modport fu (
    output   selA, selB,
    input    rsEX, rtEX, destWB, destMEM, wenMEM, wenWB
  );
  // control unit tb
  modport tb (
    input   selA, selB,
    output  rsEX, rtEX, destWB, destMEM, wenMEM, wenWB
  );
endinterface

`endif //FORWARD_UNIT_IF_VH
