library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_2_to_4_tb is
end entity;

architecture behavioral of decoder_2_to_4_tb is
  
  component decoder_2_to_4 is
    port (enable : in std_logic;
          input : in  std_logic_vector (1 downto 0);
          output : out std_logic_vector (3 downto 0));
  end component;
  
  signal enable : std_logic;
  
  signal input : std_logic_vector (1 downto 0):= (others => '0');
  
  signal output : std_logic_vector (3 downto 0);
  
begin
  
  dut : decoder_2_to_4 port map (enable, input, output);
    
  sim_proc1 : process
  begin
    
    enable <= '0';
    
    for i in 0 to 3 loop
      
      input <= std_logic_vector(unsigned (input) + 1);
      wait for 10 ns;
    end loop;
    
    enable <= '1';
    
    for i in 0 to 3 loop
      
      input <= std_logic_vector(unsigned (input) + 1);
      wait for 10 ns;
    end loop;
    
  end process;
  
end architecture;

