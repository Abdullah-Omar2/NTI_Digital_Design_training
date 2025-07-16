library ieee;
use ieee.std_logic_1164.all;

entity x_2_bit_plus_y_2_bit_square_out_integer is
  port (y : in std_logic_vector (1 downto 0);
        x : in std_logic_vector (1 downto 0);
        z_int : out integer range 0 to 15);
end entity;

architecture behavioral of x_2_bit_plus_y_2_bit_square_out_integer is
  
  component x_2_bit_plus_y_2_bit_square is
    port (y : in std_logic_vector (1 downto 0);
          x : in std_logic_vector (1 downto 0);
          z : out std_logic_vector (3 downto 0));
  end component;
  
  component decoder_bcd_to_integer_2_digits is
    port (bcd : in  std_logic_vector (3 downto 0);
          int_out : out integer range 0 to 15);
  end component;
  
  signal z_out : std_logic_vector (3 downto 0);
  
begin
  
  c1 : x_2_bit_plus_y_2_bit_square port map (y, x, z_out);
    
  c2 : decoder_bcd_to_integer_2_digits port map (z_out, z_int);

end architecture;






