library verilog;
use verilog.vl_types.all;
entity uartrx_start_bit_det is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        serial_in       : in     vl_logic;
        start_bit_detected: out    vl_logic
    );
end uartrx_start_bit_det;
