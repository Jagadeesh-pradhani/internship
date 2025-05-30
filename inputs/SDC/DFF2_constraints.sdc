create_clock -name clk -period 2  [get_ports "clk"]
set_clock_transition -rise 0.01 [get_clocks "clk"]
set_clock_transition -fall 0.01 [get_clocks "clk"]
set_clock_transition 0.05 [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "D"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "Q"] -clock [get_clocks "clk"]
