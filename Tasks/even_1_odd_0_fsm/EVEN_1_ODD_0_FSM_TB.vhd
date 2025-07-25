library ieee;
use ieee.std_logic_1164.all;

entity even_1_odd_0_fsm_tb is
end entity;

architecture behavioral of even_1_odd_0_fsm_tb is
  
  component even_1_odd_0_fsm is
    port (rst : in  std_logic;
          clk : in  std_logic;
          data : in  std_logic;
          output : out std_logic);
  end component;
  
  signal rst : std_logic;
  signal clk : std_logic;
  signal data : std_logic;
  signal output : std_logic;
  
begin
  
  dut : even_1_odd_0_fsm port map (rst, clk, data, output);
  
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
    data <= '0';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    data <= '1';
    wait for 10 ns;
    data <= '0';
    wait for 10 ns;
    
  end process;      

end architecture;




