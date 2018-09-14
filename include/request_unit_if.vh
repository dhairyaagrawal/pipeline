`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic     ihit, dhit, dmemreq, dmemwreq, dmemREN, dmemWEN; //imemreq,imemREN deleted

  // request unit ports
  modport ru (
    input   ihit, dhit, dmemreq, dmemwreq,
    output  dmemREN, dmemWEN
  );
  // request unit tb
  modport tb (
    input   dmemREN, dmemWEN,
    output  ihit, dhit, dmemreq, dmemwreq
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
