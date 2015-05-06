// $Id: $
// File name:   tb_bitcoinminer.sv
// Created:     5/3/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Bitcoin Miner Test Bench
`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;
module tb_bitcoinminer();
  logic serial_in,clk,n_rst,serial_out;
  logic [287:0] tx_data;
  logic send_data;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	bitcoinminer DUT(.clk(clk),.n_rst(n_rst),.serial_in(serial_in),.serial_out(serial_out));
	uart_tx2 DUT2(.clk(clk),.n_rst(n_rst),.tx_data(tx_data),.send_data(send_data),.serial_out(serial_in));
	initial
	begin
	  tx_data = 288'h01000000b7bd9f286a77d60ac34fad57c74dd681ffb340b1095200426d0577e600000000;
	  n_rst = 0;
    send_data = 0;
    #(CLK_PERIOD);
    @(negedge clk);
    n_rst = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 0;
    #(CLK_PERIOD*4000);
    @(negedge clk);
    tx_data = 288'h49df9f01194792e1804e31480bb36bfa5c670796d3a78f1a373110636933a57a106a7449;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 0;
    #(CLK_PERIOD*4000);
    @(negedge clk);
    tx_data = 288'hffff001d00000000FFFF0000000000000000000000000000000000000000000000000000;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 1;
    #(CLK_PERIOD);
    @(negedge clk);
    send_data = 0;
	end
endmodule