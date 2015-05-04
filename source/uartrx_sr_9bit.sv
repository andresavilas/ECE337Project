// $Id: $
// File name:   sr_9bit.sv
// Created:     2/17/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: serial register
module uartrx_sr_9bit
(
  input wire clk,
  input wire n_rst,
  input wire shift_strobe,
  input wire serial_in,
  output wire [7:0] packet_data,
  output wire stop_bit
);
  wire [8:0] shiftreg;
  flex_stp_sr #(.NUM_BITS(9), .SHIFT_MSB(0)) I0 (.clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out(shiftreg));
  assign stop_bit = shiftreg[8];
  assign packet_data = shiftreg[7:0]; 
endmodule
