library ieee;
use ieee.std_logic_1164.all;  -- Import the IEEE standard logic library

entity tristate_buffer is
  port (
    enable : in  std_logic;                    -- Control signal to enable or disable the buffer
    input  : in  std_logic_vector(7 downto 0); -- 8-bit input data to the buffer
    output : out std_logic_vector(7 downto 0)  -- 8-bit output from the buffer
  );
end entity;

architecture behavioral of tristate_buffer is
begin

  -- When 'enable' is '1', pass the input to the output
  -- Otherwise, set the output to high impedance ('Z')
  output <= input when enable = '1' else
            (others => 'Z');

end architecture;
