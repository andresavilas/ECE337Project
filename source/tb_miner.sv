// $Id: $
// File name:   tb_miner.sv
// Created:     4/28/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Miner Top Level
`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;
module tb_miner();
  reg clk,n_rst,data_ready,send_data;
  reg [863:0] rx_data;
  reg [287:0] tx_data;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	miner DUT(.clk(clk),.n_rst(n_rst),.rx_data(rx_data),.send_data(send_data),.data_ready(data_ready),.tx_data(tx_data));
	initial
	begin
	  n_rst = 0;
	  data_ready = 0;
	  rx_data = {608'h01000000b7bd9f286a77d60ac34fad57c74dd681ffb340b1095200426d0577e60000000049df9f01194792e1804e31480bb36bfa5c670796d3a78f1a373110636933a57a106a7449ffff001d,256'h00000000FFFF0000000000000000000000000000000000000000000000000000};
	  #(CLK_PERIOD);
	  @(negedge clk);
	  n_rst = 1;
	  #(CLK_PERIOD);
	  data_ready = 1;
	  #(CLK_PERIOD);
	  data_ready = 0;
	  @(posedge send_data);
	  $display("%h",tx_data);
	  rx_data = {608'h0145678981cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a,256'hF000000000000000000000000000000000000000000000000000000000000000};
    #(CLK_PERIOD);
    //no need for n_rst
	  #(CLK_PERIOD);
	  data_ready = 1;
	  #(CLK_PERIOD);
	  data_ready = 0;
	  @(posedge send_data);
	  $display("%h",tx_data);
	end
endmodule