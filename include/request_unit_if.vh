`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic     ihit, dhit, dmemreq, imemreq, dmemwreq, imemREN, dmemREN, dmemWEN;

  // request unit ports
  modport ru (
    input   ihit, dhit, dmemreq, imemreq, dmemwreq,
    output  imemREN, dmemREN, dmemWEN
  );
  // request unit tb
  modport tb (
    input   imemREN, dmemREN, dmemWEN,
    output  ihit, dhit, dmemreq, imemreq, dmemwreq
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
