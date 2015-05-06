library verilog;
use verilog.vl_types.all;
entity miner_core_msa is
    port(
        msa_en          : in     vl_logic;
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        chunk           : in     vl_logic_vector(0 to 511);
        w               : out    vl_logic_vector(0 to 63)
    );
end miner_core_msa;
