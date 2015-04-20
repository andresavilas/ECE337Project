// $Id: $
// File name:   tb_miner_core_sma.sv
// Created:     4/16/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for MSA Function 
`timescale 1ns / 10ps
localparam CLK_PERIOD = 20;
module tb_miner_core_msa();
  reg clk;
  reg n_rst;
  reg [0:6] tb_i;
  reg tb_en;
  reg [0:511] tb_chunk;
  reg [0:63] [0:31] tb_w;
  integer ct;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	miner_core_msa DUT(.clk(clk), .n_rst(n_rst), .i(tb_i), .msa_en(tb_en), .chunk(tb_chunk), .w(tb_w));
	initial 
	begin
	  n_rst = 1'b0;
	  tb_chunk = 1238290;
	  tb_en = 1'b0;
	  #(2*CLK_PERIOD);
	  @(negedge clk);
	  n_rst = 1'b1;
	  tb_i = 15;	
	  #(3*CLK_PERIOD);
	  tb_en = 1'b1;
	  #(CLK_PERIOD);
	  for(ct = 16; ct < 64; ct = ct + 1) begin
	   @(negedge clk);
	   tb_i = ct;
	   #(CLK_PERIOD);
	   $display("%0d:%0d",ct,tb_w[ct]);
	  end
  end 
endmodule