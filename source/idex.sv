`include "cpu_types_pkg.vh"
`include "idex_if.vh"

import cpu_types_pkg::*;

module idex (
  input logic CLK,
  input logic nRST,
  idex_if.ru idexif
);

  always_ff@(posedge CLK, negedge nrst) begin
    if(nrst == 0) begin
      idexif.rdat1_out <= '0;
      idexif.rdat2_out <= '0;
      idexif.addr_out <= '0;
      idexif.npc_out <= '0;
      idexif.WBctrl_out <= '0;
      idexif.MEMctrl_out <= '0;
      idexif.EXctrl_out <= '0;
    end else if(idexif.ihit == 1) begin
      idexif.rdat1_out <= idexif.rdat1_in;
      idexif.rdat2_out <= idexif.rdat2_in;
      idexif.addr_out <= idexif.addr_in;
      idexif.npc_out <= idexif.npc_in;
      idexif.WBctrl_out <= idexif.WBctrl_in;
      idexif.MEMctrl_out <= idexif.MEMctrl_in;
      idexif.EXctrl_out <= idexif.EXctrl_in;
    end

endmodule
