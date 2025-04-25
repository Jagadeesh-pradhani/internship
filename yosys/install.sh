# netlistsvg for json view
https://neilturley.dev/netlistsvg/

# https://github.com/YosysHQ/yosys/

git clone --recurse-submodules https://github.com/YosysHQ/yosys.git
cd yosys
make
sudo make install

# sudo apt install yosys
sudo apt install graphviz
sudo apt install tkdiff


# Yosys simple example
read_verilog ../inputs/RTL/DFF2.v
hierarchy -check -top DFF2
read_verilog -lib ../inputs/LIB/cmos_cells.v
synth
dfflibmap -liberty ../inputs/LIB/cmos_cells.lib
abc -liberty ../inputs/LIB/cmos_cells.lib
opt_clean
write_verilog synth.v
write_json synth.json
show -prefix synth -notitle -colors 2 -width -format dot

select -count NOR


# 2 actual
read_liberty -lib -ignore_miss_dir -setattr blackbox ../inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
read_verilog ../DFT/inputs/RTL/DFF2.v
hierarchy -check -top DFF2
proc
opt
memory
opt
techmap
opt
dfflibmap -liberty ../DFT/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
opt
abc -liberty ../DFT/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
flatten
setundef -zero
clean -purge
opt
clean
stat -liberty ../DFT/inputs/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
rename -enumerate
write_verilog -noattr ../DFT/run/synth.v
write_json synth.json
show -prefix synth -notitle -colors 2 -width -format dot
show vorca

# Compare
tkdiff ../inputs/RTL/DFF2.v synth.v


