library verilog;
use verilog.vl_types.all;
entity miner_core_index is
    port(
        i               : in     vl_logic_vector(6 downto 0);
        win             : in     vl_logic_vector(2047 downto 0);
        w16             : out    vl_logic_vector(31 downto 0);
        s0              : out    vl_logic_vector(31 downto 0);
        s1              : out    vl_logic_vector(31 downto 0);
        w7              : out    vl_logic_vector(31 downto 0)
    );
end miner_core_index;
