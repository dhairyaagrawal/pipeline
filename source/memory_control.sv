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
  parameter CPUS = 1;

  typedef enum logic [3:0] {IDLE, ARBITRATE, FETCH, WB0, WB1, SNOOP, READ0, READ1, DIRTYWB0, DIRTYWB1} stateType;
  stateType state;
  stateType nextstate;

  logic cachesel;
  logic nextcachesel;
  logic coresel;
  logic nextcoresel;

  logic [1:0] nextInv;
  word_t [1:0] nextSnoopaddr;
  logic [1:0] nextWait;
  logic [1:0] cctransReg;
  logic [1:0] ccwriteReg;

  //STORE STATE
  always_ff@(posedge CLK, negedge nRST) begin
    if(!nRST) begin
      state <= IDLE;
      cachesel <= '1;
      coresel <= '1;
      ccif.ccsnoopaddr <= '0; //output
      ccwriteReg <= '0; //input latched
      cctransReg <= '0; //input latched
    end else begin
      state <= nextstate;
      cachesel <= nextcachesel;
      coresel <= nextcoresel;
      ccif.ccsnoopaddr <= nextSnoopaddr; //output
      ccif.ccinv <= nextInv;
      ccif.ccwait <= nextWait;
      ccwriteReg <= ccif.ccwrite; //input latched
      cctransReg <= ccif.cctrans; //input latched
    end
  end

  //NEXT STATE LOGIC
  always_comb begin
    nextstate = state;
    //ccif.ccwait = '0;
    nextWait = ccif.ccwait;
    case(state)
      IDLE : if(cctransReg[0] || cctransReg[1] || ccif.dWEN[0] || ccif.dWEN[1] || ccif.dREN[0] || ccif.dREN[1] || ccif.iREN[0] || ccif.iREN[1]) begin
               nextstate = ARBITRATE;
               nextWait = '1;
             end
      ARBITRATE : if(ccif.dWEN[cachesel]) begin
                    nextstate = WB0;
                    nextWait[!cachesel] = '1;
                  end else if(cctransReg[cachesel] || ccif.dREN[cachesel] ) begin
                    nextstate = SNOOP;
                    nextWait[!cachesel] = '1;
                  end else if(ccif.iREN[coresel]) begin
                    nextstate = FETCH;
                    nextWait = '1;
                  end
      WB0 : begin
            nextWait[!cachesel] = '1;
            if(ccif.ramstate == ACCESS) begin
              nextstate = WB1;
            end
      end
      WB1 : begin
            nextWait[!cachesel] = '1;
            if(ccif.ramstate == ACCESS) begin
                nextstate = IDLE;
            end
      end
      FETCH : begin
              nextWait[!cachesel] = '1;
              if(ccif.ramstate == ACCESS) begin
                nextstate = IDLE;
              end
      end
      SNOOP : begin
              nextWait[!cachesel] = '1;
              if(!ccif.dREN[cachesel] && cctransReg[!cachesel]) begin
                nextstate = IDLE;
              end else if(ccwriteReg[!cachesel] && cctransReg[!cachesel]) begin
                nextstate = DIRTYWB0;
              end else if(!ccwriteReg[!cachesel] && cctransReg[!cachesel]) begin
                nextstate = READ0;
              end
      end
      READ0 : begin
              nextWait[!cachesel] = '1;
              if(ccif.ramstate == ACCESS) begin
                nextstate = READ1;
              end
      end
      READ1 : begin
              nextWait[!cachesel] = '1;
              if(ccif.ramstate == ACCESS) begin
                nextstate = IDLE;
              end
      end
      DIRTYWB0 : begin
                 nextWait[!cachesel] = '1;
                 if(ccif.ramstate == ACCESS) begin
                   nextstate = DIRTYWB1;
                 end
      end
      DIRTYWB1 : begin
                 nextWait[!cachesel] = '1;
                 if(ccif.ramstate == ACCESS) begin
                   nextstate = IDLE;
                 end
      end
    endcase
  end

  //OUTPUT LOGIC
  always_comb begin
    ccif.iwait = '1;
    ccif.dwait = '1;
    ccif.iload = '0;
    ccif.dload = '0;
    ccif.ramstore = '0;
    ccif.ramaddr = '0;
    ccif.ramWEN = 1'b0;
    ccif.ramREN = 1'b0;
    //ccif.ccwait = '0;
    //ccif.ccinv = '0;
    nextcachesel = cachesel;
    nextcoresel = coresel;
    nextSnoopaddr = ccif.ccsnoopaddr;
    nextInv = ccif.ccinv;
    case(state)
      IDLE : begin
             if(((ccif.dWEN[0] || ccif.dREN[0]) && (ccif.dWEN[1] || ccif.dREN[1])) || (cctransReg == 3)) begin
               nextcachesel = !cachesel;
             end else if(ccif.dWEN[0] || ccif.dREN[0] || cctransReg[0]) begin
               nextcachesel = 1'b0;
             end else if(ccif.dWEN[1] || ccif.dREN[1] || cctransReg[1]) begin
               nextcachesel = 1'b1;
             end
             if(ccif.iREN[0] && ccif.iREN[1]) begin
               nextcoresel = !coresel;
             end else if(ccif.iREN[0]) begin
               nextcoresel = 1'b0;
             end else if(ccif.iREN[1]) begin
               nextcoresel = 1'b1;;
             end
             nextSnoopaddr[!nextcachesel] = ccif.daddr[nextcachesel];
             nextInv[!nextcachesel] = ccwriteReg[nextcachesel];
      end
      ARBITRATE : begin
                  if(cctransReg[cachesel] || ccif.dREN[cachesel] ) begin
                    nextSnoopaddr[!cachesel] = ccif.daddr[cachesel];
                    //ccif.ccsnoopaddr[!cachesel] = ccif.daddr[cachesel];
                    nextInv[!cachesel] = ccwriteReg[cachesel];
                  end
      end
      FETCH : begin
              ccif.ramaddr = ccif.iaddr[coresel];
              ccif.ramREN = ccif.iREN[coresel];
              ccif.iload[coresel] = ccif.ramload;
              nextSnoopaddr[!cachesel] = '0;
              nextInv[!cachesel] = '0;nextSnoopaddr[!cachesel] = '0;
                   nextInv[!cachesel] = '0;
              if(ccif.ramstate == ACCESS) begin
                ccif.iwait[coresel] = 1'b0;
              end
      end
      WB0 : begin
              ccif.ramaddr = ccif.daddr[cachesel];
              ccif.ramstore = ccif.dstore[cachesel];
              ccif.ramWEN = 1'b1;
              if(ccif.ramstate == ACCESS) begin
                ccif.dwait[cachesel] = 1'b0;
              end
      end
      WB1 : begin
              ccif.ramaddr = ccif.daddr[cachesel];
              ccif.ramstore = ccif.dstore[cachesel];
              ccif.ramWEN = 1'b1;
              if(ccif.ramstate == ACCESS) begin
                ccif.dwait[cachesel]= 1'b0;
              end
      end
      SNOOP : begin
              ccif.ramaddr = '0;
              //ccif.ccsnoopaddr[!cachesel] = ccif.daddr[cachesel];
              //nextSnoopaddr[!cachesel] = ccif.daddr[cachesel];
              //nextInv[!cachesel] = ccwriteReg[cachesel];
      end
      READ0 : begin
              ccif.ramaddr = ccif.daddr[cachesel];
              ccif.ramREN = 1'b1;
              ccif.dload[cachesel] = ccif.ramload;
              if(ccif.ramstate == ACCESS) begin
                ccif.dwait[cachesel] = 1'b0;
              end
      end
      READ1 : begin
              ccif.ramaddr = ccif.daddr[cachesel];
              ccif.ramREN = 1'b1;
              ccif.dload[cachesel] = ccif.ramload;
              if(ccif.ramstate == ACCESS) begin
                ccif.dwait[cachesel] = 1'b0;
              end
      end
      DIRTYWB0 : begin
                 //nextSnoopaddr[!cachesel] = ccif.daddr[cachesel];
                 //ccif.ccsnoopaddr[!cachesel] = ccif.daddr[cachesel];
                 //nextInv[!cachesel] = ccwriteReg[cachesel];
                 ccif.dload[cachesel] = ccif.dstore[!cachesel];
                 ccif.ramaddr = ccif.daddr[!cachesel];
                 ccif.ramstore = ccif.dstore[!cachesel];
                 ccif.ramWEN = 1'b1;
                 //ccif.ccwait[~cachesel] = 1;
                 if(ccif.ramstate == ACCESS) begin
                   ccif.dwait = '0;
                   nextSnoopaddr[!cachesel] = '0;
                   nextInv[!cachesel] = '0;
                 end
      end
      DIRTYWB1 : begin
                 //nextSnoopaddr[!cachesel] = ccif.daddr[cachesel];
                 //ccif.ccsnoopaddr[!cachesel] = ccif.daddr[cachesel];
                 //nextInv[!cachesel] = ccwriteReg[cachesel];
                 ccif.dload[cachesel] = ccif.dstore[!cachesel];
                 ccif.ramaddr = ccif.daddr[!cachesel];
                 ccif.ramstore = ccif.dstore[!cachesel];
                 ccif.ramWEN = 1'b1;
                 //ccif.ccwait[~cachesel] = 1;
                 if(ccif.ramstate == ACCESS) begin
                   ccif.dwait = '0;
                   nextSnoopaddr[!cachesel] = '0;
                   nextInv[!cachesel] = '0;
                 end
      end
    endcase
  end

  /*assign ccif.iload = ccif.ramload; //right??
  assign ccif.dload = ccif.ramload; //right??

  assign ccif.ramstore = ccif.dstore;
  assign ccif.ramaddr = (ccif.dREN | ccif.dWEN) ? ccif.daddr : ccif.iaddr;
  assign ccif.ramWEN = ccif.dWEN;
  assign ccif.ramREN = ((ccif.iREN | ccif.dREN) && ~ccif.dWEN) ? 1'b1 : 1'b0;

  always_comb begin
    ccif.dwait = 1'b1;
    ccif.iwait = 1'b1;
sim:/memory_control_tb/DUT/state
    if((ccif.dREN | ccif.dWEN) && ccif.ramstate == ACCESS) begin
      ccif.dwait = 1'b0;
    end else if(ccif.iREN && ccif.ramstate == ACCESS) begin
      ccif.iwait = 1'b0;
    end
  end*/

endmodule
