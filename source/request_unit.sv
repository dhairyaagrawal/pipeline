`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

import cpu_types_pkg::*;

module request_unit (
  request_unit_if.ru ruif
);

  assign ruif.dmemWEN = (ruif.dhit == 1'b1) ? 0 : ruif.dmemwreq;
  assign ruif.dmemREN = (ruif.dhit == 1'b1) ? 0 : ruif.dmemreq;
  assign ruif.imemREN = (ruif.ihit == 1'b1) ? 0 : ruif.imemreq;

endmodule
