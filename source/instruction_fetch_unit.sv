`include "cpu_types_pkg.vh"
`include "instruction_fetch_unit_if.vh"

import cpu_types_pkg::*;

module instruction_fetch_unit (
  input logic CLK,
  input logic nRST,
  instruction_fetch_unit_if.ifu ifuif
);

  logic [31:0] PC;
  logic [31:0] nextPC;
  logic [31:0] npc;

  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      PC <= '0;
    end else begin
      PC <= nextPC;
    end
  end

  always_comb begin
    npc = PC + 4;
    unique casez (ifuif.PCSrc)
      3'b000 : nextPC = PC;
      3'b001 : nextPC = npc;
      3'b010 : nextPC = npc + ({16'h0000, ifuif.imm16} << 2);
      3'b011 : nextPC = {npc[31:28], ifuif.jaddr, 2'b00};
      3'b100 : nextPC = ifuif.reg31;
    endcase
  end

  assign ifuif.imemaddr = PC;
endmodule
