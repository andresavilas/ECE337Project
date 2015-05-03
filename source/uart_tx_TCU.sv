// $Id: $
// File name:   uart_tx_TCU.sv
// Created:     5/2/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Transmitter Control Unit
module uart_tx_TCU(
  input wire clk,
  input wire n_rst,
  input wire send_data,
  input wire done,
  output reg tim_en,
  output reg load_en 
);
  typedef enum bit {IDLE,WAIT} stateType;
  stateType state;
  stateType next_state;
  
  always_ff @ (posedge clk,negedge n_rst) begin
    if(n_rst == 0) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  always_comb begin
    next_state = state;
    tim_en = 0;
    load_en = 0;
    case (state) 
      IDLE:
      begin
        if(send_data == 1'b1) begin
          load_en = 1;
          next_state = WAIT;
        end
      end
      WAIT:
      begin
        tim_en = 1;
        if(done == 1'b1 || send_data == 1'b1) begin
          next_state = IDLE;
        end
      end
    endcase
  end
endmodule