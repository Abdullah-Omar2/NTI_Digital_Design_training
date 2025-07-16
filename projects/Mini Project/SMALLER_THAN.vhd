library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity smaller_than is
  port (op1, op2 : in  std_logic_vector (3 downto 0);
        res : out std_logic);
end entity;

architecture behavioral of smaller_than is
begin
  
  res <= '1' when op1 < op2 else '0';

end architecture;



