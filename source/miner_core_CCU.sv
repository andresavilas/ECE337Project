//Michael Loh
//Bitcoin Miner Project
//Miner Core Control Unit

module miner_core_CCU
(
  input wire clk,
  input wire n_rst,
  input wire hash_enable,
  input wire rollover_flag,
  output reg select,
  output reg enable_timer,
  output reg [6:0]rollover_val,
  output reg msa_en,
  output reg comp_en,
  output reg msa2_en,
  output reg comp2_en,
  output reg add_en,
  output reg add2_en,
  output reg finished
);

typedef enum bit [3:0] {IDLE, MSA1, COMP1, ADDH1, MSA2, COMP2, ADDH2, MSA3, COMP3, ADDH3, FINISHED} stateType;
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
  next_state = state;
  case(state)
    IDLE:
    begin
      select = 0;
      enable_timer = 0;
      rollover_val = 0;
      msa_en = 0;
      comp_en = 0;
      msa2_en = 0;
      comp2_en = 0;
      add_en = 0;
      add2_en = 0;
      finished = 0;
      if(hash_enable == 1'b1)
        next_state = MSA1;
      else if(hash_enable == 1'b0)
        next_state = IDLE;
    end
    MSA1:
    begin
      select = 0;
      enable_timer = 1;
      rollover_val = 48;
      msa_en = 1;
      comp_en = 0;
      msa2_en = 0;
      comp2_en = 0;
      add_en = 0;
      add2_en = 0;
      finished = 0;
      if(rollover_flag == 1'b1)
        next_state = COMP1;
      else if(rollover_flag == 1'b0)
        next_state = MSA1;
    end
    COMP1:
    begin
      enable_timer = 1;
      rollover_val = 64;
      msa_en = 0;
      comp_en = 1;
      if(rollover_flag == 1'b1)
        next_state = ADDH1;
      else if(rollover_flag == 1'b0)
        next_state = COMP1;
    end
    ADDH1:
    begin
      enable_timer = 0;
      comp_en = 0;
      add_en = 1;
      next_state = MSA2;
    end
    MSA2:
    begin
      select = 1;
      enable_timer = 1;
      rollover_val = 48;
      msa_en = 1;
      comp_en = 0;
      if (rollover_flag == 1'b1)
        next_state = COMP2;
      else if (rollover_flag == 1'b0)
        next_state = MSA2;
    end
    COMP2:
    begin
      rollover_val = 64;
      msa_en = 0;
      comp_en = 1;
      if(rollover_flag == 1'b1)
        next_state = ADDH2;
      else if(rollover_flag == 1'b0)
        next_state = COMP2;
    end
    ADDH2:
    begin
      comp_en = 0;
      enable_timer = 0;
      add_en = 1;
      next_state = MSA3;
    end
    MSA3:
    begin
      enable_timer = 1;
      rollover_val = 48;
      msa2_en = 1;
      add_en = 0;
      if(rollover_val == 1'b1)
        next_state = COMP3;
      else
        next_state = MSA3;
    end
    COMP3:
    begin
      rollover_val = 64;
      msa2_en = 0;
      comp2_en = 1;
      if(rollover_val == 1'b1)
        next_state = ADDH3;
      else if(rollover_val == 1'b0)
        next_state = COMP3; 
    end
    ADDH3:
    begin
      comp2_en = 0;
      enable_timer = 0;
      add2_en = 1;
      next_state = FINISHED;
    end
    FINISHED:
    begin
      add2_en = 0;
      finished = 1;
      next_state = IDLE;
    end
  endcase
end
endmodule



