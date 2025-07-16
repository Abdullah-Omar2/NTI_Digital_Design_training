library ieee;
use ieee.std_logic_1164.all;

entity decoder_bcd_to_7_segment is
  port (bcd : in  std_logic_vector (3 downto 0);
        sev_seg : out std_logic_vector (6 downto 0));
end entity;

architecture behavioral of decoder_bcd_to_7_segment is
begin
  process (bcd)
  begin
    
    case bcd is
      when "0000" => sev_seg <= "0000001";
      when "0001" => sev_seg <= "1001111";
      when "0010" => sev_seg <= "0010010";
      when "0011" => sev_seg <= "0000110";
      when "0100" => sev_seg <= "1001100";
      when "0101" => sev_seg <= "0100100";
      when "0110" => sev_seg <= "0100000";
      when "0111" => sev_seg <= "0001111";
      when "1000" => sev_seg <= "0000000";
      when "1001" => sev_seg <= "0001100";
      when others => sev_seg <= "1111111";
    end case;
    
  end process;

end architecture;




