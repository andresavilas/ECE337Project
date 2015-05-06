library verilog;
use verilog.vl_types.all;
entity miner_core_comp is
    port(
        comp_en         : in     vl_logic;
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        w               : in     vl_logic_vector(0 to 63);
        first_h         : in     vl_logic_vector(0 to 7);
        h               : out    vl_logic_vector(0 to 7)
    );
end miner_core_comp;
