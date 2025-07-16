library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_3_bit_tb is
end entity;

architecture behavioral of counter_3_bit_tb is
  
  component counter_3_bit is
    port (clk, rst : in  std_logic;
          q : out std_logic_vector (2 downto 0));
  end component;
  
  signal clk, rst : std_logic;
  
  signal q : std_logic_vector (2 downto 0);
  
begin
  
  counter : counter_3_bit port map (clk, rst, q);
  
  process
  begin
    
    clk <='0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    
  end process;
  
  process
  begin
    
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait;
    
  end process;
  
end architecture;


