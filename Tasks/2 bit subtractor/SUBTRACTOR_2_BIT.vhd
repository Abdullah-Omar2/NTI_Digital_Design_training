library ieee;
use ieee.std_logic_1164.all;

entity subtractor_2_bit is
  port (x, y : in  std_logic_vector (1 downto 0);
        z : out std_logic_vector (1 downto 0);
        sign : out std_logic);
end entity;

architecture behavioral of subtractor_2_bit is
  
  component decoder_4_to_16 is
    port (enable : in std_logic;
          input : in  std_logic_vector (3 downto 0);
          output : out std_logic_vector (15 downto 0));
  end component;
  
  component mux_4_to_1_1_bit is
    port (selector : in  std_logic_vector (1 downto 0);
          a, b, c, d : in std_logic;
          y : out std_logic);
  end component;
  
  signal decoder_in : std_logic_vector (3 downto 0);
  signal decoder_out : std_logic_vector (15 downto 0);
  
  signal mux_in_00 : std_logic;
  signal mux_in_01 : std_logic;
  signal mux_in_10 : std_logic;
  signal mux_in_11 : std_logic;
  
begin
  
  decoder_in <= x & y;
  
  mux_in_00 <= y(1);
  mux_in_01 <= y(0) and y(1);
  mux_in_10 <= y(0) nor y(1);
  mux_in_11 <= not y(1);
  
  decoder : decoder_4_to_16 port map ('1', decoder_in, decoder_out);
    
  mux : mux_4_to_1_1_bit port map (x, mux_in_00, mux_in_01, mux_in_10, mux_in_11, z(1));
    
  z(0) <= decoder_out(1) or decoder_out(3) or decoder_out(4) or decoder_out(6) or
          decoder_out(9) or decoder_out(11) or decoder_out(12) or decoder_out(14);
          
  --z(1) <= decoder_out(2) or decoder_out(3) or decoder_out(7) or decoder_out(8) or
  --        decoder_out(12) or decoder_out(13);
          
  sign <= decoder_out(1) or decoder_out(3) or decoder_out(2) or decoder_out(6) or
          decoder_out(7) or decoder_out(11);

end architecture;
