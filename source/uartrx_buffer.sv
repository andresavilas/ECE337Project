// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/31/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flex scalable sipo
module uartrx_buffer 
#(
  parameter NUM_BITS = 864
)
(
  input wire clk,
  input wire n_rst,
  input wire shift_enable,
  input wire [7:0] packet,
  output reg [NUM_BITS - 1:0] parallel_out
);
always_ff @ (posedge clk,negedge n_rst) begin 
  if(n_rst == 1'b0) begin
    parallel_out[NUM_BITS - 1:0] <= {NUM_BITS{1'b1}};
  end
  else if(shift_enable == 1) begin
    parallel_out[7:0] <= packet;
    parallel_out[NUM_BITS - 1:8] <= parallel_out[NUM_BITS - 9:0];
  end
end
   
endmodule