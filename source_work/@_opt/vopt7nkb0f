library verilog;
use verilog.vl_types.all;
entity uartrx_buffer is
    generic(
        NUM_BITS        : integer := 864
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        packet          : in     vl_logic_vector(7 downto 0);
        parallel_out    : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_BITS : constant is 1;
end uartrx_buffer;
