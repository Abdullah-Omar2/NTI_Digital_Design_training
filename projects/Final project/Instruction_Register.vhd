library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Import the IEEE standard logic library

entity SpecialReg8Bit is
    Port (
        clk      : in  STD_LOGIC;                    -- Clock signal
        rst      : in  STD_LOGIC;                    -- Asynchronous reset signal (active high)
        load     : in  STD_LOGIC;                    -- Load enable signal
        en_out   : in  STD_LOGIC;                    -- Enable output for lower 4 bits
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        data_out : out STD_LOGIC_VECTOR(7 downto 0)  -- 8-bit output data
    );
end SpecialReg8Bit;

architecture Behavioral of SpecialReg8Bit is
    signal reg_data    : STD_LOGIC_VECTOR(7 downto 0); -- Internal register to store input data
    signal output_data : STD_LOGIC_VECTOR(7 downto 0); -- Intermediate signal for output control
begin
    -- Register process: stores input data on rising edge of clock if load is high
    process(clk, rst)
    begin
        if rst = '1' then
            -- Clear the register on reset
            reg_data <= (others => '0');
        elsif rising_edge(clk) then
            -- Load new data on rising edge of clock if load is asserted
            if load = '1' then
                reg_data <= data_in;
            end if;
        end if;
    end process;

    -- Output logic:
    -- Always show the most significant 4 bits (bits 7 to 4)
    output_data(7 downto 4) <= reg_data(7 downto 4);

    -- Conditionally show the least significant 4 bits (bits 3 to 0) if en_out is high,
    -- otherwise set them to high impedance ('Z')
    output_data(3 downto 0) <= reg_data(3 downto 0) when en_out = '1' else (others => 'Z');

    -- Assign final output
    data_out <= output_data;
end Behavioral;
