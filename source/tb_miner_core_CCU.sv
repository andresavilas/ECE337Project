`timescale 1ns / 10ps
localparam CLK_PERIOD = 20;

module tb_miner_core_CCU();
  reg [3:0]tb_test_num;
  reg [6:0]rollover_val;
  reg [6:0]count;
  reg clk, n_rst, hash_enable, rollover_flag, select, enable_timer, msa_en, comp_en, msa2_en, comp2_en, add_en, add2_en, finished;
  reg [0:511] chunk;
  reg [0:63] [0:31] w;
  always
	begin
	  clk = 1'b0;
		#(CLK_PERIOD/2.0);
		clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	miner_core_CCU DUT(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .rollover_flag(rollover_flag), .select(select), .enable_timer(enable_timer), .rollover_val(rollover_val), .msa_en(msa_en), .comp_en(comp_en), .msa2_en(msa2_en), .comp2_en(comp2_en), .add_en(add_en), .add2_en(add2_en), .finished(finished));
	miner_core_timer DUT2(.clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), .rollover_val(rollover_val), .count(count), .rollover_flag(rollover_flag));
	miner_core_msa DUT3(.i(count+15), .msa_en(msa_en), .clk(clk), .n_rst(n_rst), .chunk(chunk), .w(w));
	initial
	begin
	   tb_test_num = 0;
	   n_rst = 1'b1;				// Initialize to be inactive
	   //Power-on Reset of the DUT
	   #(0.1);
	   n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
	   hash_enable = 1'b0;
	   #(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
	   n_rst	= 1'b1; 	// Deactivate the chip reset
	   chunk = 1238290;
	   #(CLK_PERIOD);
	   //Wait for another period
	   #(CLK_PERIOD); 
     @(negedge clk);
     hash_enable = 1;
     #(CLK_PERIOD);
     @(negedge clk);
     hash_enable = 0;
     tb_test_num = tb_test_num + 1'b1;
     #(48*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(64*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(CLK_PERIOD); //ADDING stage
     tb_test_num = tb_test_num + 1'b1;
     #(48*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(64*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(CLK_PERIOD); //ADDING stage
     tb_test_num = tb_test_num + 1'b1;
     #(48*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(64*CLK_PERIOD);
     tb_test_num = tb_test_num + 1'b1;
     #(3*CLK_PERIOD);
     
  end
endmodule