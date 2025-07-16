library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4_bit is
  port (a, b : in  std_logic_vector (3 downto 0);
        c_in : in std_logic;
        s : out std_logic_vector (3 downto 0);
        c_out : out std_logic);
end entity;

architecture behavioral of full_adder_4_bit is
  
  component full_adder is
    port (a, b, c_in : in  std_logic;
          s, c_out : out std_logic);
  end component;

  signal c : std_logic_vector (2 downto 0);

begin
  
  fa0 : full_adder port map (a(0), b(0), c_in, s(0), c(0));
  fa1 : full_adder port map (a(1), b(1), c(0), s(1), c(1));
  fa2 : full_adder port map (a(2), b(2), c(1), s(2), c(2));
  fa3 : full_adder port map (a(3), b(3), c(2), s(3), c_out);

end architecture;
