//Michael Loh
//Bitcoin Miner Project
//Miner Core Timer

module miner_core_timer
(
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  input wire [6:0]rollover_val,
  output reg [6:0]count,
  output reg rollover_flag
);
reg clear;
assign clear = 0;
flex_counter #(7) FC1(clk, n_rst, clear, enable_timer, rollover_val, count, rollover_flag);

endmodule