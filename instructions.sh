tcsh
source ~/cshrc_cadence1  
source ~/cshrc_ment123


cd DFT/run

# Genus
genus -f ../scripts/run_genus_synth.tcl
 

# Tempus
tempus
source  ../scripts/run_tempus.tcl


# Tessent
tessent -shell -dofile ../dofiles/simple_insertion.do -logfile log -replace


# Yosys
yosys
tcl ../scripts/run_yosys.tcl


## replacement commands


# alcazar test
grep NOR2BX2 ../inputs/RTL/test.v | sed 's/\.A(/.AN(/g'
grep -E "NOR[0-9]+BX[0-9]+" ../inputs/RTL/test.v

sed -i '/NOR3BX1/s/\.A(/.AN(/g' ../inputs/RTL/test.v
sed -i '/MX2X1/s/\.sel(/.S0(/g' ../inputs/RTL/test.v


# Final commands
# Broken Signal Names
perl -0777 -i -pe 's/\n(?=(?!(?:module|endmodule)\b)[^ \t])//g' ../inputs/RTL/alcazar_fixed.v

# Incorrect Pin Mappings in Standard Cells:
sed -i '/NAND[0-9]\+BX[0-9]\+/s/\.A(/.AN(/g' ../inputs/RTL/alcazar_fixed.v
sed -i '/NOR[0-9]\+BX[0-9]\+/s/\.A(/.AN(/g' ../inputs/RTL/alcazar_fixed.v
sed -i '/MX[0-9]\+X[0-9]\+/s/\.sel(/.S0(/g' ../inputs/RTL/alcazar_fixed.v
sed -i '/MXI[0-9]\+X[0-9]\+/s/\.sel(/.S0(/g' ../inputs/RTL/alcazar_fixed.v



