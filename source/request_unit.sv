`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

import cpu_types_pkg::*;

module request_unit (
  input logic CLK,
  input logic nRST,
  request_unit_if.ru ruif
);

  assign ruif.imemREN = ruif.imemreq;
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      ruif.dmemWEN <= 0;
      ruif.dmemREN <= 0;
    end else if(ruif.dhit) begin
      ruif.dmemWEN <= 0;
      ruif.dmemREN <= 0;
    end else if(ruif.ihit) begin
      ruif.dmemWEN <= ruif.dmemwreq; //write request forward
      ruif.dmemREN <= ruif.dmemreq;  //read request forward
    end
  end
endmodule
