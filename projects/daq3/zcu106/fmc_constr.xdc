
# daq3

set_property -dict {PACKAGE_PIN T8}  [get_ports rx_ref_clk_p]                                  ; ## B20  FMC0_GBTCLK1_M2C_C_P  MGTREFCLK0P_227
set_property -dict {PACKAGE_PIN T7}  [get_ports rx_ref_clk_n]                                  ; ## B21  FMC0_GBTCLK1_M2C_C_N  MGTREFCLK0N_227
set_property -dict {PACKAGE_PIN V8}  [get_ports tx_ref_clk_p]                                  ; ## D4   FMC0_GBTCLK0_M2C_C_P  MGTREFCLK0P_226
set_property -dict {PACKAGE_PIN V7}  [get_ports tx_ref_clk_n]                                  ; ## D5   FMC0_GBTCLK0_M2C_C_N  MGTREFCLK0N_226

set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVDS} [get_ports rx_sync_p]                     ; ## D8   FMC0_LA01_CC_P        IO_L16P_T2U_N6_QBC_AD3P_67
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVDS} [get_ports rx_sync_n]                     ; ## D9   FMC0_LA01_CC_N        IO_L16N_T2U_N7_QBC_AD3N_67
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports rx_sysref_p]    ; ## G9   FMC0_LA03_P           IO_L23P_T3U_N8_67
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports rx_sysref_n]    ; ## G10  FMC0_LA03_N           IO_L23N_T3U_N9_67
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports tx_sync_p]      ; ## H7   FMC0_LA02_P           IO_L19P_T3L_N0_DBC_AD9P_67
set_property -dict {PACKAGE_PIN K20 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports tx_sync_n]      ; ## H8   FMC0_LA02_N           IO_L19N_T3L_N1_DBC_AD9N_67
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports tx_sysref_p]    ; ## H10  FMC0_LA04_P           IO_L24P_T3U_N10_67
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports tx_sysref_n]    ; ## H11  FMC0_LA04_N           IO_L24N_T3U_N11_67

set_property -dict {PACKAGE_PIN V4}  [get_ports rx_data_p[0]]                                  ; ## A10  FMC0_DP3_M2C_P        MGTHRXP0_226
set_property -dict {PACKAGE_PIN V3}  [get_ports rx_data_n[0]]                                  ; ## A11  FMC0_DP3_M2C_N        MGTHRXN0_226
set_property -dict {PACKAGE_PIN R2}  [get_ports rx_data_p[1]]                                  ; ## C6   FMC0_DP0_M2C_P        MGTHRXP2_226
set_property -dict {PACKAGE_PIN R1}  [get_ports rx_data_n[1]]                                  ; ## C7   FMC0_DP0_M2C_N        MGTHRXN2_226
set_property -dict {PACKAGE_PIN P4}  [get_ports rx_data_p[2]]                                  ; ## A6   FMC0_DP2_M2C_P        MGTHRXP3_226
set_property -dict {PACKAGE_PIN P3}  [get_ports rx_data_n[2]]                                  ; ## A7   FMC0_DP2_M2C_N        MGTHRXN3_226
set_property -dict {PACKAGE_PIN U2}  [get_ports rx_data_p[3]]                                  ; ## A2   FMC0_DP1_M2C_P        MGTHRXP1_226
set_property -dict {PACKAGE_PIN U1}  [get_ports rx_data_n[3]]                                  ; ## A3   FMC0_DP1_M2C_N        MGTHRXN1_226
set_property -dict {PACKAGE_PIN U6}  [get_ports tx_data_p[0]]                                  ; ## A30  FMC0_DP3_C2M_P        MGTHTXP0_226
set_property -dict {PACKAGE_PIN U5}  [get_ports tx_data_n[0]]                                  ; ## A31  FMC0_DP3_C2M_N        MGTHTXN0_226
set_property -dict {PACKAGE_PIN R6}  [get_ports tx_data_p[1]]                                  ; ## C2   FMC0_DP0_C2M_P        MGTHTXP2_226
set_property -dict {PACKAGE_PIN R5}  [get_ports tx_data_n[1]]                                  ; ## C3   FMC0_DP0_C2M_N        MGTHTXN2_226
set_property -dict {PACKAGE_PIN N6}  [get_ports tx_data_p[2]]                                  ; ## A26  FMC0_DP2_C2M_P        MGTHTXP3_226
set_property -dict {PACKAGE_PIN N5}  [get_ports tx_data_n[2]]                                  ; ## A27  FMC0_DP2_C2M_N        MGTHTXN3_226
set_property -dict {PACKAGE_PIN T4}  [get_ports tx_data_p[3]]                                  ; ## A22  FMC0_DP1_C2M_P        MGTHTXP1_226
set_property -dict {PACKAGE_PIN T3}  [get_ports tx_data_n[3]]                                  ; ## A23  FMC0_DP1_C2M_N        MGTHTXN1_226

set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVDS} [get_ports sysref_p]                      ; ## D17  FMC0_LA13_P           IO_L14P_T2L_N2_GC_67
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVDS} [get_ports sysref_n]                      ; ## D18  FMC0_LA13_N           IO_L14N_T2L_N3_GC_67
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS18} [get_ports dac_txen]                  ; ## G16  FMC0_LA12_N           IO_L17N_T2U_N9_AD10N_67
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS18} [get_ports adc_pd]                    ; ## C10  FMC0_LA06_P           IO_L15P_T2L_N4_AD11P_67

set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS18} [get_ports clkd_status[0]]            ; ## G12  FMC0_LA08_P           IO_L9P_T1L_N4_AD12P_67
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS18} [get_ports clkd_status[1]]            ; ## G13  FMC0_LA08_N           IO_L9N_T1L_N5_AD12N_67
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS18} [get_ports dac_irq]                   ; ## G15  FMC0_LA12_P           IO_L17P_T2U_N8_AD10P_67
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS18} [get_ports adc_fda]                   ; ## H16  FMC0_LA11_P           IO_L5P_T0U_N8_AD14P_67
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS18} [get_ports adc_fdb]                   ; ## H17  FMC0_LA11_N           IO_L5N_T0U_N9_AD14N_67

set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports trig_p]         ; ## H13  FMC0_LA07_P           IO_L20P_T3L_N2_AD1P_67
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports trig_n]         ; ## H14  FMC0_LA07_N           IO_L20N_T3L_N3_AD1N_67

set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS18} [get_ports spi_csn_clk]               ; ## D11  FMC0_LA05_P           IO_L21P_T3L_N4_AD8P_67
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS18} [get_ports spi_clk]                   ; ## D12  FMC0_LA05_N           IO_L21N_T3L_N5_AD8N_67
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS18} [get_ports spi_csn_dac]               ; ## C14  FMC0_LA10_P           IO_L22P_T3U_N6_DBC_AD0P_67
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS18} [get_ports spi_csn_adc]               ; ## D15  FMC0_LA09_N           IO_L18N_T2U_N11_AD2N_67
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS18} [get_ports spi_sdio]                  ; ## D14  FMC0_LA09_P           IO_L18P_T2U_N10_AD2P_67
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS18} [get_ports spi_dir]                   ; ## C11  FMC0_LA06_N           IO_L15N_T2L_N5_AD11N_67
