library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_routing_net is 
	port(

	a,b: in std_logic_vector ( 3 downto 0);
	x,y: in std_logic_vector ( 1 downto 0);
	f : out std_logic_vector  (4 downto 0));

end priority_routing_net;


architecture behav of priority_routing_net is

signal wave1, wave2, wave3: std_logic_vector(4 downto 0); 
signal condition1 : unsigned(1 downto 0);

begin
wave1  <= std_logic_vector(resize((unsigned(a) + unsigned(b)), 5));
wave2  <= std_logic_vector(resize((unsigned(a) - unsigned(b) -1), 5));
wave3  <= std_logic_vector(resize((unsigned(a) +1), 5));
condition1 <= unsigned(x) + unsigned(y);
f <=    wave1 when condition1 > 1 else
	wave2 when ((unsigned(x) > unsigned(y)) and (unsigned(y) >0)) else
	wave3;

end architecture;
