`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

import cpu_types_pkg::*;

module register_file
(
  input logic CLK,
  input logic nRST,
  register_file_if.rf my_rf
);

  word_t [31:0] my_reg;

  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      my_reg <= '0;
    end
    else if(my_rf.WEN && my_rf.wsel != 0) begin
      my_reg[my_rf.wsel] <= my_rf.wdat;
    end
  end

  assign my_rf.rdat1 = my_reg[my_rf.rsel1];
  assign my_rf.rdat2 = my_reg[my_rf.rsel2];

endmodule
