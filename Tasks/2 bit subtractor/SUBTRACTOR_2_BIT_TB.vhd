library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor_2_bit_tb is
end entity;

architecture behavioral of subtractor_2_bit_tb is
  
  component subtractor_2_bit is
    port (x, y : in  std_logic_vector (1 downto 0);
          z : out std_logic_vector (1 downto 0);
          sign : out std_logic);
  end component;
  
  signal x, y : std_logic_vector (1 downto 0):= "11";
  signal z : std_logic_vector (1 downto 0);
  signal sign : std_logic;
  
begin
  
  dut : subtractor_2_bit port map (x, y, z, sign);
    
  sim_proc1 : process
  begin
    
    for i in 0 to 3 loop
      
      x <= std_logic_vector(unsigned (x) + 1);
      
      for i in 0 to 3 loop
      
        y <= std_logic_vector(unsigned (y) + 1);
        
        wait for 10 ns;
        
      end loop;
      
    end loop;
    
  end process;
  
end architecture;


