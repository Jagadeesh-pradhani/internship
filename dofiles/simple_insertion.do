set VERILOG "mcrb"
set TOP_MODULE "mcrb"
set CHAIN_LENGTH 2

// set PATH /home/01fe21bee114/DFT/DFT
set PATH ..

set_context dft -scan

read_verilog ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_opt.v
read_cell_library ${PATH}/inputs/MDT/test_Nangate.mdt 

set_current_design ${TOP_MODULE}
analyze_control_signals -auto
check_design_rules

set_scan_insertion_options -chain_length ${CHAIN_LENGTH}
analyze_scan_chains 

report_scan_elements    > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_${TOP_MODULE}_scan_elements.txt
report_scan_chains      > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_${TOP_MODULE}_scan_chains.txt
report_scan_cells       > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_${TOP_MODULE}_scan_cells.txt
report_scan_enable      > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_${TOP_MODULE}_scan_enable.txt

insert_test_logic -verbose

write_design -output_file ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/tessent_${TOP_MODULE}_scan_netlist.v -replace

set_system_mode setup
open_visualizer