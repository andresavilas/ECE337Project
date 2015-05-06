library verilog;
use verilog.vl_types.all;
entity miner_core_msaindex is
    port(
        w15             : in     vl_logic_vector(31 downto 0);
        w2              : in     vl_logic_vector(31 downto 0);
        w16             : in     vl_logic_vector(31 downto 0);
        w7              : in     vl_logic_vector(31 downto 0);
        w               : out    vl_logic_vector(31 downto 0)
    );
end miner_core_msaindex;
