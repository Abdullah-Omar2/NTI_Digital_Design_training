library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg8Bit is
end tb_Reg8Bit;

architecture behavior of tb_Reg8Bit is

    -- Component Declaration
    component Reg8Bit
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            load    : in  STD_LOGIC;
            data_in : in  STD_LOGIC_VECTOR(7 downto 0);
            data_out: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Testbench Signals
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal load     : STD_LOGIC := '0';
    signal data_in  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Reg8Bit
        Port map (
            clk      => clk,
            rst      => rst,
            load     => load,
            data_in  => data_in,
            data_out => data_out
        );

    -- Clock process
    clk_process :process
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
        -- Apply reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- Test all possible 8-bit values
        for i in 0 to 255 loop
            data_in <= std_logic_vector(to_unsigned(i, 8));
            load <= '1';
            wait for clk_period; -- Load data on rising edge
            load <= '0';
            wait for clk_period; -- Wait to observe output
        end loop;

        -- End simulation
        wait;
    end process;

end behavior;

