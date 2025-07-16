library ieee;
use ieee.std_logic_1164.all;

entity x_2_bit_plus_y_2_bit_square is
  port (y : in std_logic_vector (1 downto 0);
        x : in std_logic_vector (1 downto 0);
        z : out std_logic_vector (3 downto 0));
end entity;

architecture behavioral of x_2_bit_plus_y_2_bit_square is
  
  component mux_2_to_1_1_bit is
    port (selector : in  std_logic;
          a, b : in std_logic;
          y : out std_logic);
  end component;
  
  component decoder_4_to_16 is
    port (enable : in std_logic;
          input : in  std_logic_vector (3 downto 0);
          output : out std_logic_vector (15 downto 0));
  end component;
  
  signal not_x_0 : std_logic;
  
  signal decoder_in : std_logic_vector (3 downto 0);
  
  signal decoder_out : std_logic_vector (15 downto 0);
  
begin
  
  not_x_0 <= not x(0);
  
  decoder_in <= y & x;
  
  mux1 : mux_2_to_1_1_bit port map (y(0), x(0), not_x_0, z(0));
    
  decoder : decoder_4_to_16 port map ('1', decoder_in, decoder_out);
    
  z(1) <= decoder_out(2) or decoder_out(3) or decoder_out(5) or decoder_out(6) or 
          decoder_out(10) or decoder_out(11) or decoder_out(13) or decoder_out(14);
          
  z(2) <= decoder_out(7) or decoder_out(8) or decoder_out(9) or decoder_out(10) or 
          decoder_out(11) or decoder_out(15);
          
  z(3) <= y(0) and y(1);

end architecture;




