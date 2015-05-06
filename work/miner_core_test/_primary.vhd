library verilog;
use verilog.vl_types.all;
entity miner_core_test is
    port(
        e               : in     vl_logic_vector(0 to 31);
        a               : in     vl_logic_vector(0 to 31);
        S0              : out    vl_logic_vector(0 to 31);
        S1              : out    vl_logic_vector(0 to 31)
    );
end miner_core_test;
