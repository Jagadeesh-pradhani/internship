
set VERILOG momal_route
set TOP_MODULE momal
# set PATH /home/01fe21bee114/DFT/DFTs
set PATH ..

read_libs ${PATH}/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
read_physical -lef ${PATH}/inputs/LEF/NangateOpenCellLibrary.lef
read_hdl ${PATH}/inputs/RTL/${VERILOG}.v   

elaborate ${TOP_MODULE}
write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_elaborate.v
read_sdc ${PATH}/inputs/SDC/${TOP_MODULE}_constraints.sdc

set_db dft_scan_style muxed_scan
set_db dft_prefix dft_
define_shift_enable -name SE -active high -create_port SE
check_dft_rules
syn_generic
write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_syn.v
syn_map
write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_map.v
syn_opt
write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_opt.v

report_area > ${PATH}/reports/${TOP_MODULE}_REPORTS/genus_${TOP_MODULE}_area.rep
report_power > ${PATH}/reports/${TOP_MODULE}_REPORTS/genus_${TOP_MODULE}_power.rep
report_gates > ${PATH}/reports/${TOP_MODULE}_REPORTS/genus_${TOP_MODULE}_gates.rep
report_timing > ${PATH}/reports/${TOP_MODULE}_REPORTS/genus_${TOP_MODULE}_timing.rep
report_qor -levels_of_logic -power -exclude_constant_nets > ${PATH}/reports/${TOP_MODULE}_REPORTS/genus_${TOP_MODULE}_qor_all.rep

check_dft_rules
set_db design:${TOP_MODULE} .dft_min_number_of_scan_chains 1
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
connect_scan_chains -auto_create_chains
syn_opt -incr
report_scan_chains
write_dft_atpg -library ${PATH}/inputs/LIB/slow.v
write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_${TOP_MODULE}_netlist_dft.v
write_sdc > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_${TOP_MODULE}_sdc_dft.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split -setuphold split > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_dft_delays.sdf
write_scandef > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_${TOP_MODULE}_scanDEF.scandef
gui_show