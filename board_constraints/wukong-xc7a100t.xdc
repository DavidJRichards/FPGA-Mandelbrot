# 50 MHz Clock definition
#set_property -dict { PACKAGE_PIN M21   IOSTANDARD LVCMOS33 } [get_ports { CLOCK_50 }]; 
#create_clock -name CLOCK_50 -period 20.000 [get_ports {CLOCK_50}]

# 33.333 MHz Clock definition
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports CLOCK_33]
create_clock -period 30.0 -name CLOCK_33 [get_ports CLOCK_33]


# HDMI
#set_property -dict { PACKAGE_PIN G2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[2]   }];
#set_property -dict { PACKAGE_PIN G1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[2] }];

#set_property -dict { PACKAGE_PIN F2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[1]   }];
#set_property -dict { PACKAGE_PIN E2   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[1] }];

#set_property -dict { PACKAGE_PIN E1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX[0]   }];
#set_property -dict { PACKAGE_PIN D1   IOSTANDARD TMDS_33 } [get_ports { HDMI_TX_N[0] }];

#set_property -dict { PACKAGE_PIN D4   IOSTANDARD TMDS_33 } [get_ports { HDMI_CLK     }];
#set_property -dict { PACKAGE_PIN C4   IOSTANDARD TMDS_33 } [get_ports { HDMI_CLK_N   }];

#########################################################
# TMDS (DVI, HDMI)                                      #
#########################################################
# Connector DATA 1
set_property -dict {PACKAGE_PIN H17 IOSTANDARD TMDS_33} [get_ports {HDMI_CLK_N}]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD TMDS_33} [get_ports {HDMI_CLK}]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[0]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[0]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[1]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[1]}]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD TMDS_33} [get_ports {HDMI_TX_N[2]}]
set_property -dict {PACKAGE_PIN F19 IOSTANDARD TMDS_33} [get_ports {HDMI_TX[2]}]


# Keyboard
#set_property -dict { PACKAGE_PIN AC26   IOSTANDARD LVCMOS33 } [get_ports { PS2_CLOCK   }];
#set_property -dict { PACKAGE_PIN AB26   IOSTANDARD LVCMOS33 } [get_ports { PS2_DATA    }];
##################################
# J3, PS2 interface
##################################
set_property PACKAGE_PIN V13 [get_ports {PS2_DATA}]
set_property PULLUP true [get_ports {PS2_DATA}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_DATA}]

set_property PACKAGE_PIN U12 [get_ports {PS2_CLOCK}]
set_property PULLUP true [get_ports {PS2_CLOCK}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_CLOCK}]
