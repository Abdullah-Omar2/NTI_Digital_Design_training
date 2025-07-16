library ieee;
use ieee.std_logic_1164.all;

entity multiplier_4_bit is
  port (op1, op2 : in  std_logic_vector (3 downto 0);
        res : out std_logic_vector (7 downto 0));
end entity;

architecture behavioral of multiplier_4_bit is
  
  component full_adder_4_bit is
    port (a, b : in  std_logic_vector (3 downto 0);
          c_in : in std_logic;
          s : out std_logic_vector (3 downto 0);
          c_out : out std_logic);
  end component;
  
  signal level0 : std_logic_vector (3 downto 0);
  signal level1 : std_logic_vector (3 downto 0);
  signal level2 : std_logic_vector (3 downto 0);
  signal level3 : std_logic_vector (3 downto 0);
  
  signal fa1_a : std_logic_vector (3 downto 0);
  signal fa1_sum : std_logic_vector (3 downto 0);
  signal fa1_c_out : std_logic;
  
  signal fa2_a : std_logic_vector (3 downto 0);
  signal fa2_sum : std_logic_vector (3 downto 0);
  signal fa2_c_out : std_logic;
  
  signal fa3_a : std_logic_vector (3 downto 0);
  signal fa3_sum : std_logic_vector (3 downto 0);
  signal fa3_c_out : std_logic;
  
begin
  
  level0 <= op1 and (op2(0) & op2(0) & op2(0) & op2(0));
  level1 <= op1 and (op2(1) & op2(1) & op2(1) & op2(1));
  level2 <= op1 and (op2(2) & op2(2) & op2(2) & op2(2));
  level3 <= op1 and (op2(3) & op2(3) & op2(3) & op2(3));
  
  fa1_a <= '0' & level0(3 downto 1);
  
  fa1 : full_adder_4_bit port map (fa1_a, level1, '0', fa1_sum, fa1_c_out);
    
  fa2_a <= fa1_c_out & fa1_sum(3 downto 1);
    
  fa2 : full_adder_4_bit port map (fa2_a, level2, '0', fa2_sum, fa2_c_out);
    
  fa3_a <= fa2_c_out & fa2_sum(3 downto 1);
    
  fa3 : full_adder_4_bit port map (fa3_a, level3, '0', fa3_sum, fa3_c_out);
    
  res <= fa3_c_out & fa3_sum & fa2_sum(0) & fa1_sum(0) & level0(0);

end architecture;