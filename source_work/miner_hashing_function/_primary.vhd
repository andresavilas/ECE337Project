library verilog;
use verilog.vl_types.all;
entity miner_hashing_function is
    generic(
        NUM_CORES       : integer := 3
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        hash_enable     : in     vl_logic;
        nonce           : in     vl_logic_vector(0 to 31);
        \block\         : in     vl_logic_vector(0 to 607);
        target          : in     vl_logic_vector(0 to 255);
        correct_hash    : out    vl_logic_vector(0 to 255);
        correct_nonce   : out    vl_logic_vector(0 to 31);
        finished        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_CORES : constant is 1;
end miner_hashing_function;
