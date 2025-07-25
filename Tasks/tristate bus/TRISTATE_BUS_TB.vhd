library ieee;
use ieee.std_logic_1164.all;

entity tristate_bus_tb is
end entity;

architecture behavioral of tristate_bus_tb is
  
  component tristate_bus is
    port (selecor : in  std_logic_vector (1 downto 0);
          i1 : in std_logic_vector (7 downto 0);
          i2 : in std_logic_vector (7 downto 0);
          i3 : in std_logic_vector (7 downto 0);
          i4 : in std_logic_vector (7 downto 0);
          output : out std_logic_vector (7 downto 0));
  end component;
  
  signal selecor : std_logic_vector (1 downto 0);
  signal i1 : std_logic_vector (7 downto 0);
  signal i2 : std_logic_vector (7 downto 0);
  signal i3 : std_logic_vector (7 downto 0);
  signal i4 : std_logic_vector (7 downto 0);
  signal output : std_logic_vector (7 downto 0);
  
begin
  
  dut : tristate_bus port map (selecor, i1, i2, i3, i4, output);
  
  process
  begin
    
    i1 <= "00110011";
    i2 <= "11001100";
    i3 <= "01010101";
    i4 <= "10101010";
    
    selecor <= "00";
    wait for 10 ns;
    
    selecor <= "01";
    wait for 10 ns;
    
    selecor <= "10";
    wait for 10 ns;
    
    selecor <= "11";
    wait for 10 ns;
    
  end process;
       
end architecture;




