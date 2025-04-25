
set VERILOG mcrb
set TOP_MODULE mcrb
set PATH ..

# params
set CLK_GATING false

read_libs ${PATH}/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
read_physical -lef ${PATH}/inputs/LEF/NangateOpenCellLibrary.lef
read_hdl ${PATH}/inputs/RTL/${VERILOG}.v   

# Clock gating
# set_db lp_insert_clock_gating ${CLK_GATING}

elaborate ${TOP_MODULE}

# Add custom library cell
# default_emulate_libset_max/NangateOpenCellLibrary/CLKGATETST_X1

# set CGIC_NAME default_emulate_libset_max/NangateOpenCellLibrary/CLKGATETST_X1
# set_db design:${TOP_MODULE} .lp_clock_gating_cell [get_db lib_cells ${CGIC_NAME}]


write_hdl > ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/genus_elaborate.v
read_sdc ${PATH}/inputs/SDC/${TOP_MODULE}_constraints.sdc


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


gui_show