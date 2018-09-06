//interfaces
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"

//cpu types
`include "cpu_types_pkg.vh"

//time scale
`timescale 1 ns / 1 ns

module memory_control_tb;
  // clock period
  parameter PERIOD = 20;

  // signals
  logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  //interface
  caches_if cif0();
  caches_if cif1(); //not used right?
  cache_control_if #(.CPUS(1)) ccif(cif0, cif1); //this is the way?

  cpu_ram_if ramif();

  //test program
  test PROG (CLK,nRST,cif0,ramif);

  //portmap
  `ifndef MAPPED
    memory_control #(.CPUS(1)) DUT(CLK, nRST, ccif);
  `else
    memory_control #(.CPUS(1)) DUT(
      .\CLK (CLK),
      .\nRST (nRST),
      .\ccif.iREN (ccif.iREN),
      .\ccif.idREN (ccif.dREN),
      .\ccif.dWEN (ccif.dWEN),
      .\ccif.dstore (ccif.dstore),
      .\ccif.iaddr (ccif.iaddr),
      .\ccif.daddr (ccif.daddr), //outputs now
      .\ccif.iwait (ccif.iwait),
      .\ccif.dwait (ccif.dwait),
      .\ccif.iload (ccif.iload),
      .\ccif.dload (ccif.dload),

      //.\ccif.ccwrite (ccif.ccwrite),
      //.\ccif.cctrans (ccif.cctrans),
      //.\ccif.ccwait (ccif.ccwait),
      //.\ccif.ccinv (ccif.ccinv),
      //.\ccif.ccsnoopaddr (ccif.ccsnoopaddr),

      .\ccif.ramload (ccif.ramload),
      .\ccif.ramstate (ccif.ramstate), //outputs now
      .\ccif.ramstore (ccif.ramstore),
      .\ccif.ramaddr (ccif.ramaddr),
      .\ccif.ramWEN (ccif.ramWEN),
      .\ccif.ramREN (ccif.ramREN)
    );
  `endif

  `ifndef MAPPED
    ram RAM(CLK, nRST, ramif);
  `else
    ram RAM(
      .\CLK (CLK),
      .\nRST (nRST),
      .\ramif.ramload (ramif.ramload),
      .\ramif.ramstate (ramif.ramstate), //inputs now
      .\ramif.ramstore (ramif.ramstore),
      .\ramif.ramaddr (ramif.ramaddr),
      .\ramif.ramWEN (ramif.ramWEN),
      .\ramif.ramREN (ramif.ramREN)
    );
  `endif

  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramREN = ccif.ramREN;
  assign ccif.ramload = ramif.ramload;
  assign ccif.ramstate = ramif.ramstate;
endmodule

program test(input logic CLK, output logic nRST, caches_if.caches cif, cpu_ram_if.ram ramif);
  import cpu_types_pkg::*;
  initial begin
  //dREN, dWEN, daddr, dstore,iREN, iaddr - outputs
  //dwait, dload, iwait, iload - inputs
  //read data, store data, read inst, read data and inst - testcases
  
  //initialize
  nRST = 1'b1;
  @(posedge CLK);
  nRST = 1'b0;
  @(posedge CLK);
  nRST = 1'b1;
  cif.dREN = 1'b0;
  cif.dWEN = 1'b0;
  cif.daddr = '0;
  cif.dstore = '0;
  cif.iREN = 1'b0;
  cif.iaddr = '0;
  @(posedge CLK);

  //store data
  cif.daddr = 32'h00000000;
  cif.dstore = 32'hf0f0f0f0;
  cif.dWEN = 1'b1;
  @(posedge CLK);  
  //while(cif.dwait);
  while(ramif.ramstate != ACCESS) begin
    assert(cif.iwait && cif.dwait)
    else $display("iwait dwait error");
    @(posedge CLK);
  end
  #5;
  //cif.dWEN = 1'b0;
  @(posedge CLK);

  cif.daddr = 32'h00000004;
  cif.dstore = 32'h10101010;
  cif.dWEN = 1'b1;
  @(posedge CLK);
  //while(cif.dwait);
  while(ramif.ramstate != ACCESS) begin
    assert(cif.iwait && cif.dwait)
    else $display("iwait dwait error");
    @(posedge CLK);
  end
  #5;
  @(posedge CLK);
  cif.dWEN = 1'b0;

  //read data
  cif.daddr = 32'h00000000;
  cif.dREN = 1'b1;
  @(posedge CLK);
  //while(cif.dwait);
  while(ramif.ramstate != ACCESS) begin
    assert(cif.iwait && cif.dwait)
    else $display("iwait dwait error");
    @(posedge CLK);
  end
  #5;
  if(cif.dload == 32'hf0f0f0f0) begin
    $display("read/write just data works");
  end else begin
    $display("read/write just data fails");
  end
  @(posedge CLK);
  cif.dREN = 1'b0; // before or after checking


  cif.daddr = 32'h00000004;
  cif.dREN = 1'b1;
  @(posedge CLK);
  //while(cif.dwait);
  while(ramif.ramstate != ACCESS) begin
    assert(cif.iwait && cif.dwait)
    else $display("iwait dwait error");
    @(posedge CLK);
  end
  #5;
  if(cif.dload == 32'h10101010) begin
    $display("read/write just data 2 works");
  end else begin
    $display("read/write just data 2 fails");
  end
  @(posedge CLK);
  cif.dREN = 1'b0; // before or after checking


  //read instruction
  cif.iaddr = 32'h00000004;
  cif.iREN = 1'b1;
  @(posedge CLK);
  //while(cif.iwait);
  while(ramif.ramstate != ACCESS) begin
    @(posedge CLK);
  end
  #5;
  if(cif.iload == 32'h10101010) begin
    $display("read just instruction works");
  end else begin
    $display("read just instruction fails");
  end
  cif.iREN = 1'b0; // before or after checking
  @(negedge CLK);

  //read both data and instruction
  cif.iaddr = 32'h00000000;
  cif.daddr = 32'h00000004;
  cif.iREN = 1'b1;
  cif.dREN = 1'b1;
  @(posedge CLK);
  //while(cif.dwait);
  while(ramif.ramstate != ACCESS) begin
    @(posedge CLK);
  end
  #5;
  if(cif.dload == 32'h10101010 && cif.iwait) begin
    $display("arbitration works");
  end else begin
    $display("arbitration fails");
  end
  cif.dREN = 1'b0;
  @(posedge CLK);
  //while(cif.iwait);
  while(ramif.ramstate != ACCESS) begin
    @(posedge CLK);
  end
  #5;
  if(cif.iload == 32'hf0f0f0f0) begin
    $display("arbitration works 2");
  end else begin
    $display("arbitration fails 2");
  end
  cif.iREN = 1'b0;
  @(negedge CLK);

  dump_memory();
  end

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    //syif.tbCTRL = 1;
    cif.daddr = 0;
    cif.dWEN = 0;
    cif.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif.daddr = i << 2;
      cif.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //syif.tbCTRL = 0;
      cif.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

endprogram

