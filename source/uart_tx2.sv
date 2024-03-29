// $Id: $
// File name:   uart_tx.sv
// Created:     5/2/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: UART Transmitter
module uart_tx2 
(
  input wire clk,
  input wire n_rst,
  input wire [287:0] tx_data,
  input wire send_data,
  output wire serial_out
);
  logic [359:0] buffer;
  logic done;
  logic tim_en;
  logic load_en;
  logic shift_enable;
  logic [8:0] count;
  logic [3:0] count2;
  genvar i;
  generate 
    for(i = 0;i < 36;i = i + 1) begin
      assign buffer[((35-i)*10)+9] = 1'b0;
      assign buffer[((35-i)*10)+8:((35-i)*10)+1] = tx_data[((35-i)*8)+7:((35-i)*8)];
      assign buffer[((35-i)*10)] = 1'b1;
    end
  endgenerate
  uart_tx_TCU UTT2(.clk(clk),.n_rst(n_rst),.send_data(send_data),.done(done),.tim_en(tim_en),.load_en(load_en));
  flex_pts_sr #(360,1) FPS2(.clk(clk),.n_rst(n_rst),.shift_enable(shift_enable),.load_enable(load_en),.parallel_in(buffer),.serial_out(serial_out));
  flex_counter #(9) FC5(.clk(clk),.n_rst(n_rst),.clear(send_data),.count_enable(shift_enable),.rollover_val(9'b101101000),.count_out(count),.rollover_flag(done));
  flex_counter #(4) FC4(.clk(clk),.n_rst(n_rst),.clear(send_data),.count_enable(tim_en),.rollover_val(4'b1010),.count_out(count2),.rollover_flag(shift_enable));
endmodule