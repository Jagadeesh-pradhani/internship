set VERILOG "s298"
set TOP_MODULE "s298"
set CLK "CK"

set PATH ..


set_context patterns -scan
read_verilog ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/tessent_${TOP_MODULE}_scan_netlist.v
read_cell_library ${PATH}/inputs/MDT/test_Nangate.mdt 
set_current_design ${TOP_MODULE}

// add clocks and scan groups 
add_clocks 0 ${CLK}
// add_scan_groups group1 scan1.spf.proc
// add_scan_chains 1 group1 ts_si ts_so



set_system_mode analysis
set_fault_type stuck
add_faults -all
create_patterns

write_patterns ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/tessent_patterns_parallel.ascii -ascii -parallel -replace
write_patterns ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/tessent_patterns_parallel.v -verilog -parallel -replace
write_patterns ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/tessent_patterns_serial.v -verilog -serial -replace

report_patterns         > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_patterns.rpt
report_faults           > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_faults.rpt
report_faults -class DS > ${PATH}/reports/${TOP_MODULE}_REPORTS/tessent_faults_DS.rpt