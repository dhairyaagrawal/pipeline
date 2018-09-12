`include "cpu_types_pkg.vh"
`include "alu_if.vh"

import cpu_types_pkg::*;

module alu
(
  alu_if.rf aluif
);

  logic over;
  word_t out;

  assign aluif.zero = (aluif.outputport == '0) ? 1'b1 : 1'b0;
  assign aluif.negative = out[31];
  assign aluif.overflow = over;
  assign aluif.outputport = out;
  always_comb begin
    over = 1'b0;
    out = '0;
    casez(aluif.ALUOP)
      ALU_SLL:  out = aluif.portB<<aluif.portA;//changed this
      ALU_SRL:  out = aluif.portB>>aluif.portA;//changed this

      ALU_ADD:  begin
                out = aluif.portA + aluif.portB;
                if (aluif.portA[31] == 1'b0 & aluif.portB[31] == 1'b0 & out[31] == 1'b1) begin
                  over = 1'b1;
                end
                else if(aluif.portA[31] == 1'b1 & aluif.portB[31] == 1'b1 & out[31] == 1'b0) begin
                   over =1'b1;
                end
      end

      ALU_SUB:  begin
                out = aluif.portA - aluif.portB;
                if (aluif.portA[31] == 1'b1 & aluif.portB[31] == 1'b0 & out[31] == 1'b0) begin
                  over = 1'b1;
                end
                else if(aluif.portA[31] == 1'b0 & aluif.portB[31] == 1'b1 & out[31] == 1'b1) begin
                   over =1'b1;
                end
      end
      ALU_AND:  begin
                  out = aluif.portA & aluif.portB;
      end
      ALU_OR:   begin
                  out = aluif.portA | aluif.portB;
      end
      ALU_XOR:  begin
                  out = aluif.portA ^ aluif.portB;
      end
      ALU_NOR:  begin
                  out = ~(aluif.portA | aluif.portB);
      end
      ALU_SLT:  begin
                  if($signed(aluif.portA) < $signed(aluif.portB)) begin
                    out = 1;
                  end
      end
      ALU_SLTU: begin
                  if(aluif.portA < aluif.portB) begin
                    out = 1;
                  end
      end
    endcase
  end
endmodule
