/*
  idex interface
*/
`ifndef IDEX_IF_VH
`define IDEX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface idex_if;
  // import types
  import cpu_types_pkg::*;

  word_t rdat1_in, rdat2_in, rdat1_out, rdat2_out;
  word_t npc_in, npc_out;
  logic [25:0] addr_in, addr_out;
  logic [3:0] WBctrl_in, WBctrl_out;
  logic [4:0] MEMctrl_in, MEMctrl_out;
  logic [7:0] EXctrl_in, EXctrl_out;
  logic ihit;

  // idex ports
  modport rf (
    input   rdat1_in, rdat2_in, npc_in, WBctrl_in, MEMctrl_in, EXctrl_in, ihit
    output  rdat1_out, rdat2_out, npc_out, WBctrl_out, MEMctrl_out, EXctrl_out
  );
  // idex tb
  modport tb (
    output   rdat1_in, rdat2_in, npc_in, WBctrl_in, MEMctrl_in, EXctrl_in, ihit
    input  rdat1_out, rdat2_out, npc_out, WBctrl_out, MEMctrl_out, EXctrl_out
  );
endinterface

`endif //idex_IF_VH

