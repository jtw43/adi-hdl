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

`include "macro_definitions.vh"

module rx_arbiter #(

  parameter AXIS_DATA_WIDTH = 512,
  parameter CHANNELS = 4
) (

  input  wire                         clk,
  input  wire                         rstn,

  input  wire                         start_app,
  input  wire [15:0]                  packet_size,

  // Ethernet header
  input  wire [48-1:0]                ethernet_destination_MAC,
  input  wire [48-1:0]                ethernet_source_MAC,
  input  wire [16-1:0]                ethernet_type,

  // IPv4 header
  input  wire [4-1:0]                 ip_version,
  input  wire [4-1:0]                 ip_header_length,
  input  wire [8-1:0]                 ip_type_of_service,
  input  wire [16-1:0]                ip_identification,
  input  wire [3-1:0]                 ip_flags,
  input  wire [13-1:0]                ip_fragment_offset,
  input  wire [8-1:0]                 ip_time_to_live,
  input  wire [8-1:0]                 ip_protocol,
  input  wire [32-1:0]                ip_source_IP_address,
  input  wire [32-1:0]                ip_destination_IP_address,

  // UDP header
  input  wire [16-1:0]                udp_source,
  input  wire [16-1:0]                udp_destination,
  input  wire [16-1:0]                udp_checksum,

  // Input
  input  wire                         input_clk,
  input  wire                         input_rstn,

  input  wire                         input_axis_tvalid,
  input  wire                         input_axis_tready,
  input  wire [AXIS_DATA_WIDTH-1:0]   input_axis_tdata,
  input  wire                         input_axis_tlast,

  input  wire [CHANNELS-1:0]          output_enable,

  output reg                          valid,
  output reg                          switch
);

  function [$clog2(CHANNELS):0] converters(input [CHANNELS-1:0] input_enable);
    integer i;
    begin
      converters = 0;
      for (i=0; i<CHANNELS; i=i+1) begin
        converters = converters + input_enable[i];
      end
    end
  endfunction

  `HTOND(16)
  `HTOND(32)
  `HTOND(48)

  localparam HEADER_LENGTH = 336;

  wire [CHANNELS-1:0] output_enable_cdc;

  sync_data #(
    .NUM_OF_BITS(CHANNELS)
  ) sync_data_output_enable (
    .in_clk(input_clk),
    .in_data(output_enable),
    .out_clk(clk),
    .out_data(output_enable_cdc));

  reg [32-1:0] ip_header_checksum_reg0;
  reg [32-1:0] ip_header_checksum_reg1;

  reg [16-1:0] ip_total_length;
  reg [16-1:0] ip_header_checksum;
  reg [16-1:0] udp_length;

  // udp total length calculation
  always @(posedge clk)
  begin
    if (!rstn) begin
      udp_length <= 16'd0;
    end else begin
      udp_length <= 16'h8 + packet_size/(2**$clog2(CHANNELS))*converters(output_enable_cdc);
    end
  end

  // ip total length calculation
  always @(posedge clk)
  begin
    if (!rstn) begin
      ip_total_length <= 16'h0;
    end else begin
      ip_total_length <= 4*ip_header_length + udp_length;
    end
  end

  // ip header checksum calculation
  always @(posedge clk)
  begin
    if (!rstn) begin
      ip_header_checksum_reg0 <= 'd0;
      ip_header_checksum_reg1 <= 'd0;
      ip_header_checksum <= 'd0;
    end else begin
      ip_header_checksum_reg0 <=
        {16'h0000, {ip_version, ip_header_length, ip_type_of_service}} +
        {16'h0000, ip_total_length} +
        {16'h0000, ip_identification} +
        {16'h0000, {ip_flags, ip_fragment_offset}} +
        {16'h0000, {ip_time_to_live, ip_protocol}} +
        {16'h0000, ip_destination_IP_address[31:16]} +
        {16'h0000, ip_destination_IP_address[15:0]} +
        {16'h0000, ip_source_IP_address[31:16]} +
        {16'h0000, ip_source_IP_address[15:0]};

      ip_header_checksum_reg1 <= ip_header_checksum_reg0[31:16] + ip_header_checksum_reg0[15:0];

      ip_header_checksum <= ~ip_header_checksum_reg1;
    end
  end

  wire [HEADER_LENGTH-1:0] header_src_dst, header_src_dst_mask;
  wire [HEADER_LENGTH-1:0] header_length_checksum, header_length_checksum_mask;

  // header source-destination masks
  assign header_src_dst = {
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16(udp_source),
    htond_16(udp_destination),
    htond_32(ip_source_IP_address),
    htond_32(ip_destination_IP_address),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_48(ethernet_destination_MAC),
    htond_48(ethernet_source_MAC)};
  assign header_src_dst_mask = {
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b1}},
    {16{1'b1}},
    {32{1'b1}},
    {32{1'b1}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {48{1'b1}},
    {48{1'b1}}};

  // header length and checksum concatenation
  assign header_length_checksum = {
    htond_16(udp_checksum),
    htond_16(udp_length),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_32({32{1'b0}}),
    htond_32({32{1'b0}}),
    htond_16(ip_header_checksum),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_16(ip_total_length),
    htond_16({16{1'b0}}),
    htond_16({16{1'b0}}),
    htond_48({48{1'b0}}),
    htond_48({48{1'b0}})};
  assign header_length_checksum_mask = {
    {16{1'b1}},
    {16{1'b1}},
    {16{1'b0}},
    {16{1'b0}},
    {32{1'b0}},
    {32{1'b0}},
    {16{1'b1}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b0}},
    {16{1'b1}},
    {16{1'b0}},
    {16{1'b0}},
    {48{1'b0}},
    {48{1'b0}}};

  reg state;

  always @(posedge clk)
  begin
    if (!rstn) begin
      state <= 1'b0;
    end else begin
      if (input_axis_tvalid && input_axis_tready && input_axis_tlast) begin
        state <= 1'b0;
      end else if (state == 1'b0 && input_axis_tvalid && input_axis_tready) begin
        state <= 1'b1;
      end
    end
  end

  always @(posedge clk)
  begin
    if (!rstn) begin
      switch <= 1'b0;
      valid <= 1'b0;
    end else begin
      if (state == 1'b0 && input_axis_tvalid && input_axis_tready) begin
        if (start_app && header_src_dst == (header_src_dst_mask & input_axis_tdata[HEADER_LENGTH-1:0])) begin
          switch <= 1'b1;
          if (start_app && header_length_checksum == (header_length_checksum_mask & input_axis_tdata[HEADER_LENGTH-1:0])) begin
            valid <= 1'b1;
          end else begin
            valid <= 1'b0;
          end
        end else begin
          switch <= 1'b0;
        end
      end
    end
  end

endmodule
