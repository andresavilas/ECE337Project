// $Id: $
// File name:   tb_miner_core_comp.sv
// Created:     4/22/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench For Compression Function
`timescale 1ns / 10ps
localparam CLK_PERIOD = 20;
module tb_miner_core_comp();
  integer ct;
  reg tb_en;
  reg clk;
  reg n_rst;
  reg [0:63] [0:31] tb_w;
  reg [0:7] [0:31] tb_fh = {32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};
  reg [0:7] [0:31] tb_h;
  reg [0:7] [0:31] finh;
  reg [0:255] hashed;
  reg tb_men;
  reg [0:511] tb_chunk;
  always
	 begin
	 clk = 1'b0;
	 #(CLK_PERIOD/2.0);
	 clk = 1'b1;
	 #(CLK_PERIOD/2.0);	  
	end
	miner_core_comp DUT(.clk(clk), .n_rst(n_rst), .comp_en(tb_en), .w(tb_w), .first_h(tb_fh), .h(tb_h));
	miner_core_msa DUT2(.clk(clk), .n_rst(n_rst),.msa_en(tb_men), .chunk(tb_chunk), .w(tb_w));
	initial
	begin
	  n_rst = 1'b0;
	  tb_chunk = 40'h68656c6c6f;
	  tb_en = 1'b0;
	  #(2*CLK_PERIOD);
	  @(negedge clk);
	  n_rst = 1'b1;
	  #(3*CLK_PERIOD);
	  tb_men = 1'b1;
	  #(CLK_PERIOD);
	  tb_men = 1'b0; 
	  for(ct = 16; ct < 64; ct = ct + 1) begin
	   @(negedge clk);
	   #(CLK_PERIOD);
	  end
	  #(CLK_PERIOD);
	  tb_en = 1'b1;
	  #(CLK_PERIOD);
	  tb_en = 1'b0;
	  for(ct = 0; ct < 64;ct = ct + 1) begin
	   @(negedge clk);
	   #(CLK_PERIOD);
	   $display("%0d:%0d",ct,tb_h[0]);
	  end
	  finh[0] = tb_h[0] + tb_fh[0];
	  finh[1] = tb_h[1] + tb_fh[1];
	  finh[2] = tb_h[2] + tb_fh[2];
	  finh[3] = tb_h[3] + tb_fh[3];
	  finh[4] = tb_h[4] + tb_fh[4];
	  finh[5] = tb_h[5] + tb_fh[5];
	  finh[6] = tb_h[6] + tb_fh[6];
	  finh[7] = tb_h[7] + tb_fh[7];
	  hashed = {finh[0],finh[1],finh[2],finh[3],finh[4],finh[5],finh[6],finh[7]};
	end
endmodule