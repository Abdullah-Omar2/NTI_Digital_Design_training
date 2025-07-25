library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity microprocessor is
    Port (
        clk, rst : in STD_LOGIC;
        output   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end microprocessor;

architecture Behavioral of microprocessor is

    -- === COMPONENT DECLARATIONS === --

    -- Arithmetic Logic Unit (ALU)
    component ALU is
        Port (
            en       : in  STD_LOGIC;
            selector : in  STD_LOGIC_VECTOR(3 downto 0);
            A        : in  STD_LOGIC_VECTOR(7 downto 0);
            B        : in  STD_LOGIC_VECTOR(7 downto 0);
            result   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Unified Instruction & Data Memory
    component Asynchronous_Memory is
        Port (
            address  : in  STD_LOGIC_VECTOR(3 downto 0);
            data_io  : inout STD_LOGIC_VECTOR(7 downto 0);
            read_en  : in  STD_LOGIC;
            write_en : in  STD_LOGIC
        );
    end component;

    -- Control Unit (Finite State Machine)
    component control_unit is
        port (
            clk           : in  std_logic;
            rst           : in  std_logic;
            opcode        : in  std_logic_vector(3 downto 0);
            pc_inc        : out std_logic;
            pc_out        : out std_logic;
            mar_load      : out std_logic;
            mem_read      : out std_logic;
            mem_write     : out std_logic;
            ir_load       : out std_logic;
            ir_out        : out std_logic;
            a_load        : out std_logic;
            a_out         : out std_logic;
            b_load        : out std_logic;
            alu_sel       : out std_logic_vector(3 downto 0);
            alu_out       : out std_logic;
            outreg_load   : out std_logic
        );
    end component;

    -- Special IR Register (outputs MSBs always, LSBs conditional)
    component SpecialReg8Bit is
        Port (
            clk, rst, load, en_out : in STD_LOGIC;
            data_in  : in STD_LOGIC_VECTOR(7 downto 0);
            data_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Program Counter (PC) with increment and output enable
    component pc_reg is
        Port (
            clk, rst, inc, en_out : in STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- 4-bit Register (MAR)
    component Reg4Bit is
        Port (
            clk, rst, load : in STD_LOGIC;
            data_in  : in STD_LOGIC_VECTOR(3 downto 0);
            data_out : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- 8-bit General Purpose Register (A or B or Output Register)
    component Reg8Bit is
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            load    : in  STD_LOGIC;
            data_in : in  STD_LOGIC_VECTOR(7 downto 0);
            data_out: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Tristate Buffer for writing A_reg to the bus
    component tristate_buffer is
        port (
            enable : in  std_logic;
            input  : in  std_logic_vector(7 downto 0);
            output : out std_logic_vector(7 downto 0)
        );
    end component;

    -- === INTERNAL SIGNALS === --

    -- Control Unit Signals
    signal opcode        : std_logic_vector(3 downto 0);
    signal pc_inc        : std_logic;
    signal pc_out        : std_logic;
    signal mar_load      : std_logic;
    signal mem_read      : std_logic;
    signal mem_write     : std_logic;
    signal ir_load       : std_logic;
    signal ir_out        : std_logic;
    signal a_load        : std_logic;
    signal a_out         : std_logic;
    signal b_load        : std_logic;
    signal alu_sel       : std_logic_vector(3 downto 0);
    signal alu_out       : std_logic;
    signal outreg_load   : std_logic;

    -- Shared 8-bit Data Bus
    signal bus_8bit      : STD_LOGIC_VECTOR(7 downto 0);

    -- Interconnects
    signal mar_to_addr   : STD_LOGIC_VECTOR(3 downto 0);
    signal ir_output     : STD_LOGIC_VECTOR(7 downto 0);
    signal a_output      : STD_LOGIC_VECTOR(7 downto 0);
    signal b_output      : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- === MODULE INSTANTIATIONS === --

    -- Program Counter
    pc : pc_reg port map (
        clk, rst,
        pc_inc, pc_out,
        bus_8bit(3 downto 0)  -- Lower 4 bits only
    );

    -- Memory Address Register (MAR)
    mar : Reg4Bit port map (
        clk, rst,
        mar_load,
        bus_8bit(3 downto 0), -- Address from bus
        mar_to_addr
    );

    -- Unified Memory (Instruction + Data)
    memory : Asynchronous_Memory port map (
        mar_to_addr,   -- Address input
        bus_8bit,      -- Bidirectional data bus
        mem_read,
        mem_write
    );

    -- Instruction Register
    ir : SpecialReg8Bit port map (
        clk, rst,
        ir_load, ir_out,
        bus_8bit,
        ir_output
    );

    -- Connect Instruction Register Output
    bus_8bit(3 downto 0) <= ir_output(3 downto 0); -- Address part
    opcode <= ir_output(7 downto 4);               -- Opcode part

    -- Control Unit
    cu : control_unit port map (
        clk, rst, opcode,
        pc_inc, pc_out, mar_load,
        mem_read, mem_write,
        ir_load, ir_out,
        a_load, a_out, b_load,
        alu_sel, alu_out,
        outreg_load
    );

    -- Accumulator Register (A)
    a_reg : Reg8Bit port map (
        clk, rst,
        a_load,
        bus_8bit,
        a_output
    );

    -- Tristate Buffer to enable A register to bus
    tristate : tristate_buffer port map (
        a_out,     -- Enable
        a_output,  -- Data from A
        bus_8bit   -- Output to bus
    );

    -- B Register (for 2-operand ALU operations)
    b_reg : Reg8Bit port map (
        clk, rst,
        b_load,
        bus_8bit,
        b_output
    );

    -- ALU Block
    alu_block : ALU port map (
        alu_out,
        alu_sel,
        a_output,
        b_output,
        bus_8bit
    );

    -- Output Register (connected to external output port)
    out_reg : Reg8Bit port map (
        clk, rst,
        outreg_load,
        bus_8bit,
        output
    );

end Behavioral;
