library ieee;
use ieee.std_logic_1164.all;

entity tristate_buffer is
  port (enable : in  std_logic;
        input : in std_logic_vector (7 downto 0);
        output : out std_logic_vector (7 downto 0));
end entity;

architecture behavioral of tristate_buffer is
begin
  
  output <= input when enable = '1' else
            (others => 'Z');
       
end architecture;
