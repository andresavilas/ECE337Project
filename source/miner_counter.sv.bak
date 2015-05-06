// $Id: $
// File name:   miner_counter.sv
// Created:     4/28/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Counter
module miner_counter
(
  input wire clk,
  input wire n_rst,
  input wire clear,
  input wire count_enable,
  output reg [31:0]nonce,
  output reg nonce_flag
);
miner_NonceCounter #(1,32) MNC1(clk, n_rst, clear, count_enable, 32'hFFFFFFFF - CORES + 1, nonce, nonce_flag);

endmodule