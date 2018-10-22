onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group dpif /dcache_tb/dpif/halt
add wave -noupdate -group dpif /dcache_tb/dpif/dhit
add wave -noupdate -group dpif /dcache_tb/dpif/datomic
add wave -noupdate -group dpif /dcache_tb/dpif/dmemREN
add wave -noupdate -group dpif /dcache_tb/dpif/dmemWEN
add wave -noupdate -group dpif /dcache_tb/dpif/flushed
add wave -noupdate -group dpif /dcache_tb/dpif/dmemload
add wave -noupdate -group dpif /dcache_tb/dpif/dmemstore
add wave -noupdate -group dpif /dcache_tb/dpif/dmemaddr
add wave -noupdate -expand -group dcache /dcache_tb/DUT/alif/miss
add wave -noupdate -expand -group dcache /dcache_tb/cif/dwait
add wave -noupdate -expand -group dcache /dcache_tb/cif/dREN
add wave -noupdate -expand -group dcache /dcache_tb/cif/dWEN
add wave -noupdate -expand -group dcache /dcache_tb/cif/dload
add wave -noupdate -expand -group dcache /dcache_tb/cif/dstore
add wave -noupdate -expand -group dcache /dcache_tb/cif/daddr
add wave -noupdate -expand -group dcache /dcache_tb/DUT/CF/state
add wave -noupdate -expand -group dut /dcache_tb/DUT/CLK
add wave -noupdate -expand -group dut /dcache_tb/DUT/nRST
add wave -noupdate -expand -group dut /dcache_tb/DUT/set0
add wave -noupdate -expand -group dut /dcache_tb/DUT/set1
add wave -noupdate -expand -group dut /dcache_tb/DUT/lru_reg
add wave -noupdate -expand -group dut /dcache_tb/DUT/hitct
add wave -noupdate -expand -group dut /dcache_tb/DUT/last_dREN
add wave -noupdate -expand -group dut /dcache_tb/DUT/tagbits
add wave -noupdate -expand -group dut /dcache_tb/DUT/offset
add wave -noupdate -expand -group dut /dcache_tb/DUT/index_in
add wave -noupdate -expand -group dut /dcache_tb/DUT/cfif/control_offset
add wave -noupdate -expand -group dut /dcache_tb/DUT/alif/WENcache
add wave -noupdate -expand -group dut /dcache_tb/DUT/cfif/dwait
add wave -noupdate -expand -group dut /dcache_tb/DUT/cfif/flushing
add wave -noupdate -expand -group dut /dcache_tb/DUT/cfif/ct
add wave -noupdate -expand -group dut /dcache_tb/DUT/i
add wave -noupdate /dcache_tb/CLK
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramREN
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramWEN
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramaddr
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramstore
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramload
add wave -noupdate -expand -group ramif /dcache_tb/ramif/ramstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {81336 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 363
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
WaveRestoreZoom {0 ps} {74152 ps}
