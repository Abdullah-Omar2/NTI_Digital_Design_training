library ieee;
use ieee.std_logic_1164.all;

entity decoder_bcd_to_integer is
  port (bcd : in  std_logic_vector (3 downto 0);
        int_out : out integer range 0 to 9);
end entity;

architecture behavioral of decoder_bcd_to_integer is
begin
  process (bcd)
  begin
    
    case bcd is
      when "0000" => int_out <= 0;
      when "0001" => int_out <= 1;
      when "0010" => int_out <= 2;
      when "0011" => int_out <= 3;
      when "0100" => int_out <= 4;
      when "0101" => int_out <= 5;
      when "0110" => int_out <= 6;
      when "0111" => int_out <= 7;
      when "1000" => int_out <= 8;
      when "1001" => int_out <= 9;
      when others => int_out <= 0;
    end case;
    
  end process;

end architecture;






