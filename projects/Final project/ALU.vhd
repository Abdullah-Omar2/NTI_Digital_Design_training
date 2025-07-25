library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        en       : in  STD_LOGIC;                     -- ALU enable (active high)
        selector : in  STD_LOGIC_VECTOR(3 downto 0);  -- Operation selector
        A        : in  STD_LOGIC_VECTOR(7 downto 0);  -- Accumulator input
        B        : in  STD_LOGIC_VECTOR(7 downto 0);  -- Data input (for binary operations)
        result   : out STD_LOGIC_VECTOR(7 downto 0)   -- ALU output
    );
end ALU;

architecture Behavioral of ALU is

  signal temp_result : STD_LOGIC_VECTOR(7 downto 0);

begin
    process(selector, A, B)
    begin
      case selector is

        -- ADD (0011): Add B to A
        when "0011" =>
          temp_result <= std_logic_vector(unsigned(A) + unsigned(B));

        -- SUB (0100): Subtract B from A
        when "0100" =>
          temp_result <= std_logic_vector(unsigned(A) - unsigned(B));

        -- AND (0101): Bitwise AND between A and B
        when "0101" =>
          temp_result <= (A and B);

        -- OR (0110): Bitwise OR between A and B
        when "0110" =>
          temp_result <= (A or B);

        -- NOT (0111): Bitwise NOT of A
        when "0111" =>
          temp_result <= (not A);

        -- INC (1000): Increment A by 1
        when "1000" =>
          temp_result <= std_logic_vector(unsigned(A) + 1);

        -- DEC (1001): Decrement A by 1
        when "1001" =>
          temp_result <= std_logic_vector(unsigned(A) - 1);

        -- SHL (1100): Shift A left by 1 (logical)
        when "1100" =>
          temp_result <= A(6 downto 0) & '0';  -- LSB = 0

        -- SHR (1101): Shift A right by 1 (logical)
        when "1101" =>
          temp_result <= '0' & A(7 downto 1);  -- MSB = 0

        -- NEG (1110): Two?s complement of A (i.e., -A)
        when "1110" =>
          temp_result <= std_logic_vector(-signed(A));

        -- Default case: Pass A directly
        when others =>
          temp_result <= A;

      end case;
    end process;

    -- Output result if enabled, else set high impedance
    result <= temp_result when en = '1' else (others => 'Z');

end Behavioral;
