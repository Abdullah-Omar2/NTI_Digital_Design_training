library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_routing_net_tb is 
end entity;

architecture behav of priority_routing_net_tb is

  component priority_routing_net is 
	port(

	 a,b: in std_logic_vector ( 3 downto 0);
	 x,y: in std_logic_vector ( 1 downto 0);
	 f : out std_logic_vector  (4 downto 0));

  end component;
  
  signal a, b : std_logic_vector ( 3 downto 0):= "1111";
  signal x, y : std_logic_vector ( 1 downto 0):= "11";
  signal f : std_logic_vector  (4 downto 0);

begin

  dut : priority_routing_net port map (a, b, x, y, f);
    
  sim_proc1 : process
  begin
    
    for i in 0 to 15 loop
      a <= std_logic_vector(unsigned (a) + 1);
      for i in 0 to 15 loop
        b <= std_logic_vector(unsigned (b) + 1);
        for i in 0 to 3 loop
          x <= std_logic_vector(unsigned (x) + 1);
          for i in 0 to 3 loop
            
            y <= std_logic_vector(unsigned (y) + 1);
            wait for 10 ns;
     
          end loop;
     
        end loop;
     
      end loop;
     
    end loop;
    
    wait;
    
  end process;

end architecture;