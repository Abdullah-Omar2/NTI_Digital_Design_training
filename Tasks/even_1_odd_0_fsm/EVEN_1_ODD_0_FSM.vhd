library ieee;
use ieee.std_logic_1164.all;

entity even_1_odd_0_fsm is
  port (rst : in  std_logic;
        clk : in  std_logic;
        data : in  std_logic;
        output : out std_logic);
end entity;

architecture behavioral of even_1_odd_0_fsm is
  
  signal state : std_logic_vector (1 downto 0):="00";
  
begin
  
  process (rst, clk, data)
  begin
    if rst = '1' then 
      state <= "00";
      output <= '0';
    elsif rising_edge(clk) then
      case (state) is
        when "00" =>
          if data = '1' then 
            state  <= "11";
            output <= '0';
          elsif data = '0' then
            state  <= "10";
            output <= '1';
          end if;
        when "01" =>
          if data = '1' then 
            state  <= "10";
            output <= '1';
          elsif data = '0' then
            state  <= "11";
            output <= '0';
          end if;
        when "10" =>
          if data = '1' then 
            state  <= "01";
            output <= '0';
          elsif data = '0' then
            state  <= "00";
            output <= '0';
          end if;
        when "11" =>
          if data = '1' then 
            state  <= "00";
            output <= '0';
          elsif data = '0' then
            state  <= "01";
            output <= '0';
          end if;
        when others => output <= '0';
      end case;
    end if;
  end process;      

end architecture;


