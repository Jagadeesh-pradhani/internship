# Yosys
select i:*
select -list

select i:test_si1 %co o:test_so1 %ci %x
select t:TLATNTSCAX12
select n:test_si1

# 
select i:ts_si %co* o:ts_so %ci* %i

select i:test_si %co* o:o_dbg_config %ci* %i

select i:test_si %co* t:SDFFR* %i

#
select x:o_adj_config %co* t:SDFFR* %i

show -format dot


# iv
select i_reset_
select i:i_reset_ %co* t:SDFFR* %i


# 
read_liberty -lib ../../DFT_LIB/LIB/slow.lib
read_liberty -lib ../../DFT_LIB/LIB/NangateOpenCellLibrary_slow_conditional_ccs.lib
read_verilog ../outputs/DFF2_OUTPUTS/genus_opt.v
hierarchy -check -top  DFF2
proc; opt; flatten
dfflibmap -liberty ../../DFT_LIB/LIB/slow.lib
abc -liberty ../../DFT_LIB/LIB/slow.lib
opt
write_verilog mapper.v

