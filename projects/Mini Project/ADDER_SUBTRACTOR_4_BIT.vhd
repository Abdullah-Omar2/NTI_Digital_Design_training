library IEEE;
use ieee.std_logic_1164.all;

entity adder_subtractor_4bit is
  port (
    operand1 : in  std_logic_vector(3 downto 0);
    operand2 : in  std_logic_vector(3 downto 0);
    mode     : in  std_logic;  -- '0' for addition, '1' for subtraction
    result   : out std_logic_vector(3 downto 0);
    cout     : out std_logic
  );
end entity;

architecture Behavioral of adder_subtractor_4bit is

  component full_adder_4_bit is
    port (a, b : in  std_logic_vector (3 downto 0);
          c_in : in std_logic;
          s : out std_logic_vector (3 downto 0);
          c_out : out std_logic);
  end component;

  signal y_modified : std_logic_vector(3 downto 0);

begin

  -- Invert y bits if mode = '1' for subtraction
  y_modified <= operand2 xor (mode & mode & mode & mode);  -- Bitwise XOR for inversion

  -- Instantiate 4-bit full adder for both add and subtract operations
  FA: full_adder_4_bit
    port map (
      a    => operand1,
      b    => y_modified,
      c_in  => mode,
      s  => result,
      c_out => cout
    );

end architecture;


