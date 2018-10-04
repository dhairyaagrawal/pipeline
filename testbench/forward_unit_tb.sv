/*
  forward unit test bench
*/

// mapped needs this
`include "forward_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forward_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  forward_unit_if fuif (); //shouldn't this be .rf??
  // test program
  test PROG (CLK, fuif); //edited, do i declare another reg_file_if??
  // DUT
`ifndef MAPPED
  forward_unit DUT (fuif);
`else
  forward_unit DUT(
    .\fuif.destMEM (fuif.destMEM),
    .\fuif.destWB (fuif.destWB),
    .\fuif.wenMEM (fuif.wenMEM),
    .\fuif.wenWB (fuif.wenWB),
    .\fuif.rtEX (fuif.rtEX),
    .\fuif.rsEX (fuif.rsEX),
    .\fuif.selA (fuif.selA),
    .\fuif.selB (fuif.selB)
  );
`endif

endmodule

program test(input logic CLK, forward_unit_if.tb fuif);
  initial begin

    @(negedge CLK);
    fuif.destMEM = '0;
    fuif.destWB = '0;
    fuif.wenMEM = '0;
    fuif.wenWB = '0;
    fuif.rtEX = '0;
    fuif.rsEX = '0;

    //rsEX == destMEM, wen = 0
    @(negedge CLK);
    fuif.rsEX = 5;
    fuif.destMEM = 5;
    fuif.wenMEM = 0;
    @(posedge CLK);
    #2;
    assert(fuif.selA == 0)
      else $display("Error rsEX == destMEM wen = 0");

    //rsEX == destMEM, wen = 1
    @(negedge CLK);
    fuif.wenMEM = 1;
    @(posedge CLK);
    #2;
    assert(fuif.selA == 1)
      else $display("Error rsEX == destMEM wen = 1");

    //rsEX == destWB, wen = 0
    @(negedge CLK);
    fuif.wenMEM = 0;
    fuif.destMEM = 0;
    fuif.destWB = 5;
    fuif.wenWB = 0;
    @(posedge CLK);
    #2;
    assert(fuif.selA == 0)
      else $display("Error rsEX == destWB wen = 0");

    //rsEX == destWB, wen = 1
    @(negedge CLK);
    fuif.wenWB = 1;
    @(posedge CLK);
    #2;
    assert(fuif.selA == 2)
      else $display("Error rsEX == destWB wen = 1");

    //rtEX == destMEM, wen = 0
    @(negedge CLK);
    fuif.rsEX = '0;
    fuif.rtEX = 5;
    fuif.destMEM = 5;
    fuif.wenWB = '0;
    fuif.wenMEM = 0;
    @(posedge CLK);
    #2;
    assert(fuif.selB == 0)
      else $display("Error rtEX == destMEM wen = 0");

    //rtEX == destMEM, wen = 1
    @(negedge CLK);
    fuif.wenMEM = 1;
    @(posedge CLK);
    #2;
    assert(fuif.selB == 1)
      else $display("Error rtEX == destMEM wen = 1");

    //rtEX == destWB, wen = 0
    @(negedge CLK);
    fuif.destMEM = '0;
    fuif.wenMEM = 0;
    fuif.wenWB = 0;
    fuif.destWB = 5;
    @(posedge CLK);
    #2;
    assert(fuif.selB == 0)
      else $display("Error rtEX == destWB wen = 0");

    //rtEX == destWB, wen = 1
    @(negedge CLK);
    fuif.wenWB = 1;
    @(posedge CLK);
    #2;
    assert(fuif.selB == 2)
      else $display("Error rtEX == destWB wen = 1");

  end
endprogram
