library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end;

architecture behavior of control_unit_tb is

    component control_unit is
        port (
            clk          : in  std_logic;
            rst          : in  std_logic;
            opcode       : in  std_logic_vector(3 downto 0);

            pc_inc       : out std_logic;
            pc_out       : out std_logic;
            mar_load     : out std_logic;
            mem_read     : out std_logic;
            mem_write    : out std_logic;
            ir_load      : out std_logic;
            ir_out       : out std_logic;
            a_load       : out std_logic;
            a_out        : out std_logic;
            b_load       : out std_logic;
            alu_sel      : out std_logic_vector(3 downto 0);
            alu_out      : out std_logic;
            outreg_load  : out std_logic
        );
    end component;

    -- Signals
    signal clk         : std_logic := '0';
    signal rst         : std_logic := '0';
    signal opcode      : std_logic_vector(3 downto 0);

    signal pc_inc      : std_logic;
    signal pc_out      : std_logic;
    signal mar_load    : std_logic;
    signal mem_read    : std_logic;
    signal mem_write   : std_logic;
    signal ir_load     : std_logic;
    signal ir_out      : std_logic;
    signal a_load      : std_logic;
    signal a_out       : std_logic;
    signal b_load      : std_logic;
    signal alu_sel     : std_logic_vector(3 downto 0);
    signal alu_out     : std_logic;
    signal outreg_load : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the control unit
    uut: control_unit
        port map (
            clk          => clk,
            rst          => rst,
            opcode       => opcode,
            pc_inc       => pc_inc,
            pc_out       => pc_out,
            mar_load     => mar_load,
            mem_read     => mem_read,
            mem_write    => mem_write,
            ir_load      => ir_load,
            ir_out       => ir_out,
            a_load       => a_load,
            a_out        => a_out,
            b_load       => b_load,
            alu_sel      => alu_sel,
            alu_out      => alu_out,
            outreg_load  => outreg_load
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Test process
    stim_proc : process
        procedure reset_unit is
        begin
            rst <= '1';
            wait for clk_period;
            rst <= '0';
            wait for clk_period;
        end procedure;

        procedure test_opcode(op : std_logic_vector(3 downto 0)) is
        begin
            opcode <= op;
            wait for 5 * clk_period; -- Allow state transitions
        end procedure;

    begin
        wait for 20 ns;
        reset_unit;

        -- Test all opcodes one by one
        test_opcode("0000"); -- NOP
        test_opcode("0001"); -- LDA addr
        test_opcode("0010"); -- STA addr
        test_opcode("0011"); -- ADD
        test_opcode("0100"); -- SUB
        test_opcode("0101"); -- AND
        test_opcode("0110"); -- OR
        test_opcode("0111"); -- NOT
        test_opcode("1000"); -- INC
        test_opcode("1011"); -- OUT
        test_opcode("1111"); -- HLT
        test_opcode("1001"); 
        test_opcode("1100"); 
        test_opcode("1110"); 

        wait;
    end process;

end;

