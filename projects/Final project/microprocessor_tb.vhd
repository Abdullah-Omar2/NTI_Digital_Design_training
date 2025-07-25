library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_microprocessor is
end tb_microprocessor;

architecture Behavioral of tb_microprocessor is

    -- Component Under Test
    component microprocessor
        Port (
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals
    signal clk_tb    : STD_LOGIC := '0';
    signal rst_tb    : STD_LOGIC := '1';
    signal output_tb : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the microprocessor
    uut: microprocessor
        port map (
            clk    => clk_tb,
            rst    => rst_tb,
            output => output_tb
        );

    -- Clock generation
    clk_process : process
    begin
        while now < 2 ms loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Reset process
    rst_process : process
    begin
        wait for 50 ns;
        rst_tb <= '0';
        wait;
    end process;

    -- Monitor output
    monitor_proc : process(clk_tb)
    begin
        if rising_edge(clk_tb) then
            report "Output at " & time'image(now) & " = " & integer'image(to_integer(unsigned(output_tb)));
        end if;
    end process;

end Behavioral;

