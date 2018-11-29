onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/datomic
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/RegWEN
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/ALUSrc
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/ExtOp
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/zero
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/overflow
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/negative
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/dmemREN
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/dmemWEN
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/halt
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/branch
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/lui
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/tmpPC
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/RegDest
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/MemtoReg
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/opcode
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/funct
add wave -noupdate -expand -group core0 -expand -group control_unit /system_tb/DUT/CPU/DP0/cuif/ALUOP
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/negative
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/overflow
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/zero
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/ALUOP
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/portA
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/portB
add wave -noupdate -expand -group core0 -group alu /system_tb/DUT/CPU/DP0/aluif/outputport
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate -expand -group core0 -group rf /system_tb/DUT/CPU/DP0/RF/my_reg
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/rtypeIDEX
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/itypeIDEX
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/jtypeIDEX
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/rdat1_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/rdat2_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/rdat1_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/rdat2_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/npc_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/npc_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/instr_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/instr_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/datomic_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/datomic_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/addr_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/addr_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/WBctrl_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/WBctrl_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/MEMctrl_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/MEMctrl_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/EXctrl_in
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/EXctrl_out
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/ihit
add wave -noupdate -expand -group core0 -expand -group idex /system_tb/DUT/CPU/DP0/idexif/flush_IDEX
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/store_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/store_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/aluout_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/aluout_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/datomic_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/datomic_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/baddr_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/baddr_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/dmemload_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/dmemload_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/jaddr_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/jaddr_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/reg31_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/reg31_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/npc_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/npc_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/instr_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/instr_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/dest_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/dest_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/imm_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/imm_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/zero_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/zero_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/WBctrl_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/WBctrl_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/MEMctrl_in
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/MEMctrl_out
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/ihit
add wave -noupdate -expand -group core0 -group exmem /system_tb/DUT/CPU/DP0/exmemif/dhit
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/rtypeMEMWB
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/jtypeMEMWB
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/itypeMEMWB
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/dmemload_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/dmemload_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/aluout_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/aluout_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/npc_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/npc_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/instr_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/instr_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/imm_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/imm_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/dest_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/dest_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/WBctrl_in
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/WBctrl_out
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/ihit
add wave -noupdate -expand -group core0 -group memewb /system_tb/DUT/CPU/DP0/memwbif/dhit
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/stall_IFID
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/stall_PC
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/flush_IFID
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/flush_IDEX
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/dmemREN
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/tmpPC
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/IDEX_tmpPC
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/EXMEM_tmpPC
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/PCSrc
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/rs
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/rt
add wave -noupdate -expand -group core0 -group hazard /system_tb/DUT/CPU/DP0/huif/destEX
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/wenMEM
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/wenWB
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/rsEX
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/rtEX
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/destWB
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/destMEM
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/selA
add wave -noupdate -expand -group core0 -group {forward unit} /system_tb/DUT/CPU/DP0/fuif/selB
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/PC
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dhit
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/datomic
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dmemREN
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dmemWEN
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dmemload
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dmemstore
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/dcif/dmemaddr
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/DCACHE/link_reg
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/DCACHE/sc_succeed
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/CM0/DCACHE/addr_in
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/CM0/DCACHE/AL/alif/miss
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/CM0/DCACHE/set1
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/CM0/DCACHE/set0
add wave -noupdate -expand -group core0 -group caches /system_tb/DUT/CPU/CM0/DCACHE/CF/state
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/CM1/DCACHE/CF/state
add wave -noupdate -expand -group core1 -group caches -expand /system_tb/DUT/CPU/CM1/DCACHE/set0
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/CM1/DCACHE/set1
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -expand -group core1 -group caches /system_tb/DUT/CPU/CM1/DCACHE/CF/cfif/miss
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/RegWEN
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/ALUSrc
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/ExtOp
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/zero
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/overflow
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/negative
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/dmemREN
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/dmemWEN
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/halt
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/branch
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/lui
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/tmpPC
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/RegDest
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/MemtoReg
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/opcode
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/funct
add wave -noupdate -expand -group core1 -group control_unit /system_tb/DUT/CPU/DP1/cuif/ALUOP
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/negative
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/overflow
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/zero
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/ALUOP
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/portA
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/portB
add wave -noupdate -expand -group core1 -group alu /system_tb/DUT/CPU/DP1/aluif/outputport
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -expand -group core1 -group rf /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/rtypeIDEX
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/itypeIDEX
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/jtypeIDEX
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/rdat1_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/rdat2_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/rdat1_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/rdat2_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/npc_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/npc_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/instr_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/instr_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/addr_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/addr_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/WBctrl_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/WBctrl_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/MEMctrl_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/MEMctrl_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/EXctrl_in
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/EXctrl_out
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/ihit
add wave -noupdate -expand -group core1 -group idex /system_tb/DUT/CPU/DP1/idexif/flush_IDEX
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/store_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/store_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/aluout_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/aluout_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/baddr_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/baddr_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/dmemload_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/dmemload_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/jaddr_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/jaddr_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/reg31_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/reg31_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/npc_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/npc_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/instr_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/instr_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/dest_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/dest_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/imm_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/imm_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/zero_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/zero_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/WBctrl_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/WBctrl_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/MEMctrl_in
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/MEMctrl_out
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/ihit
add wave -noupdate -expand -group core1 -group exmem /system_tb/DUT/CPU/DP1/exmemif/dhit
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/rtypeMEMWB
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/jtypeMEMWB
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/itypeMEMWB
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/dmemload_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/dmemload_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/aluout_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/aluout_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/npc_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/npc_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/instr_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/instr_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/imm_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/imm_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/dest_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/dest_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/WBctrl_in
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/WBctrl_out
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/ihit
add wave -noupdate -expand -group core1 -group memwb /system_tb/DUT/CPU/DP1/memwbif/dhit
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/stall_IFID
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/stall_PC
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/flush_IFID
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/flush_IDEX
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/dmemREN
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/tmpPC
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/IDEX_tmpPC
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/EXMEM_tmpPC
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/PCSrc
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/rs
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/rt
add wave -noupdate -expand -group core1 -group hazard /system_tb/DUT/CPU/DP1/huif/destEX
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/wenMEM
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/wenWB
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/rsEX
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/rtEX
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/destWB
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/destMEM
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/selA
add wave -noupdate -expand -group core1 -group {forward unit} /system_tb/DUT/CPU/DP1/fuif/selB
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/PC
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/state
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/nextstate
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/cachesel
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/nextcachesel
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/coresel
add wave -noupdate -group memory_control /system_tb/DUT/CPU/CC/nextcoresel
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /system_tb/CLK
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/rtypeIFID
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/itypeIFID
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/jtypeIFID
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/rtypeEXMEM
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/jtypeEXMEM
add wave -noupdate -expand -group core0 /system_tb/DUT/CPU/DP0/itypeEXMEM
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/rtypeIFID
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/itypeIFID
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/jtypeIFID
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/rtypeEXMEM
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/jtypeEXMEM
add wave -noupdate -expand -group core1 /system_tb/DUT/CPU/DP1/itypeEXMEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16659518803 ps} 0} {{Cursor 2} {33470421882 ps} 0} {{Cursor 3} {90244 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 351
configure wave -valuecolwidth 273
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1686349 ps}
