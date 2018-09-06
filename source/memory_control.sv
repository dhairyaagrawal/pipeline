/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1; //set in tb when instantiating this module

  assign ccif.iload = ccif.ramload; //right??
  assign ccif.dload = ccif.ramload; //right??

  assign ccif.ramstore = ccif.dstore;
  assign ccif.ramaddr = (ccif.dREN | ccif.dWEN) ? ccif.daddr : ccif.iaddr;
  assign ccif.ramWEN = ccif.dWEN;
  assign ccif.ramREN = ((ccif.iREN | ccif.dREN) && ~ccif.dWEN) ? 1'b1 : 1'b0;
  
  always_comb begin
    ccif.dwait = 1'b1;
    ccif.iwait = 1'b1;
    if((ccif.dREN | ccif.dWEN) && ccif.ramstate == ACCESS) begin
      ccif.dwait = 1'b0;
    end else if(ccif.iREN && ccif.ramstate == ACCESS) begin
      ccif.iwait = 1'b0;
    end
  end

endmodule
