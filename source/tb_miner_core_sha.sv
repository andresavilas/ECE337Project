// $Id: $
// File name:   tb_miner_core_sha.sv
// Created:     4/23/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: SHA Test Bench
`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;
module tb_miner_core_sha();
  logic clk;
  logic n_rst;
  logic msa_en;
  logic add_en;
  logic comp_en;
  logic [0:511] chunk;
  integer ct;
  logic [0:7] [0:31] fh = {32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};
  logic [0:255] h;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
  miner_core_sha DUT (.clk(clk),.n_rst(n_rst),.msa_en(msa_en),.add_en(add_en),.comp_en(comp_en),.chunk(chunk),.fh(fh),.h(h));
  initial
	begin
	  n_rst = 1'b0;
	  chunk = 512'h68656c6c6f8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000028;
	  msa_en = 1'b0;
	  add_en = 1'b0;
	  comp_en = 1'b0;
	  #(2*CLK_PERIOD);
	  @(negedge clk);
	  n_rst = 1'b1;
	  #(CLK_PERIOD);
	  msa_en = 1'b1;
	  #(CLK_PERIOD);
	  @(negedge clk);
	  msa_en = 1'b0;
	  for(ct = 16; ct < 64; ct = ct + 1) begin
	   #(CLK_PERIOD);
	  end
	  #(CLK_PERIOD);
	  @(negedge clk);
	  comp_en = 1'b1;
	  #(CLK_PERIOD);
	  @(negedge clk);
	  comp_en = 1'b0;
	  for(ct = 0; ct < 64; ct = ct + 1) begin
	    #(CLK_PERIOD);
	  end
	  add_en = 1'b1;
  end
endmodule