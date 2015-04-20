// $Id: $
// File name:   flex_counter.sv
// Created:     2/2/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flex up counter 
module flex_counter
#(
  parameter NUM_CNT_BITS = 4
)
(
  input wire clk,
  input wire n_rst,
  input wire clear,
  input wire count_enable,
  input wire [NUM_CNT_BITS - 1:0] rollover_val,
  output reg [NUM_CNT_BITS - 1:0] count_out,
  output reg rollover_flag
);
  reg [NUM_CNT_BITS - 1:0] nxt_data;
  reg nxt_flag;
  always_ff @ (posedge clk,negedge n_rst) begin
    if(n_rst == 1'b0) 
    begin
      count_out <= 1;
      rollover_flag <= 1'b0;
    end 
    else begin
      count_out <= nxt_data;
      rollover_flag <= nxt_flag; 
    end
  end
  always_comb begin
    nxt_data = count_out;
    if(clear == 1'b1) 
    begin
      nxt_data = 1;
    end 
    else if(count_enable == 1'b1 && count_out == rollover_val) 
    begin
      nxt_data = 1;   
    end 
    else if(count_enable == 1'b1) 
    begin
      nxt_data = count_out + 1;
    end   
  end
  always_comb begin
    if((nxt_data == rollover_val) && (count_enable == 1'b1))
      nxt_flag = 1'b1;
    else
      nxt_flag = 1'b0;
  end
endmodule