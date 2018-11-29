`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

import cpu_types_pkg::*;

module hazard_unit (
  hazard_unit_if.hu huif
);

  always_comb begin
    huif.stall_PC = 1'b0;
    huif.stall_IFID = 1'b0;
    huif.flush_IFID = 1'b0;
    huif.flush_IDEX = 1'b0;
    if((huif.rs == huif.destEX | huif.rt == huif.destEX) & huif.destEX != 0 & (huif.dmemREN || huif.opcodeEX == SC)) begin
      huif.stall_PC = 1'b1;
      huif.stall_IFID = 1'b1;
      huif.flush_IDEX = 1'b1;
    end else if(huif.EXMEM_tmpPC != 0 & huif.EXMEM_tmpPC == huif.PCSrc) begin //branch taken
      huif.flush_IFID = 1'b1;
      huif.flush_IDEX = 1'b1;
    end else if(huif.EXMEM_tmpPC != 0 & huif.EXMEM_tmpPC != huif.PCSrc) begin //branch not taken
      huif.stall_IFID = 1'b1;
      huif.flush_IDEX = 1'b1;
    end else if(huif.IDEX_tmpPC != 0) begin
      huif.stall_PC = 1'b1;
      huif.stall_IFID = 1'b1;
      huif.flush_IDEX = 1'b1;
    end else if(huif.tmpPC != 0) begin
      huif.stall_PC = 1'b1;
    end
  end

endmodule
