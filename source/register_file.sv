`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

import cpu_types_pkg::*;

module register_file
(
  input logic CLK,
  input logic nRST,
  register_file_if.rf rfif
);

  word_t [31:0] my_reg;

  always_ff@(negedge CLK, negedge nRST) begin
    if(!nRST) begin
      my_reg <= '0;
    end
    else if(rfif.WEN && rfif.wsel != 0) begin
      my_reg[rfif.wsel] <= rfif.wdat;
    end
  end

  assign rfif.rdat1 = my_reg[rfif.rsel1];
  assign rfif.rdat2 = my_reg[rfif.rsel2];

endmodule
