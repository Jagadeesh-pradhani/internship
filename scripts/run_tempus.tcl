set VERILOG mcrb
set TOP_MODULE mcrb
# set PATH /home/01fe21bee114/DFT/DFTs
set PATH ..


read_lib ${PATH}/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib

set_global timing_apply_default_primary_input_assertion false
set load_netlist_ignore_undefined_cell true


read_verilog ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_opt.v
 
set_top_module ${TOP_MODULE} 

read_sdc ${PATH}/inputs/SDC/${TOP_MODULE}_constraints.sdc
report_timing -max_paths 10 > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_timing_path.rpt

report_clock_timing -type summary > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_clock_summary.rpt
set_global report_timing_format {hpin cell arc slew load delay arrival}
check_timing -verbose -type {loops inputs endpoints clocks constant_collision clock_gating_inferred clock_clipping} -include_warning clocks_masked_by_another_clock > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_check_timing_verbose.rpt
check_timing -check_only {clock_crossing} -verbose > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_clock_crossings.rpt
report_clocks -groups > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_report_clock_groups.rpt
report_constraint -all_violators > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_report_allViolators.rpt
report_timing -check_type hold > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_report_hold.rpt
report_timing -check_type setup > ${PATH}/reports/${TOP_MODULE}_REPORTS/tempus_report_setup.


# report_timing -from skew_addr_cntr_reg[0]/Q  -to skew_addr_cntr_reg[4]/D