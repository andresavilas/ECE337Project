// $Id: ${
// File name:   miner.sv}
// File name:   miner.sv
// Created:     4/28/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Miner Top Level
module miner
(
  input wire clk,
  input wire n_rst,
  input wire [863:0] rx_data,
  input wire data_ready,
  output logic send_data,
  output logic [287:0] tx_data
);
  
  logic finished;
  logic next_data;
  logic [287:0] ntx_data;
  logic [607:0] block;
  logic [255:0] correct_hash;
  logic [255:0] target;
  logic [31:0] correct_nonce;
  logic [31:0] nonce;
  logic nonce_flag;
  logic count_enable;
  logic hash_enable;
  assign target = rx_data[255:0];
  assign block = rx_data[863:256]; 
  miner_counter MC0(clk,n_rst,(send_data || data_ready), count_enable, nonce, nonce_flag); 
  miner_MCU MCU0(send_data,data_ready,finished,clk,n_rst,count_enable,hash_enable,nonce_flag);
  miner_hashing_function #(3) MHF1(clk,n_rst,hash_enable,nonce,block,target,correct_hash,correct_nonce,finished);
  always_comb begin
    if(nonce_flag == 1) begin
      ntx_data = {256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,32'h00000000};
      next_data = 1;
    end else if(finished == 1) begin
      if(correct_hash != 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) begin
        ntx_data = {correct_hash,correct_nonce};
        next_data = 1;
      end else begin
        ntx_data = 0;
        next_data = 0;
      end
    end 
    else begin
      next_data = 0;
      ntx_data = 0;
    end
  end
  always_ff @ (posedge clk,negedge n_rst) begin
    if(n_rst == 1'b0) begin
      send_data <= 0;
      tx_data <= 0;
    end else begin
      send_data <= next_data;
      tx_data <= ntx_data;
    end 
  end
endmodule