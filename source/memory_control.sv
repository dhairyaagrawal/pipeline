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
  parameter CPUS = 2;
  
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      ccif.iload <= '0;
      ccif.dload <= '0;
    end else if(ccif.dREN & ccif.ramstate == ACCESS) begin
      ccif.dload <= ccif.ramload;
      ccif.dwait = 1'b0;
      ccif.ramREN = 1'b0;
    end else if(ccif.iREN & ccif.ramstate == ACCESS) begin
      ccif.iload <= ccif.ramload;
      ccif.iwait = 1'b0;
      ccif.ramREN = 1'b0;
    end
  end

  always_comb begin
    ccif.ramWEN = 1'b0;
    ccif.ramREN = 1'b0;
    ccif.ramaddr = '0;
    ccif.ramstore = '0;
    if(ccif.dREN) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramREN = 1'b1;

      ccif.iwait = 1'b1;
      ccif.dwait = 1'b1;
    end else if(ccif.iREN) begin
      ccif.ramaddr = ccif.iaddr;
      ccif.ramREN = 1'b1;
    end  
endmodule
