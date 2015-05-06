library verilog;
use verilog.vl_types.all;
entity miner_counter is
    generic(
        CORES           : integer := 1
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        clear           : in     vl_logic;
        count_enable    : in     vl_logic;
        nonce           : out    vl_logic_vector(31 downto 0);
        nonce_flag      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CORES : constant is 1;
end miner_counter;
