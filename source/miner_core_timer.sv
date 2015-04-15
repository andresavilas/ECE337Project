//Michael Loh
//Bitcoin Miner Project
//Core Control Unit

// $Id: $
// File name:   timer.sv
// Created:     2/26/2015
// Author:      Michael Loh
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Timer module
module miner_core_timer
(
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  input wire rollover_val,
  output reg count,
  output reg rollover_flag
);
reg clear;
assign clear = 0;
flex_counter FC1(clk, n_rst, clear, enable_timer, rollover_val, count, rollover_flag);

endmodule