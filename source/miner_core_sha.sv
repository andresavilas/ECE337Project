// $Id: $
// File name:   miner_core_sha.sv
// Created:     4/23/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: SHA Top Level
module miner_core_sha(
  input wire clk,
  input wire n_rst,
  input wire msa_en,
  input wire comp_en,
  input wire add_en,
  input wire [0:511] chunk,
  input wire [0:7] [0:31] fh,
  output logic [0:255] h
);
  logic [0:63] [0:31] w;
  logic [0:7] [0:31] a_h;
  logic [0:255] new_h;
  logic [0:255] hashed;
  always_ff @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      h <= 0;
    end else begin
      h <= new_h;
    end
  end
  miner_core_msa M0 (.msa_en(msa_en),.clk(clk),.n_rst(n_rst),.chunk(chunk),.w(w));
  miner_core_comp C0 (.clk(clk),.n_rst(n_rst),.comp_en(comp_en),.w(w),.first_h(fh),.h(a_h));
  always_comb begin
    hashed = {fh[0] + a_h[0],fh[1] + a_h[1],fh[2] + a_h[2],fh[3] + a_h[3],fh[4] + a_h[4],fh[5] + a_h[5],fh[6] + a_h[6],fh[7] + a_h[7]};
    if(add_en == 1) begin
      new_h = hashed;
    end else begin
      new_h = h;
    end
  end
endmodule