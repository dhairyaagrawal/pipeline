`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

import cpu_types_pkg::*;

module control_unit (
  control_unit_if.cu cuif
);

  always_comb begin //tried sensitivity list
    //set tmpPC
    cuif.tmpPC = 2'b00;
    if(cuif.opcode == RTYPE && cuif.funct == JR) begin
      cuif.tmpPC = 2'b11;
    end else if(cuif.opcode == J | cuif.opcode == JAL) begin
      cuif.tmpPC = 2'b10;
    end else if(cuif.opcode == BEQ | cuif.opcode == BNE) begin
      cuif.tmpPC = 2'b01;
    end

    //set branch
    cuif.branch = 1'b0;
    if(cuif.opcode == BEQ) begin
      cuif.branch = 1'b1;
    end

    //set RegDest
    cuif.RegDest = 1;
    if(cuif.opcode == RTYPE) begin
      cuif.RegDest = 0;
    end else if(cuif.opcode == JAL) begin
      cuif.RegDest = 2;
    end

    //set RegWEN
    cuif.RegWEN = 1; //in load since its two cycles garbage values gets writtem first and then actual value overwrites it in the next cycle????
    if((cuif.opcode == RTYPE && cuif.funct == JR) | (cuif.opcode == BEQ) | (cuif.opcode == BNE) | (cuif.opcode == SW) | (cuif.opcode == J) | (cuif.opcode == HALT)) begin
      cuif.RegWEN = 0;
    end

    //set ALUSrc
    cuif.ALUSrc = 1;
    if(cuif.opcode == RTYPE | cuif.opcode == BEQ | cuif.opcode == BNE) begin
      cuif.ALUSrc = 0;
    end

    //set ExtOp
    cuif.ExtOp = 1;
    if(cuif.opcode == ORI | cuif.opcode == ANDI | cuif.opcode == XORI) begin
      cuif.ExtOp = 0;
    end

    //set MemtoReg
    cuif.MemtoReg = 0;
    if(cuif.opcode == LW) begin
      cuif.MemtoReg = 1;
    end else if(cuif.opcode == LUI) begin
      cuif.MemtoReg = 2;
    end else if(cuif.opcode == JAL) begin
      cuif.MemtoReg = 3;
    end

    //set halt
    cuif.halt = 0;
    if(cuif.opcode == HALT) begin
      cuif.halt = 1;
    end

    //set dmemREN
    cuif.dmemREN = 0;
    if(cuif.opcode == LW) begin
      cuif.dmemREN = 1;
    end

    //set dmemWEN
    cuif.dmemWEN = 0;
    if(cuif.opcode == SW) begin
      cuif.dmemWEN = 1;
    end

    //set ALUOP
    cuif.ALUOP = ALU_AND;
    if(cuif.opcode == RTYPE) begin
      casez(cuif.funct)
        SLLV:  cuif.ALUOP = ALU_SLL;
        SRLV:  cuif.ALUOP = ALU_SRL;
        JR:  cuif.ALUOP = ALU_ADD;
        ADD:  cuif.ALUOP = ALU_ADD;
        ADDU:  cuif.ALUOP = ALU_ADD;
        SUB:  cuif.ALUOP = ALU_SUB;
        SUBU:  cuif.ALUOP = ALU_SUB;
        AND:  cuif.ALUOP = ALU_AND;
        OR:  cuif.ALUOP = ALU_OR;
        XOR:  cuif.ALUOP = ALU_XOR;
        NOR:  cuif.ALUOP = ALU_NOR;
        SLT:  cuif.ALUOP = ALU_SLT;
        SLTU:  cuif.ALUOP = ALU_SLTU;
      endcase
    end else if(cuif.opcode == BEQ | cuif.opcode == BNE) begin
      cuif.ALUOP = ALU_SUB;
    end else if(cuif.opcode == ADDI | cuif.opcode == ADDIU | cuif.opcode == LW | cuif.opcode == SW) begin
      cuif.ALUOP = ALU_ADD;
    end else if(cuif.opcode == ANDI) begin
      cuif.ALUOP = ALU_AND;
    end else if(cuif.opcode == SLTI) begin
      cuif.ALUOP = ALU_SLT;
    end else if(cuif.opcode == SLTIU) begin
      cuif.ALUOP = ALU_SLTU;
    end else if(cuif.opcode == ORI) begin
      cuif.ALUOP = ALU_OR;
    end else if(cuif.opcode == XORI) begin
      cuif.ALUOP = ALU_XOR;
    end
  end

endmodule


//use ihit or dhit to generate mempry read/write requests?? as told in lectures to make your design timing independent (variable latency checks) or just make pc=pc for one more cycle
//why two clocks if we only do one read/write in one CPU cycle
//should i use all signals in the given interfaces
//didnt understand how cache is working
//should i send ihit and dhit to control unit to determine if pc should become pc+4?
