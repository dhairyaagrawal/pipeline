`ifndef ICACHE_IF_VH
`define ICACHE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface icache_if;
  // import types
  import cpu_types_pkg::*;

  logic miss;
  icache_frame [15:0] icacheFrame;


  // alu ports
  modport icache (
    input miss, icacheFrame
  );
  // alu tb
  modport tb (
    output miss, icacheFrame
  );
endinterface

`endif //ALU_IF_VH
