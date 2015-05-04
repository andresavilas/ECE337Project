// $Id: $
// File name:   timer.sv
// Created:     2/17/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: timer
module uartrx_timer
(
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  output reg shift_strobe,
  output reg packet_done
);
  wire [3:0] cnt;
  wire [3:0] cnt2;
  flex_counter I7(.clk(clk), .n_rst(n_rst), .clear(packet_done), .count_enable(enable_timer), .rollover_val(4'b1010), .count_out(cnt), .rollover_flag(shift_strobe));
  flex_counter I8(.clk(clk), .n_rst(n_rst), .clear(packet_done), .count_enable(shift_strobe), .rollover_val(4'b1001), .count_out(cnt2), .rollover_flag(packet_done));
endmodule
