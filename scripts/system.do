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
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/RF/my_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {816341 ps}
