`ifndef CONTROL_FSM_IF_VH
`define CONTROL_FSM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_fsm_if;
  // import types
  import cpu_types_pkg::*;

  logic     dmemREN, dmemWEN, halt, dirty0, dirty1, miss, dwait, LRU, dREN, dWEN, storesel, flushing, control_offset, flushed, tagWEN;
  logic [25:0] tag0, tag1;
  word_t [1:0] data0, data1;
  word_t dmemaddr, daddr, store;
  logic [2:0] ct;
 
  // control fsm ports
  modport cf (
    input    dmemREN, dmemWEN, halt, dirty0, dirty1, miss, dwait, LRU, tag0, tag1, data0, data1, dmemaddr,
    output  dREN, dWEN, daddr, ct, store, storesel, flushing, control_offset, flushed, tagWEN
  );

  // control fsm tb
  modport tb (
    output  dmemREN, dmemWEN, halt, dirty0, dirty1, miss, dwait, LRU, tag0, tag1, data0, data1, dmemaddr,
    input  dREN, dWEN, daddr, ct, store, storesel, flushing, control_offset, flushed, tagWEN
  );
endinterface

`endif //CONTROL_FSM_IF_VH