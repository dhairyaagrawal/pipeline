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
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1); //this is the way?

  cpu_ram_if ramif();

  //test program
  test PROG (CLK,nRST,cif0,cif1,ramif);

  //portmap
  `ifndef MAPPED
    memory_control #(.CPUS(2)) DUT(CLK, nRST, ccif);
  `else
    memory_control #(.CPUS(2)) DUT(
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
      .\ccif.ccwrite (ccif.ccwrite),
      .\ccif.cctrans (ccif.cctrans),
      .\ccif.ccwait (ccif.ccwait),
      .\ccif.ccinv (ccif.ccinv),
      .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),
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

program test(input logic CLK, output logic nRST, caches_if.caches cif0, caches_if.caches cif1, cpu_ram_if.ram ramif);
  import cpu_types_pkg::*;
  initial begin
  //dREN, dWEN, daddr, dstore,iREN, iaddr - outputs
  //dwait, dload, iwait, iload - inputs
  //read data, store data, read inst, read data and inst - testcases

  //initialize
  integer i;
  nRST = 1'b1;
  @(posedge CLK);
  nRST = 1'b0;
  @(posedge CLK);
  nRST = 1'b1;
  cif0.dREN = 1'b0;
  cif0.dWEN = 1'b0;
  cif0.daddr = '0;
  cif0.dstore = '0;
  cif0.iREN = 1'b0;
  cif0.iaddr = '0;
  cif1.dREN = 1'b0;
  cif1.dWEN = 1'b0;
  cif1.daddr = '0;
  cif1.dstore = '0;
  cif1.iREN = 1'b0;
  cif1.iaddr = '0;
  @(posedge CLK);

  //tc1, iREN
  @(negedge CLK);
  cif0.iaddr = 32'h00000000;
  cif0.iREN = 1;
  cif1.iaddr = 32'h00001000;
  cif1.iREN = 1;
  @(posedge CLK);
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    #1;
    assert(ramif.ramREN == 1 & ramif.ramaddr == cif0.iaddr)
      else $display("tc1 iREN 0 error");
    @(posedge CLK);
  end
  @(posedge CLK);
  @(posedge CLK);
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    #1;
    assert(ramif.ramREN == 1 & ramif.ramaddr == cif1.iaddr)
      else $display("tc1 iREN 1 error");
    @(posedge CLK);
  end
  @(posedge CLK);
  @(posedge CLK);
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    #1;
    assert(ramif.ramREN == 1 & ramif.ramaddr == cif0.iaddr)
      else $display("tc1 iREN 2 error");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.iREN = '0;
  cif1.iREN = '0;

  //tc2, data write, preference dcache0
  @(negedge CLK);
  cif0.dWEN = 1'b1;
  cif0.daddr = 32'h11111111;
  cif0.dstore = 32'hf0f0f0f0;
  cif1.dWEN = 1'b1;
  cif1.daddr = 32'h22222222;
  cif1.dstore = 32'hf2f2f2f2;
  @(posedge CLK);
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramaddr == cif0.daddr & ramif.ramstore == cif0.dstore)
    else $display("tc 2 error, wb1");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.daddr = 32'h11111115;
  cif0.dstore = 32'hf1f1f1f1;
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramaddr == cif0.daddr & ramif.ramstore == cif0.dstore)
    else $display("tc 2 error, wb2");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.dWEN = 1'b0;
  cif0.daddr = 32'h00000000;
  cif0.dstore = 32'h00000000;
  @(posedge CLK);
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramaddr == cif1.daddr & ramif.ramstore == cif1.dstore)
    else $display("tc 2 error, wb3");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif1.daddr = 32'h22222226;
  cif0.dstore = 32'hf3f3f3f3;
  @(posedge CLK);
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramaddr == cif1.daddr & ramif.ramstore == cif1.dstore)
    else $display("tc 2 error, wb4");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif1.dWEN = 1'b0;
  cif1.daddr = 32'h00000000;
  cif1.dstore = 32'h00000000;
  @(posedge CLK);




  //tc3, read data
  cif0.daddr = 32'h55555555;
  cif0.dREN = 1'b1;
  cif0.cctrans = 1;
  cif0.ccwrite = 0;
  cif1.ccwrite = 0;
  @(posedge CLK);
  @(posedge CLK);
  //snoop
  #2;
  assert(cif1.ccsnoopaddr == cif0.daddr & cif1.ccwait == 1 & cif1.ccinv == cif0.ccwrite)
    else $display("tc3 snoop error, %h, %d, %d", cif1.ccsnoopaddr, cif1.ccwait, cif1.ccinv);
  @(posedge CLK);
  #1;
  //read 1
  while(ramif.ramstate != ACCESS) begin
    #1;
    assert(ramif.ramREN == 1 & ramif.ramaddr == cif0.daddr & cif1.ccwait == 0)
      else $display("tc3 ram read 1 error, %d, %h, %d", ramif.ramREN, ramif.ramaddr, cif1.ccwait);
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.daddr = 32'h55555559;
  @(posedge CLK);
  //read 2
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramREN == 1 & ramif.ramaddr == cif0.daddr & cif1.ccwait == 0)
      else $display("tc3 ram read 2 error");
    @(posedge CLK);
  end
  @(posedge CLK);

  //tc4
  cif0.daddr = 32'h33333333;
  cif0.dREN = 1'b1;
  cif0.cctrans = 1;
  cif0.ccwrite = 0;
  cif1.ccwrite = 1;
  @(posedge CLK);
  @(posedge CLK);
  //snoop
  #2;
  assert(cif1.ccsnoopaddr == cif0.daddr & cif1.ccwait == 1 & cif1.ccinv == cif0.ccwrite)
    else $display("tc4 snoop error");
  @(posedge CLK);
  //read 1
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramWEN == 1 & ramif.ramaddr == cif0.daddr & cif1.ccwait == 1 & ramif.ramstore == cif0.dstore & cif0.dload == cif1.dstore)
      else $display("tc4 dirty wb1 error");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.daddr = 32'h33333337;
  @(posedge CLK);
  //read 2
  while(ramif.ramstate != ACCESS) begin
    assert(ramif.ramWEN == 1 & ramif.ramaddr == cif0.daddr & cif1.ccwait == 1 & ramif.ramstore == cif0.dstore & cif0.dload == cif1.dstore)
      else $display("tc3 dirty wb2 error");
    @(posedge CLK);
  end
  @(posedge CLK);
  cif0.daddr = '0;
  cif0.dREN = 1'b0;
  cif0.cctrans = 0;
  cif0.ccwrite = 0;
  cif1.ccwrite = 0;

  //tc5, ~dREN
  cif1.cctrans = 1;
  @(posedge CLK);
  @(posedge CLK);
  assert(cif0.ccsnoopaddr == cif1.daddr & cif0.ccwait == 1 & cif0.ccinv == cif1.ccwrite)
    else $display("tc5 error");
  @(posedge CLK);

  /*dump_memory();
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
  endtask*/
end
endprogram

