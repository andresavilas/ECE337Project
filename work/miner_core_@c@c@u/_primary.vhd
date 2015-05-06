library verilog;
use verilog.vl_types.all;
entity miner_core_CCU is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        hash_enable     : in     vl_logic;
        rollover_flag   : in     vl_logic;
        \select\        : out    vl_logic;
        enable_timer    : out    vl_logic;
        rollover_val    : out    vl_logic_vector(6 downto 0);
        msa_en          : out    vl_logic;
        comp_en         : out    vl_logic;
        msa2_en         : out    vl_logic;
        comp2_en        : out    vl_logic;
        add_en          : out    vl_logic;
        add2_en         : out    vl_logic;
        finished        : out    vl_logic
    );
end miner_core_CCU;
