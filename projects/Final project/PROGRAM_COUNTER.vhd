library IEEE;
use IEEE.STD_LOGIC_1164.ALL;      -- Import standard logic types
use IEEE.NUMERIC_STD.ALL;         -- Import numeric operations for unsigned arithmetic

entity pc_reg is
    Port (
        clk      : in  STD_LOGIC;                    -- Clock signal
        rst      : in  STD_LOGIC;                    -- Asynchronous reset signal (active high)
        inc      : in  STD_LOGIC;                    -- Increment enable signal
        en_out   : in  STD_LOGIC;                    -- Output enable signal
        data_out : out STD_LOGIC_VECTOR(3 downto 0)  -- 4-bit output from the register
    );
end pc_reg;

architecture Behavioral of pc_reg is
    signal reg_data : STD_LOGIC_VECTOR(3 downto 0);  -- Internal 4-bit register to hold current PC value
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- If reset is active, clear the register
            reg_data <= (others => '0');
        elsif rising_edge(clk) then
            -- On rising edge of the clock
            if inc = '1' then
                -- If increment signal is high, increment the register value by 1
                reg_data <= std_logic_vector(unsigned(reg_data) + 1);
            end if;
        end if;
    end process;

    -- Output the register value if en_out is '1', otherwise high impedance
    data_out <= reg_data when en_out = '1' else (others => 'Z');
end Behavioral;
