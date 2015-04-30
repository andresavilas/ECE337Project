`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;
module tb_miner_hashing_function();
  reg clk, n_rst, hash_enable;
  reg [0:607]block;
  reg [0:31]nonce;
  reg [0:255] correct_hash;
  reg [0:255]target;
  reg [0:31] correct_nonce;
  reg finished;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	
	miner_hashing_function MHF1(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .nonce(nonce), .block(block), .target(target), .correct_hash(correct_hash), .correct_nonce(correct_nonce), .finished(finished));
	
	initial
	begin 
	 n_rst = 0;
	 block = 608'h0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a;
	 //nonce = 32'h9546a142;
	 nonce = 32'h9546a141;
	 target = 256'h00000000000444b9f20000000000000000000000000000000000000000000000;
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
  