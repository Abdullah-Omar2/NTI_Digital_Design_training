library ieee;
use ieee.std_logic_1164.all;

entity mux_4_to_1_1_bit is
  port (selector : in  std_logic_vector (1 downto 0);
        a, b, c, d : in std_logic;
        y : out std_logic);
end entity;

architecture behavioral of mux_4_to_1_1_bit is
begin
  
  y <= a when selector = "00" else
       b when selector = "01" else
       c when selector = "10" else
       d when selector = "11" else
       'Z';
       
end architecture;
