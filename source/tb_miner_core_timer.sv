`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;

module tb_miner_core_CCU();
  reg [2:0]tb_test_num;
  reg [6:0]rollover_val;
  reg clk, n_rst, hash_enable, rollover_flag, select, enable_timer, msa_en, comp_en, msa2_en, comp2_en, add_en, add2_en, finished;
  
  always
	begin
	  clk = 1'b0;
		#(CLK_PERIOD/2.0);
		clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	miner_core_CCU DUT(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .rollover_flag(rollover_flag), .select(select), .enable_timer(enable_timer), .rollover_val(rollover_val), .msa_en(msa_en), .comp_en(comp_en), .msa2_en(msa2_en), .comp2_en(comp2_en), .add_en(add_en), .add2_en(add2_en), .finished(finished));
	initial
	begin
	   tb_test_num = 0;
	   tb_nrst = 1'b1;				// Initialize to be inactive
	   //Power-on Reset of the DUT
	   #(0.1);
	   tb_nrst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
	   #(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
	   tb_nrst	= 1'b1; 	// Deactivate the chip reset
	   #(CLK_PERIOD);
	   //Wait for another period
	   #(CLK_PERIOD); 
     @(negedge tb_clk);
     tb_test_num = tb_test_num + 1'b1;
	   hash_enable = 0;
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   hash_enable = 1;
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   rollover_flag = 0;
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   rollover_flag = 1;
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   rollover_flag = 0;
	   #(CLK_PERIOD);
	   @(negedge tb_clk):
	   rollover_flag = 1;
	   #(CLK_PERIOD);//DURING ADDING STAGE
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   rollover_flag = 0;
	   #(CLK_PERIOD);
	   @(negedge tb_clk);
	   rollover_flag = 1;