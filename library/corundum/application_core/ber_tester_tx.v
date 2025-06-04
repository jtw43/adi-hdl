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

// Uses Ficonacci style LFSR

`timescale 1ns/100ps

module ber_tester_tx #(

  // Structural configuration
  parameter IF_COUNT = 1,
  parameter PORTS_PER_IF = 1,

  // Ethernet interface configuration (direct, async)
  parameter AXIS_DATA_WIDTH = 512,
  parameter AXIS_KEEP_WIDTH = AXIS_DATA_WIDTH/8,
  parameter AXIS_TX_USER_WIDTH = 17
) (

  input  wire                                                      ber_test,
  input  wire                                                      insert_bit_error,

  // Ethernet (direct MAC interface - lowest latency raw traffic)
  input  wire [IF_COUNT*PORTS_PER_IF-1:0]                          direct_tx_clk,
  input  wire [IF_COUNT*PORTS_PER_IF-1:0]                          direct_tx_rst,

  input  wire [IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH-1:0]          s_axis_direct_tx_tdata,
  input  wire [IF_COUNT*PORTS_PER_IF*AXIS_KEEP_WIDTH-1:0]          s_axis_direct_tx_tkeep,
  input  wire [IF_COUNT*PORTS_PER_IF-1:0]                          s_axis_direct_tx_tvalid,
  output reg  [IF_COUNT*PORTS_PER_IF-1:0]                          s_axis_direct_tx_tready,
  input  wire [IF_COUNT*PORTS_PER_IF-1:0]                          s_axis_direct_tx_tlast,
  input  wire [IF_COUNT*PORTS_PER_IF*AXIS_TX_USER_WIDTH-1:0]       s_axis_direct_tx_tuser,

  output reg  [IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH-1:0]          m_axis_direct_tx_tdata,
  output reg  [IF_COUNT*PORTS_PER_IF*AXIS_KEEP_WIDTH-1:0]          m_axis_direct_tx_tkeep,
  output reg  [IF_COUNT*PORTS_PER_IF-1:0]                          m_axis_direct_tx_tvalid,
  input  wire [IF_COUNT*PORTS_PER_IF-1:0]                          m_axis_direct_tx_tready,
  output reg  [IF_COUNT*PORTS_PER_IF-1:0]                          m_axis_direct_tx_tlast,
  output reg  [IF_COUNT*PORTS_PER_IF*AXIS_TX_USER_WIDTH-1:0]       m_axis_direct_tx_tuser
);

  wire direct_tx_rstn;

  assign direct_tx_rstn = ~direct_tx_rst;

  // ber_test CDC
  wire ber_test_cdc;

  sync_bits #(
    .NUM_OF_BITS(1)
  ) sync_bits_ber_test (
    .in_bits(ber_test),
    .out_resetn(direct_tx_rstn),
    .out_clk(direct_tx_clk),
    .out_bits(ber_test_cdc)
  );

  // PRBS instances
  reg prbs_ready;

  localparam PRBS_DATA_WIDTH = 64;
  localparam PRBS_POLYNOMIAL_WIDTH = 48;
  localparam PRBS_INST = IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH/PRBS_DATA_WIDTH;

  wire [IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH-1:0] prbs_data;
  wire [PRBS_INST-1:0]                             prbs_valid;

  genvar i;

  generate

    for (i = 0; i < PRBS_INST; i = i + 1) begin

      prbs_gen #(
        .DATA_WIDTH(PRBS_DATA_WIDTH),
        .POLYNOMIAL_WIDTH(PRBS_POLYNOMIAL_WIDTH)
      ) prbs_gen_inst (
        .clk(direct_tx_clk),
        .rstn(direct_tx_rstn),
        .init(~ber_test_cdc),
        .input_ready(prbs_ready),
        .output_data(prbs_data[i*PRBS_DATA_WIDTH +: PRBS_DATA_WIDTH]),
        .output_valid(prbs_valid[i]),
        .polynomial(48'hC00000000000),
        .inverted(1'b0),
        .initial_value(64'h36A59A15F76E2D29)
      );

    end

  endgenerate

  reg insert_bit_error_old;
  reg insert_bit_error_valid;

  always @(posedge direct_tx_clk)
  begin
    if (!direct_tx_rstn) begin
      insert_bit_error_old <= 1'b0;
      insert_bit_error_valid <= 1'b0;
    end else begin
      insert_bit_error_old <= insert_bit_error;
      if (!insert_bit_error_old && insert_bit_error) begin
        insert_bit_error_valid <= 1'b1;
      end else begin
        if (prbs_ready && prbs_valid[0]) begin
          insert_bit_error_valid <= 1'b0;
        end
      end
    end
  end

  // insertion place randomization
  wire [$clog2(IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH)-1:0] insertion_place;

  wire [IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH-1:0] prbs_data_post;

  prbs_gen #(
    .DATA_WIDTH($clog2(IF_COUNT*PORTS_PER_IF*AXIS_DATA_WIDTH)),
    .POLYNOMIAL_WIDTH(15)
  ) insertion_place_prbs_inst (
    .clk(direct_tx_clk),
    .rstn(direct_tx_rstn),
    .init(~ber_test_cdc),
    .input_ready(insert_bit_error_valid),
    .output_data(insertion_place),
    .output_valid(),
    .polynomial(15'h6000),
    .inverted(1'b0),
    .initial_value(15'h657A)
  );

  assign prbs_data_post = (insert_bit_error_valid) ? prbs_data^(1'b1 << insertion_place) : prbs_data;

  // Datapath switch
  reg datapath_switch; // 0 - OS
                       // 1 - BER

  always @(posedge direct_tx_clk)
  begin
    if (direct_tx_rst) begin
      datapath_switch <= 1'b0;
    end else begin
      if (ber_test_cdc && (!s_axis_direct_tx_tvalid || (s_axis_direct_tx_tvalid && s_axis_direct_tx_tready && s_axis_direct_tx_tlast))) begin
        datapath_switch <= 1'b1;
      end else if (!ber_test_cdc) begin
        datapath_switch <= 1'b0;
      end
    end
  end

  always @(*)
  begin
    if (!datapath_switch) begin
      m_axis_direct_tx_tdata = s_axis_direct_tx_tdata;
      m_axis_direct_tx_tkeep = s_axis_direct_tx_tkeep;
      m_axis_direct_tx_tvalid = s_axis_direct_tx_tvalid;
      m_axis_direct_tx_tlast = s_axis_direct_tx_tlast;
      m_axis_direct_tx_tuser = s_axis_direct_tx_tuser;

      s_axis_direct_tx_tready = m_axis_direct_tx_tready;

      prbs_ready = 1'b0;
    end else begin
      m_axis_direct_tx_tdata = prbs_data_post;
      m_axis_direct_tx_tkeep = {IF_COUNT*PORTS_PER_IF*AXIS_KEEP_WIDTH{1'b1}};
      m_axis_direct_tx_tvalid = prbs_valid[0];
      m_axis_direct_tx_tlast = 1'b1;
      m_axis_direct_tx_tuser = {IF_COUNT*PORTS_PER_IF*AXIS_TX_USER_WIDTH{1'b0}};

      s_axis_direct_tx_tready = 1'b0;

      prbs_ready = m_axis_direct_tx_tready;
    end
  end

endmodule
