library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_4_bit_tb is
end entity;

architecture behavioral of multiplier_4_bit_tb is

  -- Component declaration
  component multiplier_4_bit is
    port (op1, op2 : in  std_logic_vector (3 downto 0);
          res : out std_logic_vector (7 downto 0));
  end component;

  -- Test signals
  signal op1 : std_logic_vector(3 downto 0);
  signal op2 : std_logic_vector(3 downto 0);
  signal res : std_logic_vector(7 downto 0);

begin

  -- Instantiate the design under test (DUT)
  DUT: multiplier_4_bit
    port map (
      op1 => op1,
      op2 => op2,
      res   => res
    );

  -- Stimulus process
  stim_proc: process
  begin

    op1 <= "0011";  -- 3
    op2 <= "0100";  -- 4
    wait for 10 ns;

    op1 <= "0111";  -- 7
    op2 <= "0010";  -- 2
    wait for 10 ns;

    op1 <= "0101";  -- 5
    op2 <= "0110";  -- 6
    wait for 10 ns;

    op1 <= "0011";  -- 3
    op2 <= "0100";  -- 4
    wait for 10 ns;

    op1 <= "0000";
    op2 <= "0001";
    wait for 10 ns;

    op1 <= "1111";
    op2 <= "1111";
    wait for 10 ns;

    wait;
  end process;

end architecture;




