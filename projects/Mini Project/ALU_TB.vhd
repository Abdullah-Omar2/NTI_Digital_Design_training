library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture behavioral of alu_tb is

  -- Component declaration
  component alu is
    port (op1, op2 : in  std_logic_vector (3 downto 0);
          opcode : in std_logic_vector (2 downto 0);
          res : out std_logic_vector (7 downto 0));
  end component;

  -- Test signals
  signal op1 : std_logic_vector(3 downto 0);
  signal op2 : std_logic_vector(3 downto 0);
  signal opcode : std_logic_vector(2 downto 0):= (others => '1');
  signal res : std_logic_vector(7 downto 0);

begin

  -- Instantiate the design under test (DUT)
  DUT: alu
    port map (
      op1 => op1,
      op2 => op2,
      opcode => opcode,
      res   => res
    );

  -- Stimulus process
  stim_proc: process
  begin

    op1 <= "1010";
    op2 <= "0101";

    for i in 0 to 7 loop
      opcode <= std_logic_vector(unsigned (opcode) + 1);
      wait for 10 ns;
    end loop;
    
    op1 <= "0110";
    op2 <= "1100";

    for i in 0 to 7 loop
      opcode <= std_logic_vector(unsigned (opcode) + 1);
      wait for 10 ns;
    end loop;
    
    op1 <= "0111";
    op2 <= "0111";

    for i in 0 to 7 loop
      opcode <= std_logic_vector(unsigned (opcode) + 1);
      wait for 10 ns;
    end loop;
    
    op1 <= "1111";
    op2 <= "1111";

    for i in 0 to 7 loop
      opcode <= std_logic_vector(unsigned (opcode) + 1);
      wait for 10 ns;
    end loop;
    
  end process;

end architecture;






