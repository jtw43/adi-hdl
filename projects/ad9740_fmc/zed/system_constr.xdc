###############################################################################
## Copyright (C) 2025 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# ad9740 clk interface
set_property -dict {PACKAGE_PIN L18 IOSTANDARD TMDS_33} [get_ports ad9740_clk_p] ; ## H4  FMC-CLK0_P
set_property -dict {PACKAGE_PIN L19 IOSTANDARD TMDS_33} [get_ports ad9740_clk_n] ; ## H5  FMC-CLK0_N

# ad9744 interface
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[13]] ; ## G9  FMC-LA03_P
set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[12]] ; ## G10 FMC-LA03_N
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[11]] ; ## H10 FMC-LA04_P
set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[10]] ; ## C10 FMC-LA06_P
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[9]]  ; ## H11 FMC-LA04_N
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[8]]  ; ## D11 FMC-LA05_P
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[7]]  ; ## G12 FMC-LA08_P
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[6]]  ; ## H13 FMC-LA07_P
set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[5]]  ; ## G13 FMC-LA08_N
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[4]]  ; ## H14 FMC-LA07_N
set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[3]]  ; ## C11 FMC-LA06_N
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[2]]  ; ## D12 FMC-LA05_N
set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[1]]  ; ## D14 FMC-LA09_P
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS33}          [get_ports ad9740_data[0]]  ; ## D15 FMC-LA09_N

# adf4351 interface
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33 PULLTYPE PULLUP} [get_ports adf4351_spi_csn] ; ## H8  FMC-LA02_N
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33}                 [get_ports adf4351_spi_clk] ; ## H7  FMC-LA02_P
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33}                 [get_ports adf4351_spi_mosi]; ## H16 FMC-LA11_P
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33}                 [get_ports adf4351_le]      ; ## G16 FMC-LA12_N

# clocks
create_clock -name ad9740_clk -period 4.761 [get_ports ad9740_clk_p]

# Reconfigure the pins from Bank 34 and Bank 35 to use LVCMOS33 since VADJ must be set to 3.3V

# otg
set_property IOSTANDARD LVCMOS33 [get_ports otg_vbusoc]

# gpio (switches, leds and such)
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[0]]       ; ## BTNC
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[1]]       ; ## BTND
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[2]]       ; ## BTNL
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[3]]       ; ## BTNR
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[4]]       ; ## BTNU

set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[11]]      ; ## SW0
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[12]]      ; ## SW1
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[13]]      ; ## SW2
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[14]]      ; ## SW3
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[15]]      ; ## SW4
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[16]]      ; ## SW5
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[17]]      ; ## SW6
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[18]]      ; ## SW7

set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[27]]      ; ## XADC-GIO0
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[28]]      ; ## XADC-GIO1
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[29]]      ; ## XADC-GIO2
set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[30]]      ; ## XADC-GIO3

set_property IOSTANDARD LVCMOS33 [get_ports gpio_bd[31]]      ; ## OTG-RESETN