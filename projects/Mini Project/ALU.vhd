library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (op1, op2 : in  std_logic_vector (3 downto 0);
        opcode : in std_logic_vector (2 downto 0);
        res : out std_logic_vector (7 downto 0));
end entity;

architecture behavioral of alu is
  
  component adder_subtractor_4bit
    port (
      operand1 : in  std_logic_vector(3 downto 0);
      operand2 : in  std_logic_vector(3 downto 0);
      mode     : in  std_logic;
      result   : out std_logic_vector(3 downto 0);
      cout     : out std_logic
    );
  end component;
  
  component multiplier_4_bit is
    port (op1, op2 : in  std_logic_vector (3 downto 0);
          res : out std_logic_vector (7 downto 0));
  end component;
  
  component greater_than is
    port (op1, op2 : in  std_logic_vector (3 downto 0);
          res : out std_logic);
  end component;
  
  component smaller_than is
    port (op1, op2 : in  std_logic_vector (3 downto 0);
          res : out std_logic);
  end component;
  
  component mux8x1_8bit is
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
  end component;
  
  signal adder_subtractor_result : std_logic_vector(3 downto 0);
  signal adder_subtractor_cout : std_logic;
  
  signal multiplier_result : std_logic_vector(7 downto 0);
  
  signal greater_result : std_logic;
  
  signal smaller_result : std_logic;
  
  signal mux_in_000 : std_logic_vector(7 downto 0);
  signal mux_in_001 : std_logic_vector(7 downto 0);
  signal mux_in_011 : std_logic_vector(7 downto 0);
  signal mux_in_100 : std_logic_vector(7 downto 0);
  signal mux_in_101 : std_logic_vector(7 downto 0);
  
begin
  
  mux_in_000 <= "000" & adder_subtractor_cout & adder_subtractor_result;
  
  mux_in_001 <= not adder_subtractor_cout & not adder_subtractor_cout 
                & not adder_subtractor_cout & not adder_subtractor_cout & adder_subtractor_result;
  
  mux_in_011 <= "0000000" & greater_result;
  
  mux_in_100 <= "0000000" & smaller_result;
  
  mux_in_101 <= "00000000";
  
  adder_sub : adder_subtractor_4bit port map (op1, op2, opcode(0), adder_subtractor_result, adder_subtractor_cout);
    
  multiplier : multiplier_4_bit port map (op1, op2, multiplier_result);
    
  greater : greater_than port map (op1, op2, greater_result);
    
  smaller : smaller_than port map (op1, op2, smaller_result);
    
  mux : mux8x1_8bit port map (opcode, mux_in_000, mux_in_001, multiplier_result, mux_in_011,
                              mux_in_100, mux_in_101, mux_in_101, mux_in_101, res);

end architecture;
