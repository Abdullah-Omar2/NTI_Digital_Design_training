library ieee;
use ieee.std_logic_1164.all;

entity adder_by_decoder is
  port (enable : in std_logic;
        y : in std_logic;
        x : in  std_logic_vector (1 downto 0);
        z : out std_logic_vector (2 downto 0));
end entity;

architecture behavioral of adder_by_decoder is
  
  component decoder_3_to_8 is
    port (enable : in std_logic;
          input : in  std_logic_vector (2 downto 0);
          output : out std_logic_vector (7 downto 0));
  end component;
  
  component or_gate is
    port (a, b, c, d : in  std_logic;
        z : out std_logic);
  end component;
  
  signal decoder_in : std_logic_vector (2 downto 0);
  
  signal decoder_out : std_logic_vector (7 downto 0);
  
begin
  
  decoder_in <= y & x;
  
  d1: decoder_3_to_8 port map (enable, decoder_in, decoder_out);
  
  or1: or_gate port map (decoder_out(2), decoder_out(3), decoder_out(5), decoder_out(6), z(1));
    
  or2: or_gate port map (decoder_out(1), decoder_out(3), decoder_out(4), decoder_out(6), z(0));
    
  z(2) <= decoder_out(7);

end architecture;
