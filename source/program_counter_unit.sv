`include "cpu_types_pkg.vh"
`include "program_counter_unit_if.vh"

import cpu_types_pkg::*;

module program_counter_unit (
  input logic CLK,
  input logic nRST,
  program_counter_unit_if.pcu pcuif
);

  word_t PC;
  word_t nextPC;
  word_t npc;

  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      PC <= '0;
    end else begin
      if(pcuif.ihit) begin
        PC <= nextPC;
      end else begin
        PC <= PC;
      end
    end
  end

  assign npc = PC + 4;
  always_comb begin
    unique casez (pcuif.PCSrc)
      0 : nextPC = npc;
      1 : nextPC = npc + ({{16{pcuif.imm16[15]}}, pcuif.imm16} << 2);
      2 : nextPC = {npc[31:28], pcuif.jaddr, 2'b00};
      3 : nextPC = pcuif.reg31;
    endcase
  end

  assign pcuif.imemaddr = PC;
endmodule
