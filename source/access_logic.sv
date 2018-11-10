`include "cpu_types_pkg.vh"
`include "access_logic_if.vh"

import cpu_types_pkg::*;

module access_logic (
  access_logic_if.al alif
);

  always_comb begin
    alif.data_out = '0;
    alif.miss = 1'b1;
    alif.setsel = 1'b0;
    alif.WENcache = 1'b0;
    alif.cctrans = 1'b0;
    alif.ccwrite = 1'b0;
    alif.newDirty = 1'b0;
    alif.newValid = 1'b0;
    if(alif.snoop) begin
      if(alif.tagbits == alif.tag0 && alif.valid0 && !alif.dirty0) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b0;
        alif.data_out = alif.data0[alif.offset];
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b0;
        if(alif.ccinv) begin
          alif.WENcache = 1'b1;
        end
      end else if(alif.tagbits == alif.tag0 && alif.valid0 && alif.dirty0) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b0;
        alif.data_out = alif.data0[alif.offset];
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b1;
        if(alif.mytrans && alif.ccinv) begin
          alif.WENcache = 1'b1;
        end else if(alif.mytrans && !alif.ccinv) begin
          alif.WENcache = 1'b1;
          alif.newValid = 1'b1;
        end
      end else if(alif.tagbits == alif.tag1 && alif.valid1 && !alif.dirty1) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b1;
        alif.data_out = alif.data1[alif.offset];
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b0;
        if(alif.ccinv) begin
          alif.WENcache = 1'b1;
        end
      end else if(alif.tagbits == alif.tag1 && alif.valid1 && alif.dirty1) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b1;
        alif.data_out = alif.data1[alif.offset];
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b1;
        if(alif.mytrans && alif.ccinv) begin
          alif.WENcache = 1'b1;
        end else if(alif.mytrans && !alif.ccinv) begin
          alif.WENcache = 1'b1;
          alif.newValid = 1'b1;
        end
      end else begin
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b0;
      end
    end else if(alif.halt) begin
      alif.WENcache = 1'b0;
    end else if(alif.dmemREN) begin
      if(alif.tagbits == alif.tag0 && alif.valid0) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b0;
        alif.data_out = alif.data0[alif.offset];
      end else if(alif.tagbits == alif.tag1 && alif.valid1) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b1;
        alif.data_out = alif.data1[alif.offset];
      end
    end else if(alif.dmemWEN) begin
      if(alif.tagbits == alif.tag0 && alif.valid0 && alif.dirty0) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b0;
        alif.WENcache = 1'b1;
      end else if(alif.tagbits == alif.tag0 && alif.valid0 && !alif.dirty0) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b0;
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b1;
        if(alif.mytrans) begin
          alif.WENcache = 1'b1;
        end
      end else if(alif.tagbits == alif.tag1 && alif.valid1 && alif.dirty1) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b1;
        alif.WENcache = 1'b1;
      end else if(alif.tagbits == alif.tag1 && alif.valid1 && !alif.dirty1) begin
        alif.miss = 1'b0;
        alif.setsel = 1'b1;
        alif.cctrans = 1'b1;
        alif.ccwrite = 1'b1;
        if(alif.mytrans) begin
          alif.WENcache = 1'b1;
        end
      end
    end
  end

endmodule
