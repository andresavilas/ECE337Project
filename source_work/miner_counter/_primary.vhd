library verilog;
use verilog.vl_types.all;
entity miner_counter is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        clear           : in     vl_logic;
        count_enable    : in     vl_logic;
        nonce           : out    vl_logic_vector(31 downto 0);
        nonce_flag      : out    vl_logic
    );
end miner_counter;
