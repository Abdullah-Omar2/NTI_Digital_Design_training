library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
  port (a, b : in  std_logic;
        z : out std_logic);
end entity;

architecture behavioral of and_gate is
begin
  
  z <= a and b;

end architecture;
