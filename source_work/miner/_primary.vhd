library verilog;
use verilog.vl_types.all;
entity miner is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        rx_data         : in     vl_logic_vector(863 downto 0);
        data_ready      : in     vl_logic;
        send_data       : out    vl_logic;
        tx_data         : out    vl_logic_vector(287 downto 0)
    );
end miner;
