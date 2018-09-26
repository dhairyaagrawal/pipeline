`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;

  logic      stall_IFID, stall_PC, flush_IFID, flush_IDEX;
  logic [1:0] tmpPC, IDEX_tmpPC, EXMEM_tmpPC, PCSrc;
  logic [4:0] rs, rt, destEX, destMEM;

  // control unit ports
  modport hu (
    output   stall_IFID, stall_PC, flush_IFID, flush_IDEX,
    input    tmpPC, IDEX_tmpPC, EXMEM_tmpPC, rs, rt, destEX, destMEM, PCSrc
  );
  // control unit tb
  modport tb (
    input   stall_IFID, stall_PC, flush_IFID, flush_IDEX,
    output  tmpPC, IDEX_tmpPC, EXMEM_tmpPC, rs, rt, destEX, destMEM, PCSrc
  );
endinterface

`endif //HAZARD_UNIT_IF_VH
