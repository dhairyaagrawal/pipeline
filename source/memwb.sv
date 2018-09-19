`include "cpu_types_pkg.vh"
`include "memwb_if.vh"

import cpu_types_pkg::*;

module memwb (
  input logic CLK,
  input logic nRST,
  memwb_if.mw memwbif
);

  always_ff@(posedge CLK, negedge nrst) begin
    if(nrst == 0) begin
      memwb.dmemload_out = '0;
      memwb.aluout_out = '0;
      memwb.imm_out = '0;
      memwb.npc_out = '0;
      memwb.dest_out = '0;
      memwb.WBctrl_out = '0;
    end else if(idexif.ihit == 1) begin
      memwb.dmemload_out = memwb.dmemload_in;
      memwb.aluout_out = memwb.aluout_in;
      memwb.imm_out = memwb.imm_in;
      memwb.npc_out = memwb.npc_in;
      memwb.dest_out = memwb.dest_in;
      memwb.WBctrl_out = memwb.WBctrl_in;
    //add dhit logic below here
    end

endmodule
