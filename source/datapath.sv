/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "program_counter_unit_if.vh"
`include "request_unit_if.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"

//`include "program_counter_unit.sv"
//`include "request_unit.sv"
//`include "control_unit.sv"
//`include "alu.sv"
//`include "register_file.sv"


// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //interfaces
  program_counter_unit_if pcuif();
  request_unit_if ruif();
  control_unit_if cuif();
  alu_if aluif();
  register_file_if rfif();

  //port map
  program_counter_unit PCU (CLK, nRST, pcuif);
  request_unit RU (CLK, nRST, ruif);
  control_unit CU (cuif);
  alu ALU (aluif);
  register_file RF (CLK, nRST, rfif);

  //make connections between interfaces
  //fetch unit signals
  assign dpif.imemaddr = pcuif.imemaddr;
  assign pcuif.ihit = dpif.ihit;
  assign pcuif.PCSrc = cuif.PCSrc;
  assign pcuif.imm16 = dpif.imemload[15:0];
  assign pcuif.jaddr = dpif.imemload[25:0];
  assign pcuif.reg31 = rfif.rdat1;

  //reg file signals
  assign dpif.dmemstore = rfif.rdat2;
  assign rfif.WEN = cuif.RegWEN;
  assign rfif.rsel1 = dpif.imemload[25:21];
  assign rfif.rsel2 = dpif.imemload[20:16];
  always_comb begin
    rfif.wsel = '0;
    if(cuif.RegDest == 0) begin
      rfif.wsel = dpif.imemload[15:11];
    end else if(cuif.RegDest == 1) begin
      rfif.wsel = dpif.imemload[20:16];
    end else if(cuif.RegDest == 2) begin
      rfif.wsel = 5'b11111;
    end
    rfif.wdat = '0;
    if(cuif.MemtoReg == 0) begin
      rfif.wdat = aluif.outputport;
    end else if(cuif.MemtoReg == 1) begin
      rfif.wdat = dpif.dmemload;
    end else if(cuif.MemtoReg == 2) begin
      rfif.wdat = (dpif.imemload[15:0] << 16);
    end else if(cuif.MemtoReg == 3) begin
      rfif.wdat = pcuif.imemaddr + 4;
    end
  end

  //ALU signals
  assign dpif.dmemaddr = aluif.outputport;
  assign aluif.portA = rfif.rdat1;
  assign aluif.ALUOP = cuif.ALUOP;
  always_comb begin
    if(cuif.ALUSrc == 0) begin
      aluif.portB = rfif.rdat2;
    end else begin
      if(cuif.ExtOp == 0) begin
        aluif.portB = {16'h0000, dpif.imemload[15:0]};
      end else begin
        aluif.portB = {{16{dpif.imemload[15]}}, dpif.imemload[15:0]};
      end
    end
  end

  //control unit signals
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      dpif.halt <= 1'b0;
    end else begin
      dpif.halt <= cuif.halt;
    end
  end
  assign cuif.opcode = opcode_t'(dpif.imemload[31:26]);
  assign cuif.funct = funct_t'(dpif.imemload[5:0]);
  assign cuif.zero = aluif.zero;
  assign cuif.overflow = aluif.overflow;
  assign cuif.negative = aluif.negative;
  assign dpif.imemREN = cuif.imemREN;

  //request unit signals
  assign ruif.ihit = dpif.ihit;
  assign ruif.dhit = dpif.dhit;
  //assign dpif.imemREN = ruif.imemREN;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  //assign ruif.imemreq = cuif.imemreq;
  assign ruif.dmemreq = cuif.dmemreq;
  assign ruif.dmemwreq = cuif.dmemwreq;
  //always_comb begin
  //  if(cuif.halt == 1'b1) begin
  //    dpif.imemREN = 1'b0;
  //  end else begin
  //    dpif.imemREN = cuif.imemREN;
  //  end
  //end
endmodule
