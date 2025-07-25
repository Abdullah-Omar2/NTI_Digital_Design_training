library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg4Bit is
end tb_Reg4Bit;

architecture test of tb_Reg4Bit is

    -- Component Declaration
    component Reg4Bit
        Port (
            clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            load    : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(3 downto 0);
            data_out: out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals for connection
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal load     : STD_LOGIC := '0';
    signal data_in  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Reg4Bit
        port map (
            clk      => clk,
            rst      => rst,
            load     => load,
            data_in  => data_in,
            data_out => data_out
        );

    -- Clock generation
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the register
        rst <= '1';
        wait for clk_period;
        rst <= '0';


        -- Loop through all 4-bit combinations (0 to 15)
        for i in 0 to 15 loop
            data_in <= std_logic_vector(to_unsigned(i, 4));
            load <= '1';
            wait for clk_period;
            load <= '0';
            wait for clk_period;
        end loop;

        wait;
    end process;

end test;
