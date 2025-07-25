library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_to_4 is
  port (enable : in std_logic;
        input : in  std_logic_vector (1 downto 0);
        output : out std_logic_vector (3 downto 0));
end entity;

architecture behavioral of decoder_2_to_4 is
begin
  process (enable, input)
  begin
    if (enable = '1') then
      case input is
        when "00" => output <= "0001";
        when "01" => output <= "0010";
        when "10" => output <= "0100";
        when "11" => output <= "1000";
        when others => output <= "0000";
      end case;
    else
      output <= "0000";
    end if;
  end process;

end architecture;


