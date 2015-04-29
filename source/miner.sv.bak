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
  logic [31:0] nonce;
  logic finished,correct,fin;
  logic [255:0] hashed;
  logic [31:0] correctnonce;
  logic nonce_flag;
  logic count_enable;
  logic hash_enable;
  logic [255:0] correcthash;
  logic [255:0] target;
  assign target = rx_data[255:0];
  logic [607:0] block;
  assign block = rx_data[863:256];
  miner_counter #(1) MC0(clk,n_rst,(send_data || data_ready), count_enable, nonce, nonce_flag); 
  miner_MCU MCU0(send_data,data_ready,finished,clk,n_rst,count_enable,hash_enable);
  miner_core MINC0(clk,n_rst,hash_enable,block,{nonce[7:0],nonce[15:8],nonce[23:16],nonce[31:24]},target,fin,correct,hashed);
  always_comb begin
    if(fin == 1'b1) begin
      finished = 1;
      if(correct == 1'b1) begin
        correcthash = hashed;
        correctnonce = nonce;
      end else begin
        correcthash = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        correctnonce = 0;
      end
    end else begin
      finished = 0;
      correcthash = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
      correctnonce = 0;
    end
  end
  always_comb begin
    if(finished == 1) begin
      if(correcthash != 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) begin
        tx_data = {correcthash,correctnonce};
        send_data = 1;
      end else begin
        tx_data = 0;
        send_data = 0;
      end
    end else begin
      send_data = 0;
      tx_data = 0;
    end
  end
endmodule