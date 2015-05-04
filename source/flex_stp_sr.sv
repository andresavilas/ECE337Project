// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/31/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flex scalable sipo
module flex_stp_sr 
#(
  parameter NUM_BITS = 4,
  parameter SHIFT_MSB = 1
)
(
  input wire clk,
  input wire n_rst,
  input wire shift_enable,
  input wire serial_in,
  output reg [NUM_BITS - 1:0] parallel_out
);
always_ff @ (posedge clk,negedge n_rst) begin 
  if(n_rst == 1'b0) begin
    parallel_out[NUM_BITS - 1:0] <= {NUM_BITS{1'b1}};
  end
  else if(shift_enable == 1 && n_rst == 1'b1) begin
    if(SHIFT_MSB == 1) begin
      parallel_out[0] <= serial_in;
      parallel_out[NUM_BITS - 1:1] <= parallel_out[NUM_BITS - 2:0];
    end else if(SHIFT_MSB == 0) begin
      parallel_out[NUM_BITS - 1] <= serial_in;
      parallel_out[NUM_BITS - 2:0] <= parallel_out[NUM_BITS - 1:1];
    end
  end else if(n_rst == 1'b0) begin
    parallel_out[NUM_BITS - 1:0] <= {NUM_BITS{1'b1}};
  end
end
   
endmodule