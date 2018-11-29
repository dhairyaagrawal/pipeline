`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
import cpu_types_pkg::*;

  logic      stall_IFID, stall_PC, flush_IFID, flush_IDEX, dmemREN;
  logic [1:0] tmpPC, IDEX_tmpPC, EXMEM_tmpPC, PCSrc;
  logic [4:0] rs, rt, destEX;
  opcode_t opcodeEX;

  // control unit ports
  modport hu (
    output   stall_IFID, stall_PC, flush_IFID, flush_IDEX,
    input    tmpPC, IDEX_tmpPC, EXMEM_tmpPC, rs, rt, destEX, dmemREN, PCSrc, opcodeEX
  );
  // control unit tb
  modport tb (
    input   stall_IFID, stall_PC, flush_IFID, flush_IDEX,
    output  tmpPC, IDEX_tmpPC, EXMEM_tmpPC, rs, rt, destEX, dmemREN, PCSrc, opcodeEX
  );
endinterface

`endif //HAZARD_UNIT_IF_VH
