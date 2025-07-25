library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
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
end control_unit;

architecture behavioral of control_unit is

    type state_type is (FETCH1, FETCH2, DECODE, EXECUTE1, EXECUTE2, HLT);
    signal state, next_state : state_type;

begin

    -- Clocked process: handles state transition
    process(clk, rst)
    begin
        if rst = '1' then
            state <= FETCH1;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Control signal generation based on current state
    process(state, opcode)
    begin
        -- Default values (to avoid latches)
        pc_inc       <= '0';
        pc_out       <= '0';
        mar_load     <= '0';
        mem_read     <= '0';
        mem_write    <= '0';
        ir_load      <= '0';
        ir_out       <= '0';
        a_load       <= '0';
        a_out        <= '0';
        b_load       <= '0';
        alu_sel      <= (others => '0');
        alu_out      <= '0';
        outreg_load  <= '0';

        case state is

            -- FETCH PHASE --
            when FETCH1 =>
                pc_out <= '1';       -- Output PC to address bus
                mar_load <= '1';     -- Load MAR with PC
                next_state <= FETCH2;

            when FETCH2 =>
                mem_read <= '1';     -- Read instruction from memory
                ir_load  <= '1';     -- Load IR with instruction
                pc_inc   <= '1';     -- Increment PC
                next_state <= DECODE;

            -- DECODE PHASE --
            when DECODE =>
                case opcode is
                    when "0000" =>      -- NOP
                        next_state <= FETCH1;

                    when "0001" |       -- LDA
                         "0010" |       -- STA
                         "0011" |       -- ADD
                         "0100" |       -- SUB
                         "0101" |       -- AND
                         "0110" =>      -- OR
                        ir_out    <= '1';
                        mar_load  <= '1';   -- Use address from IR
                        next_state <= EXECUTE1;

                    when "1111" =>      -- HLT (modified from SWP)
                        next_state <= HLT;

                    when others =>      -- All other instructions go to EXECUTE1 directly
                        next_state <= EXECUTE1;
                end case;

            -- EXECUTE PHASE (Single-cycle or first part of multi-cycle) --
            when EXECUTE1 =>
                case opcode is
                    -- Memory instructions with address
                    when "0001" =>      -- LDA addr
                        mem_read <= '1';
                        a_load   <= '1';
                        next_state <= FETCH1;

                    when "0010" =>      -- STA addr
                        a_out    <= '1';
                        mem_write <= '1';
                        next_state <= FETCH1;

                    when "0011" | "0100" | "0101" | "0110" => -- ADD, SUB, AND, OR (2-cycle ops)
                        mem_read <= '1';
                        b_load   <= '1';
                        next_state <= EXECUTE2;

                    -- ALU single-cycle operations (no memory access)
                    when "0111" =>      -- NOT
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1000" =>      -- INC
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1001" =>      -- DEC
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1010" =>      -- CLR
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1100" =>      -- SHL
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1101" =>      -- SHR
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1110" =>      -- NEG
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when "1011" =>      -- OUT instruction
                        a_out        <= '1';
                        outreg_load  <= '1';
                        next_state   <= FETCH1;

                    when others =>
                        next_state <= FETCH1;
                end case;

            -- EXECUTE2: for operations needing two cycles (like ADD/SUB/AND/OR)
            when EXECUTE2 =>
                case opcode is
                    when "0011" | "0100" | "0101" | "0110" =>
                        alu_sel <= opcode;
                        alu_out <= '1';
                        a_load  <= '1';
                        next_state <= FETCH1;

                    when others =>
                        next_state <= FETCH1;
                end case;

            -- HALT STATE --
            when HLT =>
                next_state <= HLT;  -- Stays in HLT forever (stop)
        end case;
    end process;

end behavioral;
