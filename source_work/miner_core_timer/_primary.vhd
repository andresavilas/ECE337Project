library verilog;
use verilog.vl_types.all;
entity miner_core_timer is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        enable_timer    : in     vl_logic;
        rollover_val    : in     vl_logic_vector(6 downto 0);
        count           : out    vl_logic_vector(6 downto 0);
        rollover_flag   : out    vl_logic
    );
end miner_core_timer;
