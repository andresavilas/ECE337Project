// $Id: $
// File name:   tb_uart_tx.sv
// Created:     5/2/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for UART Transmitter
`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;
module tb_uart_tx();
  logic clk,n_rst,send_data,serial_out;
  logic [287:0] tx_data;
  always begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
  end
  uart_tx DUT(.clk(clk),.n_rst(n_rst),.send_data(send_data),.serial_out(serial_out),.tx_data(tx_data));
  initial 
  begin
    n_rst = 0;
    send_data = 0;
    tx_data = 288'hda830f8941824ae65eb8cdacf37df88057c533f7e2168aceeae314b8a3d783d800000000;
    #(CLK_PERIOD);
    @(negedge clk);
    n_rst = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 0;
  end
endmodule