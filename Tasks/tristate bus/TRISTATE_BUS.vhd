library ieee;
use ieee.std_logic_1164.all;

entity tristate_bus is
  port (selecor : in  std_logic_vector (1 downto 0);
        i1 : in std_logic_vector (7 downto 0);
        i2 : in std_logic_vector (7 downto 0);
        i3 : in std_logic_vector (7 downto 0);
        i4 : in std_logic_vector (7 downto 0);
        output : out std_logic_vector (7 downto 0));
end entity;

architecture behavioral of tristate_bus is
  
  component tristate_buffer is
    port (enable : in  std_logic;
          input : in std_logic_vector (7 downto 0);
          output : out std_logic_vector (7 downto 0));
  end component;
  
  component decoder_2_to_4 is
    port (enable : in std_logic;
          input : in  std_logic_vector (1 downto 0);
          output : out std_logic_vector (3 downto 0));
  end component;
  
  signal decoder_out : std_logic_vector (3 downto 0);
  
begin
  
  tb1 : tristate_buffer port map (decoder_out(0), i1, output);
  tb2 : tristate_buffer port map (decoder_out(1), i2, output);
  tb3 : tristate_buffer port map (decoder_out(2), i3, output);
  tb4 : tristate_buffer port map (decoder_out(3), i4, output);
    
  decoder : decoder_2_to_4 port map ('1', selecor, decoder_out);
  
       
end architecture;


