create_clock -name clk -period 2 [get_ports "CK"]
set_clock_transition -rise 0.01 [get_clocks "clk"]
set_clock_transition -fall 0.01 [get_clocks "clk"]
set_clock_uncertainty 0.05 [get_clocks "clk"]

set_input_delay -max 1.0 [get_ports "START"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "B0"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "B1"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "B2"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "B3"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "A0"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "A1"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "A2"] -clock [get_clocks "clk"]
set_input_delay -max 1.0 [get_ports "A3"] -clock [get_clocks "clk"]



set_output_delay -max 1.0 [get_ports "P0"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P1"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P2"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P3"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P4"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P5"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P6"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "P7"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "CNTVCON2"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "CNTVCO2"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "READY"] -clock [get_clocks "clk"]


