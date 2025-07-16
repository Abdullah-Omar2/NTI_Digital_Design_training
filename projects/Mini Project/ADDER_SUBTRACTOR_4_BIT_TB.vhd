library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_adder_subtractor_4bit is
end entity;

architecture behavior of tb_adder_subtractor_4bit is

  -- Component declaration
  component adder_subtractor_4bit
    port (
      operand1 : in  std_logic_vector(3 downto 0);
      operand2 : in  std_logic_vector(3 downto 0);
      mode     : in  std_logic;
      result   : out std_logic_vector(3 downto 0);
      cout     : out std_logic
    );
  end component;

  -- Test signals
  signal operand1 : std_logic_vector(3 downto 0);
  signal operand2 : std_logic_vector(3 downto 0);
  signal mode     : std_logic;
  signal result   : std_logic_vector(3 downto 0);
  signal cout     : std_logic;

begin

  -- Instantiate the design under test (DUT)
  DUT: adder_subtractor_4bit
    port map (
      operand1 => operand1,
      operand2 => operand2,
      mode     => mode,
      result   => result,
      cout     => cout
    );

  -- Stimulus process
  stim_proc: process
  begin

    -- Test Case 1: 3 + 4 = 7
    operand1 <= "0011";  -- 3
    operand2 <= "0100";  -- 4
    mode     <= '0';     -- Addition
    wait for 10 ns;

    -- Test Case 2: 7 - 2 = 5
    operand1 <= "0111";  -- 7
    operand2 <= "0010";  -- 2
    mode     <= '1';     -- Subtraction
    wait for 10 ns;

    -- Test Case 3: 5 + 6 = 11
    operand1 <= "0101";  -- 5
    operand2 <= "0110";  -- 6
    mode     <= '0';     -- Addition
    wait for 10 ns;

    -- Test Case 4: 3 - 4 = -1 (1111 in 2's complement)
    operand1 <= "0011";  -- 3
    operand2 <= "0100";  -- 4
    mode     <= '1';     -- Subtraction
    wait for 10 ns;

    -- Test Case 5: 0 - 1 = -1 (1111)
    operand1 <= "0000";
    operand2 <= "0001";
    mode     <= '1';
    wait for 10 ns;

    -- Test Case 6: 15 - 15 = 0
    operand1 <= "1111";
    operand2 <= "1111";
    mode     <= '1';
    wait for 10 ns;

    wait;
  end process;

end architecture;


