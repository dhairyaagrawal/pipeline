/*
  memwb interface
*/
`ifndef MEMWB_IF_VH
`define MEMWB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memwb_if;
  // import types
  import cpu_types_pkg::*;

  word_t dmemload_in, dmemload_out, aluout_in, aluout_out, npc_in, npc_out;
  word_t instr_in, instr_out;
  logic [15:0] imm_in, imm_out;
  logic [4:0] dest_in, dest_out;
  logic [3:0] WBctrl_in, WBctrl_out;
  logic ihit, dhit;

  // memwb ports
  modport mw (
    input dmemload_in, aluout_in, npc_in, imm_in, dest_in, WBctrl_in, ihit,
      dhit, instr_in,
    output dmemload_out, aluout_out, npc_out, imm_out, dest_out, WBctrl_out,
instr_out
  );
  // memwb tb
  modport tb (
    output dmemload_in, aluout_in, npc_in, imm_in, dest_in, WBctrl_in, ihit,
      dhit, instr_in,
    input dmemload_out, aluout_out, npc_out, imm_out, dest_out, WBctrl_out,
instr_out
  );
endinterface

`endif //MEMWB_IF_VH
