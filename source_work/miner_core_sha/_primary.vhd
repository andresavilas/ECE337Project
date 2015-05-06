library verilog;
use verilog.vl_types.all;
entity miner_core_sha is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        msa_en          : in     vl_logic;
        comp_en         : in     vl_logic;
        add_en          : in     vl_logic;
        chunk           : in     vl_logic_vector(0 to 511);
        fh              : in     vl_logic_vector(0 to 7);
        h               : out    vl_logic_vector(0 to 255)
    );
end miner_core_sha;
