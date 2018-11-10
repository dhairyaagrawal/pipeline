`ifndef ACCESS_LOGIC_IF_VH
`define ACCESS_LOGIC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface access_logic_if;
  // import types
  import cpu_types_pkg::*;

  logic     dmemREN, dmemWEN, offset, valid0, valid1, miss, setsel, WENcache, halt; //imemreq,imemREN deleted
  logic ccinv, cctrans, ccwrite, snoop, newValid, newDirty, mytrans, dirty0, dirty1;
  logic [25:0] tagbits, tag0, tag1;
  word_t [1:0] data0, data1;
  word_t data_out;
 
  // request unit ports
  modport al (
    input    dmemREN, dmemWEN, offset, valid0, valid1, tagbits, tag0, tag1, data0, data1, halt, ccinv, snoop, mytrans, dirty0, dirty1,
    output  miss, setsel, WENcache, data_out, cctrans, ccwrite, newValid, newDirty
  );
  // request unit tb
  modport tb (
    output    dmemREN, dmemWEN, offset, valid0, valid1, tagbits, tag0, tag1, data0, data1, halt, ccinv, snoop, mytrans, dirty0, dirty1,
    input  miss, setsel, WENcache, data_out, cctrans, ccwrite, newValid, newDirty
  );
endinterface

`endif //ACCESS_LOGIC_IF_VH