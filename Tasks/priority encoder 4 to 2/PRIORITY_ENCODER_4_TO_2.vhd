library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder_4_to_2 is
  port (d : in  std_logic_vector (3 downto 0);
        y : out std_logic_vector (1 downto 0);
        v : out std_logic);
end entity;

architecture behavioral of priority_encoder_4_to_2 is
begin
  
  process (d)
  begin
    case (d) is
      when "1000" | "1001" | "1010" | "1011" | "1100" | "1101" | "1110" | "1111" => 
        y <= "11";
        v <= '1';
      when "0100" | "0101" | "0110" | "0111" => 
        y <= "10";
        v <= '1';
      when "0010" | "0011" => 
        y <= "01";
        v <= '1';
      when "0001" => 
        y <= "00";
        v <= '1';
      when others =>
        y <= "ZZ";
        v <= '0';
    end case;
  end process;
  
end architecture;

