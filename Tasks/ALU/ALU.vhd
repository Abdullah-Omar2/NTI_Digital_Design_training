library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (a, b : in  std_logic_vector (7 downto 0);
        c : in std_logic_vector (2 downto 0);
        z : out std_logic_vector (7 downto 0));
end entity;

architecture behavioral of alu is
begin
  
  process (a, b, c)
  begin
    if (c(2) = '1') then
      case c(1 downto 0) is
        when "00" => z <= std_logic_vector(unsigned(a) + unsigned(b));
        when "01" => z <= std_logic_vector(unsigned(a) - unsigned(b));
        when "10" => z <= a and b;
        when "11" => z <= a or b;
        when others => z <= (others => 'Z');
      end case;
    else
      z <= std_logic_vector(unsigned(a) + 1);
    end if;
  end process;

end architecture;


