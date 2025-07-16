library ieee;
use ieee.std_logic_1164.all;

entity mux_4_to_1_by_case is
  port (selector : in  std_logic_vector (1 downto 0);
        a, b, c, d : in std_logic;
        y : out std_logic);
end entity;

architecture behavioral of mux_4_to_1_by_case is
begin
  
  process (selector, a, b, c, d)
  begin
    case (selector) is
      when "00" => y <= a;
      when "01" => y <= b;
      when "10" => y <= c;
      when "11" => y <= d;
      when others => y <= '0';
    end case;
  end process;
       
end architecture;


