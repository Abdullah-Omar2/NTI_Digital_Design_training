library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Import the IEEE standard logic library

entity Reg4Bit is
    Port (
        clk      : in  STD_LOGIC;                  -- Clock signal
        rst      : in  STD_LOGIC;                  -- Asynchronous reset signal (active high)
        load     : in  STD_LOGIC;                  -- Load enable signal
        data_in  : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit input data
        data_out : out STD_LOGIC_VECTOR(3 downto 0)  -- 4-bit output data
    );
end Reg4Bit;

architecture Behavioral of Reg4Bit is
    signal reg_data : STD_LOGIC_VECTOR(3 downto 0); -- Internal 4-bit register to store data
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- If reset is active, clear the register
            reg_data <= (others => '0');
        elsif rising_edge(clk) then
            -- On rising edge of clock
            if load = '1' then
                -- If load is high, store input data into the register
                reg_data <= data_in;
            end if;
        end if;
    end process;

    -- Assign the internal register value to the output
    data_out <= reg_data;
end Behavioral;
