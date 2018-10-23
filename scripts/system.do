onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group datapath_cache /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/IF_ID
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/instr
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/IF_ID
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/instr
add wave -noupdate /system_tb/DUT/CPU/DP/rtypeIFID
add wave -noupdate /system_tb/DUT/CPU/DP/itypeIFID
add wave -noupdate /system_tb/DUT/CPU/DP/jtypeIFID
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/RF/my_reg
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group rfif -expand /system_tb/DUT/CPU/DP/RF/my_reg
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/stall_IFID
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/stall_PC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/flush_IFID
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/flush_IDEX
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/IDEX_tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/EXMEM_tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/PCSrc
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/rs
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/rt
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/destEX
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/stall_IFID
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/stall_PC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/flush_IFID
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/flush_IDEX
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/IDEX_tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/EXMEM_tmpPC
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/PCSrc
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/rs
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/rt
add wave -noupdate -group HDU /system_tb/DUT/CPU/DP/huif/destEX
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat1_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat2_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat1_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat2_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/npc_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/npc_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/addr_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/addr_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/WBctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/WBctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/MEMctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/MEMctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/EXctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/EXctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/ihit
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat1_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat2_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat1_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/rdat2_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/npc_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/npc_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/addr_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/addr_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/WBctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/WBctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/MEMctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/MEMctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/EXctrl_in
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/EXctrl_out
add wave -noupdate -group ID_EX /system_tb/DUT/CPU/DP/idexif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/rtypeIDEX
add wave -noupdate /system_tb/DUT/CPU/DP/itypeIDEX
add wave -noupdate /system_tb/DUT/CPU/DP/jtypeIDEX
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/outputport
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/portA
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/portB
add wave -noupdate -group aluif /system_tb/DUT/CPU/DP/aluif/outputport
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/store_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/store_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/aluout_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/aluout_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/baddr_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/baddr_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/jaddr_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/jaddr_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/reg31_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/reg31_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/npc_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/npc_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dest_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dest_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/imm_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/imm_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/zero_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/zero_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/WBctrl_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/WBctrl_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/MEMctrl_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/MEMctrl_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/ihit
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dhit
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/store_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/store_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/aluout_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/aluout_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/baddr_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/baddr_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/jaddr_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/jaddr_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/reg31_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/reg31_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/npc_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/npc_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dest_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dest_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/imm_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/imm_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/zero_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/zero_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/WBctrl_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/WBctrl_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/MEMctrl_in
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/MEMctrl_out
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/ihit
add wave -noupdate -expand -group EX_MEM /system_tb/DUT/CPU/DP/exmemif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/rtypeEXMEM
add wave -noupdate /system_tb/DUT/CPU/DP/jtypeEXMEM
add wave -noupdate /system_tb/DUT/CPU/DP/itypeEXMEM
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dmemload_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dmemload_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/aluout_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/aluout_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/npc_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/npc_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/imm_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/imm_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dest_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dest_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/WBctrl_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/WBctrl_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/ihit
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dhit
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dmemload_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dmemload_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/aluout_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/aluout_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/npc_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/npc_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/imm_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/imm_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dest_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dest_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/WBctrl_in
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/WBctrl_out
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/ihit
add wave -noupdate -group MEM_WB /system_tb/DUT/CPU/DP/memwbif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/rtypeMEMWB
add wave -noupdate /system_tb/DUT/CPU/DP/jtypeMEMWB
add wave -noupdate /system_tb/DUT/CPU/DP/itypeMEMWB
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group cache_control /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramREN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramWEN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramaddr
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramstore
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramload
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramstate
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memREN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memWEN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memaddr
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memstore
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramREN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramWEN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramaddr
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramstore
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramload
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/ramstate
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memREN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memWEN
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memaddr
add wave -noupdate -group cpu_ram /system_tb/DUT/prif/memstore
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {382016 ps} 1} {{Cursor 2} {1360000 ps} 0} {{Cursor 4} {245005 ps} 1}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 140
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
WaveRestoreZoom {0 ps} {1198082 ps}
