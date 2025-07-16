library ieee;
use ieee.std_logic_1164.all;

entity x_2_bit_plus_y_1_bit_square is
  port (y : in std_logic;
        x : in std_logic_vector (1 downto 0);
        z : out std_logic_vector (2 downto 0));
end entity;

architecture behavioral of x_2_bit_plus_y_1_bit_square is
  
  component mux_4_to_1_1_bit is
    port (selector : in  std_logic_vector (1 downto 0);
          a, b, c, d : in std_logic;
          y : out std_logic);
  end component;
  
  component decoder_3_to_8 is
    port (enable : in std_logic;
          input : in  std_logic_vector (2 downto 0);
          output : out std_logic_vector (7 downto 0));
  end component;
  
  signal mux_selector : std_logic_vector (1 downto 0);
  
  signal decoder_in : std_logic_vector (2 downto 0);
  
  signal decoder_out : std_logic_vector (7 downto 0);
  
  signal not_x_0 : std_logic;
  
begin
  
  not_x_0 <= not x(0);
  
  mux_selector <= y & x(1);
  
  decoder_in <= y & x;
  
  mux1 : mux_4_to_1_1_bit port map (mux_selector, x(0), x(0), not_x_0, not_x_0, z(0));
    
  decoder1 : decoder_3_to_8 port map ('1', decoder_in, decoder_out);
    
  z(1) <= decoder_out(2) or decoder_out(3) or decoder_out(5) or decoder_out(6);
  
  z(2) <= y and x(1) and x(0);

end architecture;



