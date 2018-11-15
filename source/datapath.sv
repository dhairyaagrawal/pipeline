/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"

`include "idex_if.vh"
`include "exmem_if.vh"
`include "memwb_if.vh"

`include "hazard_unit_if.vh"

`include "forward_unit_if.vh"

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
  control_unit_if cuif();
  alu_if aluif();
  register_file_if rfif();

  idex_if idexif();
  exmem_if exmemif();
  memwb_if memwbif();

  hazard_unit_if huif();

  forward_unit_if fuif();

  //port map
  control_unit CU (cuif);
  alu ALU (aluif);
  register_file RF (CLK, nRST, rfif);

  idex IE (CLK, nRST, idexif);
  exmem EM (CLK, nRST, exmemif);
  memwb MW (CLK, nRST, memwbif);

  hazard_unit HU (huif);

  forward_unit FU (fuif);

  //pipe registers
  logic [63:0] IF_ID;
  logic [1:0] PCSrc;
  logic ihit;

  //IF Stage
  word_t PC;
  word_t nextPC;
  word_t npc;

  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      PC <= PC_INIT;
    end else begin
      if(huif.stall_PC) begin
        PC <= PC;
      end else if(ihit) begin
        PC <= nextPC;
      end else begin
        PC <= PC;
      end
    end
  end

  assign npc = PC + 4;
  always_comb begin
    casez (PCSrc)
      0 : nextPC = npc;
      1 : nextPC = exmemif.baddr_out;
      2 : nextPC = exmemif.jaddr_out;
      3 : nextPC = exmemif.reg31_out;
    endcase
  end

  always_ff@(posedge CLK, negedge  nRST) begin
    if(!nRST) begin
      IF_ID <= '0;
    end else begin
      if(huif.stall_IFID) begin
        IF_ID <= IF_ID;
      end else if(ihit & huif.flush_IFID) begin
        IF_ID <= '0;
      end else if(ihit) begin
        IF_ID <= {npc,dpif.imemload};
      end else begin
        IF_ID <= IF_ID;
      end
    end
  end

  assign dpif.imemaddr = PC;
  assign dpif.imemREN = 1'b1;

  //ID Stage
  word_t instr;

  assign instr = IF_ID[31:0];
  assign idexif.instr_in = instr;
  assign cuif.opcode = opcode_t'(instr[31:26]);
  assign cuif.funct = funct_t'(instr[5:0]);

  assign rfif.rsel1 = instr[25:21];
  assign rfif.rsel2 = instr[20:16];
  assign rfif.WEN = memwbif.WBctrl_out[1];
  assign rfif.wsel = memwbif.dest_out;

  assign idexif.WBctrl_in = {cuif.MemtoReg, cuif.RegWEN, cuif.halt};
  assign idexif.MEMctrl_in = {cuif.tmpPC, cuif.branch, cuif.dmemREN, cuif.dmemWEN};
  assign idexif.EXctrl_in = {cuif.lui, cuif.RegDest, cuif.ALUSrc, cuif.ALUOP, cuif.ExtOp};
  assign idexif.npc_in = IF_ID[63:32];
  assign idexif.addr_in = instr[25:0];
  assign idexif.rdat1_in = rfif.rdat1;
  assign idexif.rdat2_in = rfif.rdat2;
  assign idexif.ihit = ihit;
  assign idexif.flush_IDEX = huif.flush_IDEX;

  //EX Stage
  logic [4:0] destEX;
  word_t sign_ext;
  logic [31:0] wordA, wordB;

  assign exmemif.instr_in = idexif.instr_out;
  assign sign_ext = {{16{idexif.addr_out[15]}}, idexif.addr_out[15:0]};

  assign aluif.portA = wordA;
  assign aluif.ALUOP = aluop_t'(idexif.EXctrl_out[4:1]); //ALUOP
  always_comb begin
    if(idexif.EXctrl_out[5] == 0) begin //ALUSrc
      aluif.portB = wordB;
    end else begin
      if(idexif.EXctrl_out[0] == 0) begin  //ExtOp
        aluif.portB = {16'h0000, idexif.addr_out[15:0]}; //imm16 extended
      end else begin
        aluif.portB = sign_ext;
      end
    end
  end

  assign exmemif.dmemload_in = dpif.dmemload;
  assign exmemif.WBctrl_in = idexif.WBctrl_out;
  assign exmemif.MEMctrl_in = idexif.MEMctrl_out;
  assign exmemif.baddr_in = idexif.npc_out + (sign_ext << 2);
  assign exmemif.store_in = wordB;
  assign exmemif.reg31_in = wordA;
  assign exmemif.zero_in = aluif.zero;
  assign exmemif.imm_in = idexif.addr_out[15:0];
  assign exmemif.jaddr_in = {idexif.npc_out[31:28], idexif.addr_out, 2'b00};
  assign exmemif.npc_in = idexif.npc_out;
  assign exmemif.dest_in = destEX;
  always_comb begin
    if(idexif.EXctrl_out[7:6] == 0) begin //RegDest
      destEX = idexif.addr_out[15:11]; //rd
    end else if(idexif.EXctrl_out[7:6] == 1) begin
      destEX = idexif.addr_out[20:16];  //rt
    end else begin
      destEX = 31;
    end
  end
  assign exmemif.ihit = ihit;
  assign exmemif.dhit = dpif.dhit;

  always_comb begin
    exmemif.aluout_in = aluif.outputport;
    if(idexif.EXctrl_out[8]) begin
      exmemif.aluout_in = (idexif.addr_out[15:0] << 16);
    end
  end

  //MEM Stage
  assign memwbif.instr_in = exmemif.instr_out;
  assign dpif.dmemstore = exmemif.store_out;
  assign dpif.dmemaddr = exmemif.aluout_out;
  assign dpif.dmemREN = exmemif.MEMctrl_out[1];
  assign dpif.dmemWEN = exmemif.MEMctrl_out[0];
  assign memwbif.dmemload_in = exmemif.dmemload_out;
  assign memwbif.aluout_in = exmemif.aluout_out;
  assign memwbif.imm_in = exmemif.imm_out;
  assign memwbif.npc_in = exmemif.npc_out;
  assign memwbif.dest_in = exmemif.dest_out;
  assign memwbif.WBctrl_in = exmemif.WBctrl_out;
  always_comb begin
    if(exmemif.MEMctrl_out[4:3] == 1) begin //tmpPC is a branch
      if((exmemif.MEMctrl_out[2] && exmemif.zero_out) || (~exmemif.MEMctrl_out[2] && ~exmemif.zero_out)) begin //BEQ&equal or BNE&not equal
        PCSrc = exmemif.MEMctrl_out[4:3]; //set PCSrc to tmpPC
      end else begin
        PCSrc = '0;
      end
    end else begin //not a branch
      PCSrc = exmemif.MEMctrl_out[4:3]; //set PCSrc to tmpPC
    end
  end
  assign memwbif.ihit = ihit;
  assign memwbif.dhit = dpif.dhit;

  always_comb begin //ihit before dhit handle logic
    if(dpif.dmemREN || dpif.dmemWEN) begin
      ihit = 1'b0;
    end else begin
      ihit = dpif.ihit;
    end
  end

  //WB Stage
  word_t instrWB;
  //assign dpif.halt = memwbif.WBctrl_out[0];
  always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      dpif.halt <= 0;
    end else if (exmemif.WBctrl_out[0]) begin
      dpif.halt <= 1;
    end else begin
      dpif.halt <= dpif.halt;
    end
  end
  always_comb begin
    rfif.wdat = '0;
    if(memwbif.WBctrl_out[3:2] == 0) begin
      rfif.wdat = memwbif.aluout_out;
    end else if(memwbif.WBctrl_out[3:2] == 1) begin
      rfif.wdat = memwbif.dmemload_out;
    end else if(memwbif.WBctrl_out[3:2] == 2) begin
      rfif.wdat = {memwbif.imm_out, 16'h0000};
    end else if(memwbif.WBctrl_out[3:2] == 3) begin
      rfif.wdat = memwbif.npc_out;
    end
  end

  //HAZARD UNIT
  assign huif.rs = instr[25:21]; //rs
  assign huif.rt = instr[20:16];  //rt
  assign huif.destEX = destEX;
  assign huif.dmemREN = idexif.MEMctrl_out[1];
  assign huif.tmpPC = cuif.tmpPC;
  assign huif.IDEX_tmpPC = idexif.MEMctrl_out[4:3];
  assign huif.EXMEM_tmpPC = exmemif.MEMctrl_out[4:3];
  assign huif.PCSrc = PCSrc;

  //FORWARD UNIT
  assign fuif.rsEX = idexif.addr_out[25:21]; //rs
  assign fuif.rtEX = idexif.addr_out[20:16]; //rt
  assign fuif.destMEM = exmemif.dest_out;
  assign fuif.destWB = memwbif.dest_out;
  assign fuif.wenMEM = exmemif.WBctrl_out[1];
  assign fuif.wenWB = memwbif.WBctrl_out[1];
  always_comb begin
    wordA = '0;
    //muxA
    if(fuif.selA == 0) begin
      wordA = idexif.rdat1_out;
    end else if(fuif.selA == 1) begin
      wordA = exmemif.aluout_out;
    end else if(fuif.selA == 2) begin
      wordA = rfif.wdat;
    end

    wordB = '0;
    //muxB
    if(fuif.selB == 0) begin
      wordB = idexif.rdat2_out;
    end else if(fuif.selB == 1) begin
      wordB = exmemif.aluout_out;
    end else if(fuif.selB == 2) begin
      wordB = rfif.wdat;
    end
  end




  //DEBUG

  r_t rtypeIF;
  i_t itypeIF;
  j_t jtypeIF;
  r_t rtypeIFID;
  i_t itypeIFID;
  j_t jtypeIFID;
  r_t rtypeIDEX;
  i_t itypeIDEX;
  j_t jtypeIDEX;
  r_t rtypeEXMEM;
  j_t jtypeEXMEM;
  i_t itypeEXMEM;
  r_t rtypeMEMWB;
  j_t jtypeMEMWB;
  i_t itypeMEMWB;

  assign rtypeIF = r_t'(dpif.imemload);
  assign itypeIF = i_t'(dpif.imemload);
  assign jtypeIF = j_t'(dpif.imemload);

  assign rtypeIFID = r_t'(instr);
  assign itypeIFID = i_t'(instr);
  assign jtypeIFID = j_t'(instr);

  assign rtypeIDEX = r_t'(idexif.instr_out);
  assign itypeIDEX = i_t'(idexif.instr_out);
  assign jtypeIDEX = j_t'(idexif.instr_out);

  assign rtypeEXMEM = r_t'(exmemif.instr_out);
  assign itypeEXMEM = i_t'(exmemif.instr_out);
  assign jtypeEXMEM = j_t'(exmemif.instr_out);

  assign rtypeMEMWB = r_t'(memwbif.instr_out);
  assign itypeMEMWB = i_t'(memwbif.instr_out);
  assign jtypeMEMWB = j_t'(memwbif.instr_out);
endmodule
