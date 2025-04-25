yosys -import
set VERILOG vorca_fixed
set TOP_MODULE vorca
set PATH ..

set LIB slow


read_liberty -lib -ignore_miss_dir -setattr blackbox ${PATH}/inputs/LIB/${LIB}.lib
read_verilog ${PATH}/inputs/RTL/${VERILOG}.v 
hierarchy -check -top ${TOP_MODULE}
# wss
procs
opt
memory
opt
techmap
opt
dfflibmap -liberty ${PATH}/inputs/LIB/${LIB}.lib
opt
abc -liberty ${PATH}/inputs/LIB/${LIB}.lib
flatten
setundef -zero
clean -purge
opt
clean
stat -liberty ${PATH}/inputs/LIB/${LIB}.lib
renames -enumerate
write_verilog -noattr ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/yosys_netlist.v
write_json ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/yosys_netlist.json
show -format dot -colors 2 -width -stretch -prefix ${PATH}/outputs/${TOP_MODULE}_OUTPUTS/yosys_netlist ${TOP_MODULE}
