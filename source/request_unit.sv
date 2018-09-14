`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

import cpu_types_pkg::*;

module request_unit (
  input logic CLK,
  input logic nRST,
  request_unit_if.ru ruif
);
  logic n_WEN;
  logic n_REN;
  logic reg_WEN;
  logic reg_REN;

  //assign ruif.imemREN = ruif.imemreq;
  /*always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      ruif.dmemWEN <= 0;
      ruif.dmemREN <= 0;
    end else begin
      ruif.dmemWEN <= ruif.dmemWEN;
      ruif.dmemREN <= ruif.dmemREN;
      if(ruif.dhit) begin
        ruif.dmemWEN <= 0;
        ruif.dmemREN <= 0;
      end else if(ruif.ihit) begin
        ruif.dmemWEN <= ruif.dmemwreq; //write request forward
        ruif.dmemREN <= ruif.dmemreq;  //read request forward
      end
    end
  end*/

  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      reg_WEN <= 0;
      reg_REN <= 0;
    end else begin
      reg_WEN <= n_WEN;
      reg_REN <= n_REN;
    end
  end

  always_comb begin
    n_WEN = reg_WEN;
    n_REN = reg_REN;
    if(ruif.dhit) begin
      n_WEN = 0;
      n_REN = 0;
    end else if(ruif.ihit) begin
      n_WEN = ruif.dmemwreq; //write request forward
      n_REN = ruif.dmemreq;  //read request forward
    end
  end

  assign ruif.dmemWEN = reg_WEN;
  assign ruif.dmemREN = reg_REN;

endmodule
