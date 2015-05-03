// $Id: $
// File name:   flex_pts_sr.sv
// Created:     1/31/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: parallel to serial
module flex_pts_sr 
#(
  parameter NUM_BITS = 4,
  parameter SHIFT_MSB = 1
)
(
  input wire clk,
  input wire n_rst,
  input wire shift_enable,
  input wire load_enable,
  input wire [NUM_BITS - 1:0] parallel_in,
  output reg serial_out
);
  reg [NUM_BITS - 1:0] buffer;
always_ff @ (posedge clk,negedge n_rst) begin 
  if(n_rst == 1'b0) begin
    buffer[NUM_BITS - 1:0] <= {NUM_BITS{1'b1}};
  end
  else if(load_enable == 1) begin
    buffer[NUM_BITS - 1:0] <= parallel_in[NUM_BITS - 1:0]; 
  end else if(shift_enable == 1) begin
    if(SHIFT_MSB == 1) begin
      buffer[0] <= 1'b1;
      buffer[NUM_BITS - 1:1] <= buffer[NUM_BITS - 2:0];     
    end else if(SHIFT_MSB == 0) begin
      buffer[NUM_BITS - 1] <= 1'b1;
      buffer[NUM_BITS - 2:0] <= buffer[NUM_BITS - 1:1];   
    end
  end 
end 

    always_comb begin
      if(SHIFT_MSB == 0)
        serial_out = buffer[0];
      else
        serial_out = buffer[NUM_BITS - 1];
    end
        
endmodule