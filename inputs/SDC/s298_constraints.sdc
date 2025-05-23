create_clock -name clk -period 2 [get_ports "CK"]
set_clock_transition -rise 0.01 [get_clocks "clk"]
set_clock_transition -fall 0.01 [get_clocks "clk"]
set_clock_uncertainty 0.05 [get_clocks "clk"]

set_input_delay -max 1.0 [get_ports "G0"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "G1"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "G2"] -clock [get_clocks "clk"]


set_output_delay -max 1.0 [get_ports "G117"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "G118"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "G132"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "G133"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "G66"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "G67"] -clock [get_clocks "clk"]

