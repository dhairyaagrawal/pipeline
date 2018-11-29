`include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"

import cpu_types_pkg::*;

module forward_unit (
  forward_unit_if.fu fuif
);

  always_comb begin
    fuif.selA = '0;
    fuif.selB = '0;
    if((fuif.rsEX == fuif.destMEM) & fuif.destMEM != 0 & fuif.wenMEM) begin
      fuif.selA = 1;
    end else if((fuif.rsEX == fuif.destWB) & fuif.destWB != 0 & fuif.wenWB) begin
      fuif.selA = 2;
    end

    //if(fuif.opcodeEX == RTYPE || fuif.opcodeEX == JAL || fuif.opcodeEX == J || fuif.opcode == BEQ || fuif.opcode == BNE) begin
    if((fuif.rtEX == fuif.destMEM) & fuif.destMEM != 0 & fuif.wenMEM) begin
      fuif.selB = 1;
    end else if((fuif.rtEX == fuif.destWB) & fuif.destWB != 0 & fuif.wenWB) begin
      fuif.selB = 2;
    end
  end
endmodule
