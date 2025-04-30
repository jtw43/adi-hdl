// ***************************************************************************
// ***************************************************************************
// Copyright (C) 2014-2024 Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/main/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module packetizer #(

  parameter AXIS_DATA_WIDTH = 512,
  parameter CHANNELS = 4,
  parameter INPUT_SAMPLE_SIZE = 16
) (

  input  wire                         clk,
  input  wire                         rstn,

  // input
  input  wire                         input_axis_tvalid,
  input  wire                         input_axis_tready,

  input  wire [$clog2(CHANNELS):0]    input_enable,
  input  wire [15:0]                  sample_count,
  output reg                          packet_tlast
);

  reg  [15:0] sample_counter;
  reg  [15:0] packet_size_dynamic;
  wire [15:0] packet_size_dynamic_calc;

  assign packet_size_dynamic_calc = sample_count[15:$clog2(AXIS_DATA_WIDTH/INPUT_SAMPLE_SIZE)]*input_enable;

  always @(posedge clk)
  begin
    if (!rstn) begin
      packet_size_dynamic <= 'd0;
    end else begin
      packet_size_dynamic <= packet_size_dynamic_calc;
    end
  end

  always @(posedge clk)
  begin
    if (!rstn) begin
      sample_counter <= 8'd0;
      packet_tlast <= 1'b0;
    end else begin
      if (input_axis_tvalid && input_axis_tready) begin
        if (sample_counter < packet_size_dynamic-1) begin
          sample_counter <= sample_counter + 1;
        end else begin
          sample_counter <= 8'd0;
          packet_tlast <= 1'b1;
        end
      end else begin
        packet_tlast <= 1'b0;
      end
    end
  end

endmodule
