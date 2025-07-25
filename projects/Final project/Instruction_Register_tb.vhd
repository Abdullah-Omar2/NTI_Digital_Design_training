library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_SpecialReg8Bit is
end tb_SpecialReg8Bit;

architecture behavior of tb_SpecialReg8Bit is

    -- Component Declaration
    component SpecialReg8Bit
        Port (
            clk, rst, load, en_out : in STD_LOGIC;
            data_in  : in STD_LOGIC_VECTOR(7 downto 0);
            data_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal load     : STD_LOGIC := '0';
    signal en_out   : STD_LOGIC := '0';
    signal data_in  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate Unit Under Test
    uut: SpecialReg8Bit
        port map (
            clk      => clk,
            rst      => rst,
            load     => load,
            en_out   => en_out,
            data_in  => data_in,
            data_out => data_out
        );

    -- Clock Generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Apply reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- Enable output
        en_out <= '1';

        -- Loop through all possible 8-bit values
        for i in 0 to 255 loop
            data_in <= std_logic_vector(to_unsigned(i, 8));
            load <= '1';
            wait for clk_period;
            load <= '0';
            wait for clk_period;

            -- Test with en_out = '0'
            en_out <= '0';
            wait for clk_period;

            -- Re-enable output for next iteration
            en_out <= '1';
        end loop;

        wait;
    end process;

end behavior;

