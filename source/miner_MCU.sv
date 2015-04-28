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
  output wire count_enable,
  output wire hash_enable
);

typedef enum bit [2:0] {IDLE, SHA, WAIT, INCREMENTNONCE} stateType;
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
      count_enable = 0;
      hash_enable = 0;
      if (data_ready == 1'b1)
        next_state = SHA;
      else (data_ready == 1'b0)
        next_state = IDLE; 
    end
    SHA:
    begin
      count_enable = 0;
      hash_enable = 1;
      next_state = WAIT;
    end
    WAIT:
    begin 
      count_enable = 0; 
      hash_enable = 0;
      if (data_ready == 1'b1)
        next_state = SHA;
      else if (finished == 1'b0)
        next_state = WAIT;
      else if (finished == 1'b1)
        next_state = INCREMENTNONCE;
    end
    INCREMENTNONCE:
    begin
      count_enable = 1;
      if (s_data == 1'b1)
        next_state = IDLE;
      else
        next_state = SHA;
    end
  endcase
end
endmodule