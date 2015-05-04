// $Id: $
// File name:   bitcoinminer.sv
// Created:     5/3/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Bitcoin Miner Top 
module bitcoinminer
#(
  CORES = 1
)
(
  input wire clk,
  input wire n_rst,
  input wire serial_in,
  output wire serial_out
);
  logic [863:0] rx_data;
  logic data_ready;
  logic [287:0] tx_data;
  logic send_data;
  uart_tx TX(.clk(clk),.n_rst(n_rst),.tx_data(tx_data),.send_data(send_data),.serial_out(serial_out));
  uartrx RX(.clk(clk),.n_rst(n_rst),.serial_in(serial_in),.rx_data(rx_data),.data_ready(data_ready));
  miner MIN(.clk(clk),.n_rst(n_rst),.rx_data(rx_data),.data_ready(data_ready), .send_data(send_data), .tx_data(tx_data));
endmodule