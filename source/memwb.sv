`include "cpu_types_pkg.vh"
`include "memwb_if.vh"

import cpu_types_pkg::*;

module memwb (
  input logic CLK,
  input logic nRST,
  memwb_if.mw memwbif
);

  always_ff@(posedge CLK, negedge nRST) begin
    if(nRST == 0) begin
      memwbif.dmemload_out <= '0;
      memwbif.aluout_out <= '0;
      memwbif.imm_out <= '0;
      memwbif.npc_out <= '0;
      memwbif.dest_out <= '0;
      memwbif.WBctrl_out <= '0;
      memwbif.instr_out <= '0;
    /*end else if(memwbif.dmemREN || memwbif.dmemWEN) begin
      if(memwbif.dhit == 1) begin
        memwbif.dmemload_out <= memwbif.dmemload_in;
        memwbif.aluout_out <= memwbif.aluout_in;
        memwbif.imm_out <= memwbif.imm_in;
        memwbif.npc_out <= memwbif.npc_in;
        memwbif.dest_out <= memwbif.dest_in;
        memwbif.WBctrl_out <= memwbif.WBctrl_in;
        memwbif.instr_out <= memwbif.instr_in;
      end
    end*/
    end else if(memwbif.ihit == 1) begin
      memwbif.dmemload_out <= memwbif.dmemload_in;
      memwbif.aluout_out <= memwbif.aluout_in;
      memwbif.imm_out <= memwbif.imm_in;
      memwbif.npc_out <= memwbif.npc_in;
      memwbif.dest_out <= memwbif.dest_in;
      memwbif.WBctrl_out <= memwbif.WBctrl_in;
      memwbif.instr_out <= memwbif.instr_in;
    end
  end

  always_comb begin

  end

endmodule
