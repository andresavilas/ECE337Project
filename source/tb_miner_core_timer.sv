`timescale 1ns / 10ps
localparam CLK_PERIOD = 10;

module tb_miner_core_timer();

  reg [6:0]rollover_val;
  reg clk, n_rst, enable_timer;
  reg [6:0]count;
  always
	begin
	  clk = 1'b0;
		#(CLK_PERIOD/2.0);
		clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	miner_core_timer DUT(.clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), .rollover_val(rollover_val), .count(count), .rollover_flag(rollover_flag));
  initial
  begin 
      n_rst = 1'b1;				// Initialize to be inactive
	    //Power-on Reset of the DUT
	    #(0.1);
	    n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
	    #(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
	    n_rst	= 1'b1; 	// Deactivate the chip reset
	    #(CLK_PERIOD);
	    //Wait for another period
	    #(CLK_PERIOD);
	    @(negedge clk);
	    rollover_val = 48;
	    enable_timer = 1;
	    #(50*CLK_PERIOD);
	end
endmodule
	    
	     