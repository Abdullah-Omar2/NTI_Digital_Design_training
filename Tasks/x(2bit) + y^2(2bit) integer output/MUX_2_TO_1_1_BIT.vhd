library ieee;
use ieee.std_logic_1164.all;

entity mux_2_to_1_1_bit is
  port (selector : in  std_logic;
        a, b : in std_logic;
        y : out std_logic);
end entity;

architecture behavioral of mux_2_to_1_1_bit is
begin
  
  y <= a when selector = '0' else
       b when selector = '1' else
       'Z';
       
end architecture;


