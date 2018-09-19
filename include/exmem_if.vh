/*
  exmem interface
*/
`ifndef EXMEM_IF_VH
`define EXMEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface exmem_if;
  // import types
  import cpu_types_pkg::*;

  word_t store_in, store_out, aluout_in, aluout_out, baddr_in, baddr_out;
  word_t jaddr_in, jaddr_out, reg31_in, reg31_out, npc_in, npc_out;
  logic [4:0] dest_in, dest_out;
  logic [15:0] imm_in, imm_out;
  logic zero_in, zero_out;
  logic [3:0] WBctrl_in, WBctrl_out;
  logic [4:0] MEMctrl_in, MEMctrl_out;
  logic ihit;

  // exmem ports
  modport rf (
    input   store_in, aluout_in, baddr_in, jaddr_in, reg31_in, npc_in, dest_in,
      imm_in, zero_in, WBctrl_in, MEMctrl_in, ihit,
    output  store_out, aluout_out, baddr_out, jaddr_out, reg31_out, npc_out,
      dest_out, imm_out, zero_out, WBctrl_out, MEMctrl_out
  );
  // exmem tb
  modport tb (
    output   store_in, aluout_in, baddr_in, jaddr_in, reg31_in, npc_in, dest_in,
      imm_in, zero_in, WBctrl_in, MEMctrl_in, ihit,
    input  store_out, aluout_out, baddr_out, jaddr_out, reg31_out, npc_out,
      dest_out, imm_out, zero_out, WBctrl_out, MEMctrl_out
  );
endinterface

`endif //EXMEM_IF_VH

