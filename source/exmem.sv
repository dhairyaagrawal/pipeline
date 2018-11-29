`include "cpu_types_pkg.vh"
`include "exmem_if.vh"

import cpu_types_pkg::*;

module exmem (
  input logic CLK,
  input logic nRST,
  exmem_if.em exmemif
);

  always_ff@(posedge CLK, negedge nRST) begin
    if(nRST == 0) begin
      exmemif.datomic_out <= '0;
      exmemif.store_out <= '0;
      exmemif.aluout_out <= '0;
      exmemif.dest_out <= '0;
      exmemif.imm_out <= '0;
      exmemif.baddr_out <= '0;
      exmemif.jaddr_out <= '0;
      exmemif.reg31_out <= '0;
      exmemif.zero_out <= '0;
      exmemif.WBctrl_out <= '0;
      exmemif.MEMctrl_out <= '0;
      exmemif.npc_out <= '0;
      exmemif.instr_out <= '0;
      exmemif.dmemload_out <= '0;
    end else if(exmemif.dhit) begin
      exmemif.MEMctrl_out[1:0] <= '0;
      exmemif.dmemload_out <= exmemif.dmemload_in;
    end else if(exmemif.ihit == 1) begin
      exmemif.datomic_out <= exmemif.datomic_in;
      exmemif.store_out <= exmemif.store_in;
      exmemif.aluout_out <= exmemif.aluout_in;
      exmemif.dest_out <= exmemif.dest_in;
      exmemif.imm_out <= exmemif.imm_in;
      exmemif.baddr_out <= exmemif.baddr_in;
      exmemif.jaddr_out <= exmemif.jaddr_in;
      exmemif.reg31_out <= exmemif.reg31_in;
      exmemif.zero_out <= exmemif.zero_in;
      exmemif.WBctrl_out <= exmemif.WBctrl_in;
      exmemif.MEMctrl_out <= exmemif.MEMctrl_in;
      exmemif.npc_out <= exmemif.npc_in;
      exmemif.instr_out <= exmemif.instr_in;
    end
  end
endmodule
