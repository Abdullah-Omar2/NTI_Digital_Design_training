
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end tb_ALU;

architecture test of tb_ALU is

    -- Component Declaration
    component ALU
        Port (
            en       : in  STD_LOGIC;
            selector : in  STD_LOGIC_VECTOR(3 downto 0);
            A        : in  STD_LOGIC_VECTOR(7 downto 0);
            B        : in  STD_LOGIC_VECTOR(7 downto 0);
            result   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals
    signal en       : STD_LOGIC := '0';
    signal selector : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal A, B     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal result   : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate UUT
    uut: ALU
        port map (
            en       => en,
            selector => selector,
            A        => A,
            B        => B,
            result   => result
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Enable the ALU
        en <= '1';

        -- Loop through all ALU operations (16 possible opcodes)
        for sel in 0 to 15 loop
            selector <= std_logic_vector(to_unsigned(sel, 4));

            -- Loop through a subset of A and B values (e.g., 0 to 15) to avoid long simulation
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                    A <= std_logic_vector(to_unsigned(i, 8));
                    B <= std_logic_vector(to_unsigned(j, 8));
                    wait for 10 ns;
                end loop;
            end loop;
        end loop;

        -- Disable the ALU
        en <= '0';
        wait;
    end process;

end test;
