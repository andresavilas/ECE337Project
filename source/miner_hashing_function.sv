module miner_hashing_function
  #(
  NUM_CORES = 10
  )
  (
  input wire clk,
  input wire n_rst,
  input wire hash_enable,
  input wire [0:31] nonce,
  input wire [0:607] block,
  input wire [0:255] target,
  output wire [0:255] correct_hash,
  output wire [0:31] correct_nonce,
  output wire finished
  );
  
  //reg [NUM_CORES - 1:0] output_hashes;
  //reg [NUM_CORES - 1:0] output_finished;
  //reg [NUM_CORES - 1:0] output_correct;
  //reg [NUM_CORES - 1:0] index;
  
  reg [0: NUM_CORES - 1] [0:255] output_hashes;
  reg [0: NUM_CORES - 1] output_finished;
  reg [0: NUM_CORES - 1] output_correct;
  
  genvar i;
  
  assign finished = 1'b1;
  
  generate
    for(i = 0; i <= (NUM_CORES - 1); i = i + 1)
    begin
      miner_core MCX(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .nonce(nonce+i), .block(block), .target(target), .hashed(output_hashes[i]), .finished(output_finished[i]), .correct(output_correct[i]));
      assign correct_hash = (output_finished[i] & output_correct[i])? output_hashes[i]: 32'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
      assign correct_nonce = (output_finished[i] & output_correct[i])? (nonce+i):0;
      assign finished = output_finished[i];
    end
  endgenerate
  
endmodule