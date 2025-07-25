library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Simple_Async_Memory is
end tb_Simple_Async_Memory;

architecture Behavioral of tb_Simple_Async_Memory is

    -- Component Declaration for the asynchronous DUT
    component Asynchronous_Memory is
        Port ( 
            address  : in  STD_LOGIC_VECTOR(3 downto 0);
            data_io  : inout STD_LOGIC_VECTOR(7 downto 0);
            read_en  : in  STD_LOGIC;
            write_en : in  STD_LOGIC
        );
    end component;

    -- Testbench Signals
    signal tb_address  : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_data_io  : STD_LOGIC_VECTOR(7 downto 0);
    signal tb_read_en  : STD_LOGIC;
    signal tb_write_en : STD_LOGIC;

    -- Define a delay for timing control
    constant DELAY : time := 10 ns;

begin

    -- Instantiate the Device Under Test (DUT)
    DUT: Asynchronous_Memory
        port map (
            address  => tb_address,
            data_io  => tb_data_io,
            read_en  => tb_read_en,
            write_en => tb_write_en
        );

    -- Stimulus Process (Main Test Sequence)
    stimulus_process: process
    begin
        report "Starting Simple Memory Testbench...";
        
        -- Initialize all control signals to inactive
        tb_write_en <= '0';
        tb_read_en  <= '0';
        tb_address  <= (others => '0');
        tb_data_io  <= (others => 'Z'); -- Release the bus
        wait for DELAY;

        -- ===============================================================
        -- 1. WRITE a single value to the first address (address 0)
        -- ===============================================================
        report "Step 1: Writing x""A5"" to address 0...";
        
        tb_address <= "0000";
        tb_data_io <= x"A5";
        
        tb_write_en <= '1';
        wait for DELAY;
        tb_write_en <= '0';
        
        tb_data_io <= (others => 'Z');
        wait for DELAY;

        -- ===============================================================
        -- 2. READ the value back from the first address (address 0)
        -- ===============================================================
        report "Step 2: Reading from address 0...";
        
        tb_address <= "0000";
        tb_read_en <= '1';
        wait for DELAY;
        
        -- Verify the data
        assert tb_data_io = x"A5"
            -- FIXED: Replaced to_hstring with a compatible function
            report "VERIFICATION FAILED: Expected x""A5"" at address 0, but got " & integer'image(to_integer(unsigned(tb_data_io)))
            severity error;
        report "VERIFICATION PASSED: Correctly read x""A5"" from address 0.";
        
        tb_read_en <= '0';
        wait for DELAY;

        -- ===============================================================
        -- 3. READ from an empty address (address 10)
        -- ===============================================================
        report "Step 3: Reading from empty address 10 (1010)...";
        
        tb_address <= "1010";
        tb_read_en <= '1';
        wait for DELAY;
        
        -- Verify the data is the default (zero)
        assert tb_data_io = x"00"
            -- FIXED: Replaced to_hstring with a compatible function
            report "VERIFICATION FAILED: Expected x""00"" at address 10, but got " & integer'image(to_integer(unsigned(tb_data_io)))
            severity error;
        report "VERIFICATION PASSED: Correctly read x""00"" from empty address 10.";

        tb_read_en <= '0';
        wait for DELAY;
        
        -- ===============================================================
        -- 4. READ from another empty address (address 5)
        -- ===============================================================
        report "Step 4: Reading from empty address 5 (0101)...";
        
        tb_address <= "0101";
        tb_read_en <= '1';
        wait for DELAY;
        
        -- Verify the data is the default (zero)
        assert tb_data_io = x"00"
            -- FIXED: Replaced to_hstring with a compatible function
            report "VERIFICATION FAILED: Expected x""00"" at address 5, but got " & integer'image(to_integer(unsigned(tb_data_io)))
            severity error;
        report "VERIFICATION PASSED: Correctly read x""00"" from empty address 5.";
        
        tb_read_en <= '0';
        wait for DELAY;
        
        -- ===============================================================
        -- 5. WRITE to all 16 memory locations
        -- ===============================================================
        report "Step 5: Writing a unique value to all 16 locations...";
        
        for i in 0 to 15 loop
            tb_address <= std_logic_vector(to_unsigned(i, 4));
            -- Write a value like (i + 50) to make it unique
            tb_data_io <= std_logic_vector(to_unsigned(i + 50, 8));
            
            -- Create a write pulse
            tb_write_en <= '1';
            wait for DELAY;
            tb_write_en <= '0';
            wait for DELAY;
        end loop;
        
        tb_data_io <= (others => 'Z');
        wait for DELAY;

        -- ===============================================================
        -- 6. READ from all 16 locations and verify
        -- ===============================================================
        report "Step 6: Reading all 16 locations to verify...";
        
        tb_read_en <= '1';
        
        for i in 0 to 15 loop
            tb_address <= std_logic_vector(to_unsigned(i, 4));
            wait for DELAY;
            
            -- Note that address 0 was overwritten, so we expect the new value
            assert tb_data_io = std_logic_vector(to_unsigned(i + 50, 8))
                report "VERIFICATION FAILED at address " & integer'image(i) &
                       ". Expected " & integer'image(i+50) & 
                       ", but got " & integer'image(to_integer(unsigned(tb_data_io)))
                severity error;
        end loop;
        
        report "VERIFICATION PASSED: All 16 locations read back correctly.";

        -- End of test
        report "Testbench finished successfully." severity note;
        wait;

    end process;

end Behavioral;

