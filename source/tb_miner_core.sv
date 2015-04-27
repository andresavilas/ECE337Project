// $Id: $
// File name:   tb_miner_core.sv
// Created:     4/25/2015
// Author:      Michael Loh
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: SHA Core Test Bench
`timescale 1ns / 10ps
localparam CLK_PERIOD = 20;
module tb_miner_core();
  reg clk, n_rst, hash_enable, finished, hashed;
  reg [0:639]message;
  reg [0:255]hash;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	miner_core CORE1 (.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .message(message), .finished(finished), .hash(hash));
	
	initial
	begin 
	 n_rst = 0;
	 message = 640'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a42a14695;
	 //message appended with nonce 42a14695
  	#(2*CLK_PERIOD);
	 @(negedge clk);
	 n_rst = 1;
	 hash_enable = 1;
	 #(CLK_PERIOD);
	 hash_enable = 0;
	 #(500*CLK_PERIOD);
	end
endmodule