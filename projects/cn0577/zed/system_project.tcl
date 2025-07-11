###############################################################################
## Copyright (C) 2022-2023, 2025 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# load script
source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# if the TWOLANES parameter is not defined, by default it will use TWOLANES=1
# configuration mode: one-lane (0) or two-lane (1)

set TWOLANES [get_env_param TWOLANES 1]

# if RESOLUTION parameter is not defined, by default it will use RESOLUTION=18
# options: 18 bits (18) or 16 bits (16)
set RESOLUTION [get_env_param RESOLUTION 18]

adi_project cn0577_zed 0 [list \
  TWOLANES [get_env_param TWOLANES 1 ] \
  RESOLUTION [get_env_param RESOLUTION 0 ] \
]

adi_project_files cn0577_zed [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc"]

adi_project_run cn0577_zed
