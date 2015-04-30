// $Id: $
// File name:   miner_core_comp.sv
// Created:     4/20/2015
// Author:      Andres Avila
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Compression Function
module miner_core_comp (
  input wire comp_en,
  input wire clk,
  input wire n_rst,
  input wire [0:63] [0:31] w,
  input wire [0:7] [0:31] first_h,
  output logic [0:7] [0:31] h
);
  reg [0:6] state;
  reg [0:6] next_state;
  reg [0:31] S1;
  reg [0:31] S0;
  reg [0:31] temp1;
  reg [0:31] temp2;
  reg [0:31] maj;
  reg [0:31] ch;
  reg [0:31] new_w;
  reg [0:31] new_k;
  logic [0:7] [0:31] new_h;
  wire [0:63] [0:31] k = {32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5, 32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5, 32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3, 32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
   32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc, 32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
   32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7, 32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
   32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13, 32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
   32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3, 32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
   32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5, 32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
   32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208, 32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2};
  always_ff @ (posedge clk, negedge n_rst) begin
    if(n_rst == 0) begin
      h <= 0;
      state <= 0;
    end else begin
      h <= new_h;
      state <= next_state;
    end
  end
  always_comb begin
    next_state = state;
    new_k = k[0];
    new_h = h;
    new_w = w[0];
    case (state)
      0: begin
        if(comp_en == 1) begin
          next_state = 1;
        end
      end
        1: begin
    next_state = 2;
    new_k = k[1];
    new_w = w[1];
  end
  2: begin
    next_state = 3;
    new_k = k[2];
    new_w = w[2];
  end
  3: begin
    next_state = 4;
    new_k = k[3];
    new_w = w[3];
  end
  4: begin
    next_state = 5;
    new_k = k[4];
    new_w = w[4];
  end
  5: begin
    next_state = 6;
    new_k = k[5];
    new_w = w[5];
  end
  6: begin
    next_state = 7;
    new_k = k[6];
    new_w = w[6];
  end
  7: begin
    next_state = 8;
    new_k = k[7];
    new_w = w[7];
  end
  8: begin
    next_state = 9;
    new_k = k[8];
    new_w = w[8];
  end
  9: begin
    next_state = 10;
    new_k = k[9];
    new_w = w[9];
  end
  10: begin
    next_state = 11;
    new_k = k[10];
    new_w = w[10];
  end
  11: begin
    next_state = 12;
    new_k = k[11];
    new_w = w[11];
  end
  12: begin
    next_state = 13;
    new_k = k[12];
    new_w = w[12];
  end
  13: begin
    next_state = 14;
    new_k = k[13];
    new_w = w[13];
  end
  14: begin
    next_state = 15;
    new_k = k[14];
    new_w = w[14];
  end
  15: begin
    next_state = 16;
    new_k = k[15];
    new_w = w[15];
  end
  16: begin
    next_state = 17;
    new_k = k[16];
    new_w = w[16];
  end
  17: begin
    next_state = 18;
    new_k = k[17];
    new_w = w[17];
  end
  18: begin
    next_state = 19;
    new_k = k[18];
    new_w = w[18];
  end
  19: begin
    next_state = 20;
    new_k = k[19];
    new_w = w[19];
  end
  20: begin
    next_state = 21;
    new_k = k[20];
    new_w = w[20];
  end
  21: begin
    next_state = 22;
    new_k = k[21];
    new_w = w[21];
  end
  22: begin
    next_state = 23;
    new_k = k[22];
    new_w = w[22];
  end
  23: begin
    next_state = 24;
    new_k = k[23];
    new_w = w[23];
  end
  24: begin
    next_state = 25;
    new_k = k[24];
    new_w = w[24];
  end
  25: begin
    next_state = 26;
    new_k = k[25];
    new_w = w[25];
  end
  26: begin
    next_state = 27;
    new_k = k[26];
    new_w = w[26];
  end
  27: begin
    next_state = 28;
    new_k = k[27];
    new_w = w[27];
  end
  28: begin
    next_state = 29;
    new_k = k[28];
    new_w = w[28];
  end
  29: begin
    next_state = 30;
    new_k = k[29];
    new_w = w[29];
  end
  30: begin
    next_state = 31;
    new_k = k[30];
    new_w = w[30];
  end
  31: begin
    next_state = 32;
    new_k = k[31];
    new_w = w[31];
  end
  32: begin
    next_state = 33;
    new_k = k[32];
    new_w = w[32];
  end
  33: begin
    next_state = 34;
    new_k = k[33];
    new_w = w[33];
  end
  34: begin
    next_state = 35;
    new_k = k[34];
    new_w = w[34];
  end
  35: begin
    next_state = 36;
    new_k = k[35];
    new_w = w[35];
  end
  36: begin
    next_state = 37;
    new_k = k[36];
    new_w = w[36];
  end
  37: begin
    next_state = 38;
    new_k = k[37];
    new_w = w[37];
  end
  38: begin
    next_state = 39;
    new_k = k[38];
    new_w = w[38];
  end
  39: begin
    next_state = 40;
    new_k = k[39];
    new_w = w[39];
  end
  40: begin
    next_state = 41;
    new_k = k[40];
    new_w = w[40];
  end
  41: begin
    next_state = 42;
    new_k = k[41];
    new_w = w[41];
  end
  42: begin
    next_state = 43;
    new_k = k[42];
    new_w = w[42];
  end
  43: begin
    next_state = 44;
    new_k = k[43];
    new_w = w[43];
  end
  44: begin
    next_state = 45;
    new_k = k[44];
    new_w = w[44];
  end
  45: begin
    next_state = 46;
    new_k = k[45];
    new_w = w[45];
  end
  46: begin
    next_state = 47;
    new_k = k[46];
    new_w = w[46];
  end
  47: begin
    next_state = 48;
    new_k = k[47];
    new_w = w[47];
  end
  48: begin
    next_state = 49;
    new_k = k[48];
    new_w = w[48];
  end
  49: begin
    next_state = 50;
    new_k = k[49];
    new_w = w[49];
  end
  50: begin
    next_state = 51;
    new_k = k[50];
    new_w = w[50];
  end
  51: begin
    next_state = 52;
    new_k = k[51];
    new_w = w[51];
  end
  52: begin
    next_state = 53;
    new_k = k[52];
    new_w = w[52];
  end
  53: begin
    next_state = 54;
    new_k = k[53];
    new_w = w[53];
  end
  54: begin
    next_state = 55;
    new_k = k[54];
    new_w = w[54];
  end
  55: begin
    next_state = 56;
    new_k = k[55];
    new_w = w[55];
  end
  56: begin
    next_state = 57;
    new_k = k[56];
    new_w = w[56];
  end
  57: begin
    next_state = 58;
    new_k = k[57];
    new_w = w[57];
  end
  58: begin
    next_state = 59;
    new_k = k[58];
    new_w = w[58];
  end
  59: begin
    next_state = 60;
    new_k = k[59];
    new_w = w[59];
  end
  60: begin
    next_state = 61;
    new_k = k[60];
    new_w = w[60];
  end
  61: begin
    next_state = 62;
    new_k = k[61];
    new_w = w[61];
  end
  62: begin
    next_state = 63;
    new_k = k[62];
    new_w = w[62];
  end
  63: begin
    next_state = 0;
    new_k = k[63];
    new_w = w[63];
  end
