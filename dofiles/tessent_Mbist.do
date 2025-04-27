set_context dft -rtl
read_cell_library ../inputs/MDT/slow.atpglib


set_design_source -format tcd_memory -y ../inputs/TCD -extension tcd_mem_lib


//dofile ../tasks/cpu_sys/read_lib.do
read_verilog ../inputs/netlist/sram.v -interface_only
read_verilog ../inputs/netlist/cpu_sys.v

set_simulation_library_sources -v ../../DFT_LIB/LIB/slow.v



set_current_design cpu_sys_emep_top_edlm_mem_20__4h6_
add_black_boxes -auto

report_memory_instances
set_design_level physical_block
set_dft_specification_requirements -memory_test on 
add_clock clk -period 12ns -label clk
check_design_rules
set spec [create_dft_specification]
report_config_data $spec

process_dft_specification
extract_icl

// create_pattern_specification
set spec [create_patterns_specification -replace]
report_config_data $spec
// delete_config_element $spec/Patterns(MemoryBist_P1)
// delete_config_element $spec/Patterns(MemoryBist_ParallelRetentionTest_P1)
process_pattern_specification
set_testbench_simulation_options -parallel_simulations maxcpu
// set_testbench_simulation_options questa -simulator_options {-timescale=1ns/1ps +v2k_generate +no_timing_check}
run_testbench_simulations -simulator Questa
check_testbench_simulations -report_status
