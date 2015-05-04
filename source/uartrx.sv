// $Id: $
// File name:   rcv_block.sv
// Created:     2/17/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: receiver block
module uartrx
(
  input wire clk,
  input wire n_rst,
  input wire serial_in,
  output wire [863:0] rx_data,
  output wire data_ready
);
  wire framing_error;
  wire detect;
  wire pdone;
  wire sclear;
  wire senable;
  wire lbuff;
  wire etimer;
  wire shift;
  wire [6:0] count;
  wire [7:0] p_data;
  wire sbit;
  uartrx_start_bit_det I1(.clk(clk), .n_rst(n_rst), .serial_in(serial_in), .start_bit_detected(detect));
  uartrx_rcu I2(.clk(clk), .n_rst(n_rst), .start_bit_detected(detect), .packet_done(pdone), .framing_error(framing_error), .sbc_clear(sclear), .sbc_enable(senable), .load_buffer(lbuff), .enable_timer(etimer));
  uartrx_timer I3(.clk(clk), .n_rst(n_rst), .enable_timer(etimer), .shift_strobe(shift), .packet_done(pdone));
  uartrx_sr_9bit I4(.clk(clk), .n_rst(n_rst), .shift_strobe(shift), .serial_in(serial_in), .packet_data(p_data), .stop_bit(sbit));
  uartrx_stop_bit_chk I5(.clk(clk), .n_rst(n_rst), .sbc_clear(sclear), .sbc_enable(senable), .stop_bit(sbit), .framing_error(framing_error));
  uartrx_buffer I6(.clk(clk), .n_rst(n_rst), .shift_enable(lbuff), .packet({p_data[0],p_data[1],p_data[2],p_data[3],p_data[4],p_data[5],p_data[6],p_data[7]}), .parallel_out(rx_data));
  flex_counter #(7) I10(.clk(clk), .n_rst(n_rst), .clear(data_ready), .count_enable(lbuff), .rollover_val(7'b1101100), .count_out(count), .rollover_flag(data_ready));
endmodule
