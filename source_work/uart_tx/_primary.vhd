library verilog;
use verilog.vl_types.all;
entity uart_tx is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        tx_data         : in     vl_logic_vector(287 downto 0);
        send_data       : in     vl_logic;
        serial_out      : out    vl_logic
    );
end uart_tx;
