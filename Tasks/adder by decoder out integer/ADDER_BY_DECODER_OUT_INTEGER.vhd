library ieee;
use ieee.std_logic_1164.all;

entity adder_by_decoder_out_integer is
  port (enable : in std_logic;
        y : in std_logic;
        x : in  std_logic_vector (1 downto 0);
        int_out : out integer range 0 to 9);
end entity;

architecture behavioral of adder_by_decoder_out_integer is

  component adder_by_decoder is
    port (enable : in std_logic;
          y : in std_logic;
          x : in  std_logic_vector (1 downto 0);
          z : out std_logic_vector (2 downto 0));
  end component;
  
  component decoder_bcd_to_integer is
    port (bcd : in  std_logic_vector (3 downto 0);
          int_out : out integer range 0 to 9);
  end component;
  
  signal s : std_logic_vector (2 downto 0);
  
  signal decoder_in : std_logic_vector (3 downto 0);
  
begin
  
  decoder_in <= '0' & s;
  
  adder1: adder_by_decoder port map (enable, y, x, s);
  
  decoder1: decoder_bcd_to_integer port map (decoder_in, int_out);

end architecture;

