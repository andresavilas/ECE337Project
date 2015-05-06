library verilog;
use verilog.vl_types.all;
entity bitcoinminer is
    generic(
        CORES           : integer := 1
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        serial_in       : in     vl_logic;
        serial_out      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CORES : constant is 1;
end bitcoinminer;