endcase
      if(comp_en == 1) begin
          next_state = 1;
          S1 = {first_h[4][26:31],first_h[4][0:25]} ^ {first_h[4][21:31],first_h[4][0:20]} ^ {first_h[4][7:31],first_h[4][0:6]};
          ch = (first_h[4] & first_h[5]) ^ ((~first_h[4]) & first_h[6]);
          temp1 = first_h[7] + S1 + ch + k[0] + w[0];
          S0 = {first_h[0][30:31],first_h[0][0:29]} ^ {first_h[0][19:31],first_h[0][0:18]} ^ {first_h[0][10:31],first_h[0][0:9]}; 
          maj = (first_h[0] & first_h[1]) ^ (first_h[0] & first_h[2]) ^ {first_h[1] & first_h[2]};
          temp2 = S0 + maj;
          new_h[0] = temp1 + temp2;
          new_h[1] = first_h[0];
          new_h[2] = first_h[1];
          new_h[3] = first_h[2];
          new_h[4] = first_h[3] + temp1;
          new_h[5] = first_h[4];
          new_h[6] = first_h[5];
          new_h[7] = first_h[6];  
      end else if(state != 0) begin
    S1 = {h[4][26:31],h[4][0:25]} ^ {h[4][21:31],h[4][0:20]} ^ {h[4][7:31],h[4][0:6]};
    ch = (h[4] & h[5]) ^ ((~h[4]) & h[6]);
    temp1 = h[7] + S1 + ch + new_k + new_w;
    S0 = {h[0][30:31],h[0][0:29]} ^ {h[0][19:31],h[0][0:18]} ^ {h[0][10:31],h[0][0:9]};
    maj = (h[0] & h[1]) ^ (h[0] & h[2]) ^ {h[1] & h[2]};
    temp2 = S0 + maj;
    new_h[0] = temp1 + temp2;
    new_h[1] = h[0];
    new_h[2] = h[1];
    new_h[3] = h[2];
    new_h[4] = h[3] + temp1;
    new_h[5] = h[4];
    new_h[6] = h[5];
    new_h[7] = h[6];
    end
  end    
endmodule 