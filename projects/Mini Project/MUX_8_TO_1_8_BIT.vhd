library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8x1_8bit is
  port (
    opcode_input : in  std_logic_vector(2 downto 0);
    in0          : in  std_logic_vector(7 downto 0);
    in1          : in  std_logic_vector(7 downto 0);
    in2          : in  std_logic_vector(7 downto 0);
    in3          : in  std_logic_vector(7 downto 0);
    in4          : in  std_logic_vector(7 downto 0);
    in5          : in  std_logic_vector(7 downto 0);
    in6          : in  std_logic_vector(7 downto 0);
    in7          : in  std_logic_vector(7 downto 0);
    result       : out std_logic_vector(7 downto 0)
  );
end entity;

architecture Behavioral of mux8x1_8bit is
begin
  process(opcode_input, in0, in1, in2, in3, in4, in5, in6, in7)
  begin
    case opcode_input is
      when "000" => result <= in0;
      when "001" => result <= in1;
      when "010" => result <= in2;
      when "011" => result <= in3;
      when "100" => result <= in4;
      when "101" => result <= in5;
      when "110" => result <= in6;
      when "111" => result <= in7;
      when others => result <= (others => 'Z');
    end case;
  end process;
end architecture;
