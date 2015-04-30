module miner_hashing_function
  #(
  NUM_CORES = 3
  )
  (
  input wire clk,
  input wire n_rst,
  input wire hash_enable,
  input wire [0:31] nonce,
  input wire [0:607] block,
  input wire [0:255] target,
  output reg [0:255] correct_hash,
  output reg [0:31] correct_nonce,
  output reg finished
  );
  
  //reg [NUM_CORES - 1:0] output_hashes;
  //reg [NUM_CORES - 1:0] output_finished;
  //reg [NUM_CORES - 1:0] output_correct;
  //reg [NUM_CORES - 1:0] index;
  
  reg [0: NUM_CORES - 1] [0:255] output_hashes;
  reg [0: NUM_CORES - 1] output_finished;
  reg [0: NUM_CORES - 1] output_correct;
  
  genvar i;
  integer j;
  reg finishedTemp = 1'b1;
  reg [0:255] correctHashTemp;
  reg [0:31] correctNonceTemp;
  
  
  generate
    for(i = 0; i <= (NUM_CORES - 1); i = i + 1)
    begin
      miner_core MCX(.clk(clk), .n_rst(n_rst), .hash_enable(hash_enable), .nonce(nonce+i), .block(block), .target(target), .hashed(output_hashes[i]), .finished(output_finished[i]), .correct(output_correct[i]));
      //assign correct_hash = (output_finished[i] & output_correct[i])? output_hashes[i]: 64'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
      //assign correct_nonce = (output_finished[i] & output_correct[i])? (nonce+i):0;
      //assign finished = output_finished[i];
    end
  endgenerate
  
  always_comb
  begin
    finishedTemp = output_finished[0];
    correctHashTemp = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    correctNonceTemp = 0;
    for(j = 0; j <= (NUM_CORES - 1); j = j + 1)
    begin
      //correctHashTemp = (output_correct[j])? output_hashes[j]: 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
      //correctNonceTemp = (output_correct[j])? (nonce+j):0;
      
      correctHashTemp = output_hashes[j];
      correctNonceTemp = nonce + j;
      
      if(output_correct[j] == 1)
      begin
        break;
      end
      else
      begin
        correctHashTemp = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        correctNonceTemp = 0;
      end
      
      finishedTemp = (finishedTemp && output_finished[j])?1:0;
    end
  end
  assign finished = finishedTemp;
  assign correct_hash = correctHashTemp;
  assign correct_nonce = correctNonceTemp;
endmodule