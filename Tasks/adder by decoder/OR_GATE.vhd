library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
  port (a, b, c, d : in  std_logic;
        z : out std_logic);
end entity;

architecture behavioral of or_gate is
begin
  
  z <= a or b or c or d;

end architecture;


