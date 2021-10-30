# input
set_property -dict { PACKAGE_PIN B9     IOSTANDARD LVCMOS33 } [get_ports {vote[0]}];
set_property -dict { PACKAGE_PIN D11    IOSTANDARD LVCMOS33 } [get_ports {vote[1]}];
set_property -dict { PACKAGE_PIN B11    IOSTANDARD LVCMOS33 } [get_ports {vote[2]}];
set_property -dict { PACKAGE_PIN B12    IOSTANDARD LVCMOS33 } [get_ports {vote[3]}];
set_property -dict { PACKAGE_PIN A10    IOSTANDARD LVCMOS33 } [get_ports {vote[4]}];

# output
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports {pass}];

# other
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]