library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_gate_tb is
end entity;

architecture behavioral of and_gate_tb is
  
  component and_gate is
    port (a, b : in  std_logic;
          z : out std_logic);
  end component;
  
  signal a, b, z : std_logic;
  
begin
  
  dut : and_gate port map (a, b, z);
    
  sim_proc1 : process
  begin
    
    a <= '0'; b <= '0';
    wait for 10 ns;
    
    a <= '0'; b <= '1';
    wait for 10 ns;
    
    a <= '1'; b <= '0';
    wait for 10 ns;
    
    a <= '1'; b <= '1';
    wait for 10 ns;
    
  end process;
  
end architecture;