/*
  alu test bench
*/

// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module alu_tb;

  // interface
  alu_if aluif ();

  // test program
  test PROG (aluif);

  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.negative (aluif.negative),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero (aluif.zero),
    .\aluif.outputport (aluif.outputport),
    .\aluif.portA (aluif.portA),
    .\aluif.portB (aluif.portB),
    .\aluif.ALUOP (aluif.ALUOP)
  );
`endif

endmodule

program test(alu_if.tb aluif);
 initial begin
    //$monitor("aluif.portA = %h, aluif.portB = %h, aluif.outputport = %h", aluif.portA, aluif.portB, aluif.outputport);
    // initialize test input signals
    //SLL - 0000
    aluif.portA = 32'h0000ffff;
    aluif.portB = 32'h00000010;
    aluif.ALUOP = ALU_SLL;
    #2;
    if(aluif.outputport == 32'hffff0000) begin
      $display("ALU_SLL working");
    end else begin
      $display("ALU_SLL fails");
    end

    //SRL - 0001
    aluif.portA = 32'hffff0000;
    aluif.portB = 32'h00000010;
    aluif.ALUOP = ALU_SRL;
    #2;
    if(aluif.outputport == 32'h0000ffff) begin
      $display("ALU_SRL working");
    end else begin
      $display("ALU_SRL fails");
    end
    if(aluif.overflow) begin
      $display("overflow flag fails, wrongly set");
    end else begin
      $display("overflow flag works");
    end

    //ADD - 0010
    aluif.portA = 32'haaaabbbb;
    aluif.portB = 32'h11111111;
    aluif.ALUOP = ALU_ADD;
    #2;
    if(aluif.outputport == (aluif.portA + aluif.portB)) begin
      $display("ALU_ADD working");
    end else begin
      $display("ALU_ADD fails");
    end
    if(aluif.overflow) begin
      $display("overflow flag fails, wrongly set");
    end else begin
      $display("overflow flag works");
    end

    aluif.portA = 32'hffffffff;
    aluif.portB = 32'h80000000;
    #2;
    if(aluif.overflow) begin
      $display("overflow during add working");
    end else begin
      $display("overflow during add fails");
    end

    aluif.portA = 32'h7fffffff;
    aluif.portB = 32'h7fffffff;
    #2;
    if(aluif.overflow) begin
      $display("overflow during add 2 working");
    end else begin
      $display("overflow during add 2 fails");
    end

    //SUB - 0011
    aluif.portA = 32'haaaabbbb;
    aluif.portB = 32'h7fffffff;
    aluif.ALUOP = ALU_SUB;
    #2;
    if(aluif.overflow) begin
      $display("overflow during sub working");
    end else begin
      $display("overflow during sub fails");
    end

    aluif.portA = 32'hffff0000;
    aluif.portB = 32'h7000aaaa;
    #2;
    if(aluif.outputport == (aluif.portA - aluif.portB)) begin
      $display("ALU_SUB works");
    end else begin
      $display("ALU_SUB fails");
    end
    if(aluif.negative) begin
      $display("negative flag working");
    end else begin
      $display("negative flag fails");
    end

    //AND - 0100
    aluif.portA = 32'hfafafafa;
    aluif.portB = 32'h00000000;
    aluif.ALUOP = ALU_AND;
    #2;
    if(aluif.outputport == (aluif.portA & aluif.portB)) begin
      $display("ALU_AND works");
    end else begin
      $display("ALU_AND fails");
    end
    if(aluif.zero) begin
      $display("zero flag working");
    end else begin
      $display("zero flag fails");
    end

    //OR - 0101
    aluif.portA = 32'hfafafafa;
    aluif.portB = 32'h1d1d1d1d;
    aluif.ALUOP = ALU_OR;
    #2;
    if(aluif.outputport == (aluif.portA | aluif.portB)) begin
      $display("ALU_OR works");
    end else begin
      $display("ALU_OR fails");
    end

    //XOR - 0110
    aluif.portA = 32'hfafafafa;
    aluif.portB = 32'h1d1d1d1d;
    aluif.ALUOP = ALU_XOR;
    #2;
    if(aluif.outputport == (aluif.portA ^ aluif.portB)) begin
      $display("ALU_XOR works");
    end else begin
      $display("ALU_XOR fails");
    end

    //NOR - 0111
    aluif.portA = 32'hfafafafa;
    aluif.portB = 32'h1d1d1d1d;
    aluif.ALUOP = ALU_NOR;
    #2;
    if(aluif.outputport == ~(aluif.portA | aluif.portB)) begin
      $display("ALU_NOR works");
    end else begin
      $display("ALU_NOR fails");
    end

    //SLT - 1010
    aluif.portA = 32'hffffffff;
    aluif.portB = 32'h11111111;
    aluif.ALUOP = ALU_SLT;
    #2;
    if(aluif.outputport == 1'b1) begin
      $display("ALU_SLT works");
    end else begin
      $display("ALU_SLT fails");
    end

    //SLTU - 1011
    aluif.portA = 32'hffffffff;
    aluif.portB = 32'h11111111;
    aluif.ALUOP = ALU_SLTU;
    #2;
    if(aluif.outputport == 1'b0) begin
      $display("ALU_SLTU works");
    end else begin
      $display("ALU_SLTU fails");
    end

  end
endprogram
