// $Id: $
// File name:   rcu.sv
// Created:     2/17/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: receiver control unit
module uartrx_rcu
(
  input wire clk,
  input wire n_rst,
  input wire start_bit_detected,
  input wire packet_done,
  input wire framing_error,
  output reg sbc_clear,
  output reg sbc_enable,
  output reg load_buffer,
  output reg enable_timer
);
  typedef enum bit [3:0] {START,ENABLE,WAIT,BUFF,IDLE} stateType;
  stateType state;
  stateType nxtstate;
  always_ff @ (negedge n_rst, posedge clk) begin
    if(n_rst == 1'b0) begin
      state <= IDLE;
    end else begin
      state <= nxtstate;
    end
  end
  always_comb begin
    nxtstate = state;
    sbc_clear = 1'b0;
    sbc_enable = 1'b0;
    load_buffer = 1'b0;
    enable_timer = 1'b0;
    case(state)
          IDLE:
          begin
            if(start_bit_detected == 1'b1) begin
              nxtstate = START;
            end
          end
          START: 
          begin
            enable_timer = 1'b1;
            sbc_clear = 1'b1;
            if(packet_done == 1'b1) begin
              nxtstate = ENABLE;
            end
          end
          ENABLE:
          begin
            sbc_enable = 1'b1;
            nxtstate = WAIT;
          end
          WAIT:
          begin
            sbc_enable = 1'b1;
            if(framing_error == 1'b0) begin
              nxtstate = BUFF;
            end else begin
              nxtstate = IDLE;
            end
          end
          BUFF:
          begin
            load_buffer = 1'b1;
            nxtstate = IDLE;
          end
    endcase
  end
endmodule
