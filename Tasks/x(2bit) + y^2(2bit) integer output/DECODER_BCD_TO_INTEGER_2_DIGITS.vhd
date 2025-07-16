library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_bcd_to_integer_2_digits is
  port (bcd : in  std_logic_vector (3 downto 0);
        int_out : out integer range 0 to 15);
end entity;

architecture behavioral of decoder_bcd_to_integer_2_digits is
  
  component decoder_bcd_to_integer is
    port (bcd : in  std_logic_vector (3 downto 0);
          int_out : out integer range 0 to 9);
  end component;
  
  component full_adder_4_bit is
    port (a, b : in  std_logic_vector (3 downto 0);
          c_in : in std_logic;
          s : out std_logic_vector (3 downto 0);
          c_out : out std_logic);
  end component;
  
  signal fa_sum : std_logic_vector (3 downto 0);
  
  signal fa_carry : std_logic;
  
  signal ones : integer range 0 to 9;
  
  signal tens : integer range 0 to 1;
  
begin
  
  fa1 : full_adder_4_bit port map (bcd, "0110", '0', fa_sum, fa_carry);
    
  decoder1 : decoder_bcd_to_integer port map (fa_sum, ones);
    
  tens <= 1 when fa_carry = '1' else
          0;
          
  int_out <= tens * 10 + ones;

end architecture;








