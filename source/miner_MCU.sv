// $Id: $
// File name:   miner_MCU.sv
// Created:     4/28/2015
// Author:      Michael Loh
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Miner MCU
module miner_MCU
(
  input wire send_data,
  input wire data_ready,
  input wire finished,
  input wire clk,
  input wire n_rst,
  output logic count_enable,
  output logic hash_enable,
  input wire nonce_flag
);

typedef enum bit [2:0] {IDLE, SHA, WAIT, OUT, INCREMENTNONCE} stateType;
stateType state;
stateType next_state;

always_ff @ (posedge clk, negedge n_rst)
begin
  if(n_rst == 1'b0)
  begin
    state <= IDLE;
  end
  else
  begin
    state <= next_state;
  end
end

always_comb
begin
  count_enable = 0;
  hash_enable = 0;
  next_state = state;
  case(state)
    IDLE:
    begin
      if (data_ready == 1'b1)
        next_state = SHA;
      else 
        next_state = IDLE; 
    end
    SHA:
    begin
      if(nonce_flag == 1'b1) begin
        next_state = IDLE;
      end else begin
        hash_enable = 1;
        next_state = WAIT;
      end
    end
    WAIT:
    begin 
      if (data_ready == 1'b1)
        next_state = SHA;
      else if (finished == 1'b0)
        next_state = WAIT;
      else if (finished == 1'b1)
        if(send_data == 1'b1) begin
          next_state = IDLE;
        end else begin
          next_state = OUT;
        end
    end
    OUT:
    begin
      if(data_ready == 1'b1) begin
        next_state = SHA;
      end else if(send_data == 1'b1) begin
        next_state = IDLE;
      end else begin
        next_state = INCREMENTNONCE;
      end
    end
    INCREMENTNONCE:
    begin
      if(data_ready == 1'b0) begin
        count_enable = 1'b1;
      end
      next_state = SHA;
    end
  endcase
end
endmodule