library verilog;
use verilog.vl_types.all;
entity miner_core is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        hash_enable     : in     vl_logic;
        \block\         : in     vl_logic_vector(0 to 607);
        nonce           : in     vl_logic_vector(31 downto 0);
        target          : in     vl_logic_vector(0 to 255);
        finished        : out    vl_logic;
        correct         : out    vl_logic;
        hashed          : out    vl_logic_vector(0 to 255)
    );
end miner_core;
