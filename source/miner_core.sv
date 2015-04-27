// $Id: $
// File name:   miner_core.sv
// Created:     4/24/2015
// Author:      Michael Loh
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Miner Core Top Level
module miner_core(
  input wire clk, n_rst, hash_enable,
  input wire [0:639] message,
  output wire finished,
  //output wire correct,
  output wire [0:255] hash
);
reg msa_en, comp_en, add_en, msa2_en, comp2_en, add2_en, rollover_flag, select, enable_timer;
reg [6:0]count;
reg [6:0]rollover_val;
reg [0:511]chunk1;
reg [0:511]chunk2;//Second round of SHA
reg [0:7] [0:31]fh;
reg [0:255]h;
reg [0:255]temphash;
assign fh = (select == 1) ? h : {32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};
assign chunk1 = (select == 1) ? {message[512:639], 1'b1, 319'b0, 64'b0000000000000000000000000000000000000000000000000000001010000000} : message[0:511];
assign chunk2 = {h,1'b1,191'b0,64'b0000000000000000000000000000000000000000000000000000000100000000};
genvar i;
generate 
  for(i=0; i < 249; i=i+8)
  begin
    assign hash[i:i+7] = temphash[248-i:255-i];
  end
endgenerate
miner_core_CCU CCU1(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .rollover_flag(rollover_flag), .select(select), .enable_timer(enable_timer), .rollover_val(rollover_val), .msa_en(msa_en), .comp_en(comp_en), .msa2_en(msa2_en), .comp2_en(comp2_en), .add_en(add_en), .add2_en(add2_en), .finished(finished));
miner_core_timer TIM1(.clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), .rollover_val(rollover_val), .count(count), .rollover_flag(rollover_flag));
miner_core_sha SHA1(.clk(clk), .n_rst(n_rst), .msa_en(msa_en), .comp_en(comp_en), .add_en(add_en), .chunk(chunk1), .fh(fh), .h(h));
miner_core_sha SHA2(.clk(clk), .n_rst(n_rst), .msa_en(msa2_en), .comp_en(comp2_en), .add_en(add2_en), .chunk(chunk2), .fh(fh), .h(temphash));
endmodule