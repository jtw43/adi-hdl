# minimal zcu106 constraints
#  constraints here mimic those in the similar ADI common zcu102 constraints file,
#  but using information taken from the Xilinx-supplied file 'zcu106_rev1.0_20180210.xdc'

# gpio (switches, leds and such)

set_property  -dict {PACKAGE_PIN  A17  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[0]]     ; ## GPIO_DIP_SW0   ;# Bank  67 VCCO - VADJ_FMC - IO_L1P_T0L_N0_DBC_67
set_property  -dict {PACKAGE_PIN  A16  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[1]]     ; ## GPIO_DIP_SW1   ;# Bank  67 VCCO - VADJ_FMC - IO_L1N_T0L_N1_DBC_67
set_property  -dict {PACKAGE_PIN  B16  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[2]]     ; ## GPIO_DIP_SW2   ;# Bank  67 VCCO - VADJ_FMC - IO_L2P_T0L_N2_67
set_property  -dict {PACKAGE_PIN  B15  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[3]]     ; ## GPIO_DIP_SW3   ;# Bank  67 VCCO - VADJ_FMC - IO_L2N_T0L_N3_67
set_property  -dict {PACKAGE_PIN  A15  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[4]]     ; ## GPIO_DIP_SW4   ;# Bank  67 VCCO - VADJ_FMC - IO_L3P_T0L_N4_AD15P_67
set_property  -dict {PACKAGE_PIN  A14  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[5]]     ; ## GPIO_DIP_SW5   ;# Bank  67 VCCO - VADJ_FMC - IO_L3N_T0L_N5_AD15N_67
set_property  -dict {PACKAGE_PIN  B14  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[6]]     ; ## GPIO_DIP_SW6   ;# Bank  67 VCCO - VADJ_FMC - IO_L4P_T0U_N6_DBC_AD7P_67
set_property  -dict {PACKAGE_PIN  B13  IOSTANDARD LVCMOS18} [get_ports gpio_bd_i[7]]     ; ## GPIO_DIP_SW7   ;# Bank  67 VCCO - VADJ_FMC - IO_L4N_T0U_N7_DBC_AD7N_67

set_property  -dict {PACKAGE_PIN  AG13  IOSTANDARD LVCMOS12} [get_ports gpio_bd_i[8]]    ; ## GPIO_SW_N	     ;# Bank  66 VCCO - VCC1V2   - IO_L15P_T2L_N4_AD11P_66
set_property  -dict {PACKAGE_PIN  AC14  IOSTANDARD LVCMOS12} [get_ports gpio_bd_i[9]]    ; ## GPIO_SW_E	     ;# Bank  66 VCCO - VCC1V2   - IO_T3U_N12_66
set_property  -dict {PACKAGE_PIN  AK12  IOSTANDARD LVCMOS12} [get_ports gpio_bd_i[10]]   ; ## GPIO_SW_W	     ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
set_property  -dict {PACKAGE_PIN  AP20  IOSTANDARD LVCMOS12} [get_ports gpio_bd_i[11]]   ; ## GPIO_SW_S	     ;# Bank  65 VCCO - VCC1V2   - IO_L1N_T0L_N1_DBC_65
set_property  -dict {PACKAGE_PIN  AL10  IOSTANDARD LVCMOS12} [get_ports gpio_bd_i[12]]   ; ## GPIO_SW_C	     ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66

set_property  -dict {PACKAGE_PIN  AL11  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[0]]    ; ## GPIO_LED_0     ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66
set_property  -dict {PACKAGE_PIN  AL13  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[1]]    ; ## GPIO_LED_1     ;# Bank  66 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_66
set_property  -dict {PACKAGE_PIN  AK13  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[2]]    ; ## GPIO_LED_2     ;# Bank  66 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_66
set_property  -dict {PACKAGE_PIN  AE15  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[3]]    ; ## GPIO_LED_3     ;# Bank  64 VCCO - VCC1V2   - IO_L19N_T3L_N1_DBC_AD9N_64
set_property  -dict {PACKAGE_PIN  AM8   IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[4]]    ; ## GPIO_LED_4     ;# Bank  66 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_66
set_property  -dict {PACKAGE_PIN  AM9   IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[5]]    ; ## GPIO_LED_5     ;# Bank  66 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_66
set_property  -dict {PACKAGE_PIN  AM10  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[6]]    ; ## GPIO_LED_6     ;# Bank  66 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_66
set_property  -dict {PACKAGE_PIN  AM11  IOSTANDARD LVCMOS12} [get_ports gpio_bd_o[7]]    ; ## GPIO_LED_7     ;# Bank  66 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_66

# rename SPI clocks
create_clock -name spi0_clk      -period 40   [get_pins -hier */EMIOSPI0SCLKO]
create_clock -name spi1_clk      -period 40   [get_pins -hier */EMIOSPI1SCLKO]
