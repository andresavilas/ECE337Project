library verilog;
use verilog.vl_types.all;
entity miner_MCU is
    port(
        send_data       : in     vl_logic;
        data_ready      : in     vl_logic;
        finished        : in     vl_logic;
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        count_enable    : out    vl_logic;
        hash_enable     : out    vl_logic;
        nonce_flag      : in     vl_logic
    );
end miner_MCU;
