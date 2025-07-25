library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Asynchronous_Memory is
    Port (
        address  : in  STD_LOGIC_VECTOR(3 downto 0);
        data_io  : inout STD_LOGIC_VECTOR(7 downto 0);
        read_en  : in  STD_LOGIC;
        write_en : in  STD_LOGIC
    );
end Asynchronous_Memory;

architecture Behavioral of Asynchronous_Memory is

    type memory_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);

    signal unified_memory_block : memory_array := (
        -- Instructions section (addresses 0 to 10):
        0  => x"1B",  -- LDA 1011 ? Load memory(11) into A
        1  => x"3C",  -- ADD 1100 ? A = A + memory(12)
        2  => x"4D",  -- SUB 1101 ? A = A - memory(13)
        3  => x"2B",  -- STA 1011 ? Store A into memory(11)
        4  => x"5E",  -- AND 1110 ? A = A AND memory(14)
        5  => x"6B",  -- OR 1011  ? A = A OR memory(11)
        6  => x"80",  -- INC      ? A = A + 1
        7  => x"C0",  -- SHL      ? Shift A left 1 bit
        8  => x"3F",  -- ADD 1111 ? A = A + memory(15)
        9  => x"B0",  -- OUT      ? Output A to output register
        10 => x"F0",  -- HLT

        -- Data section (addresses 11 to 15):
        11 => x"15",  -- Data at addr 11 (used in LDA, STA, OR)
        12 => x"33",  -- Data at addr 12 (used in ADD)
        13 => x"20",  -- Data at addr 13 (used in SUB)
        14 => x"04",  -- Data at addr 14 (used in AND)
        15 => x"40"   -- Data at addr 15 (used in ADD)
    );

begin

    -- Write process: writes data_io to memory when write_en is '1'
    write_latch_process: process(write_en, address, data_io)
    begin
        if write_en = '1' then
            unified_memory_block(to_integer(unsigned(address))) <= data_io;
        end if;
    end process write_latch_process;

    -- Read logic: outputs memory data on data_io when read_en is '1'
    data_io <= unified_memory_block(to_integer(unsigned(address))) when (read_en = '1') else (others => 'Z');

end Behavioral;
