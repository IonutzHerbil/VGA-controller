library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity main is
    PORT(
        CLOCK100: IN STD_LOGIC;
        RED, GREEN, BLUE: IN STD_LOGIC;
        VGA_HS, VGA_VS: OUT STD_LOGIC;
        VGA_R, VGA_G, VGA_B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        UP, DOWN, LEFT, RIGHT: IN std_logic;
        RESTART,SPEED: IN std_logic;
        SHAPE: IN std_logic_vector(2 DOWNTO 0)
    );
end main;

architecture Behavioral of main is

    SIGNAL VGA_CLK, RESET: std_logic := '0';
    SIGNAL debounced_UP, debounced_DOWN, debounced_LEFT, debounced_RIGHT, debounced_RESTART: std_logic;

    COMPONENT freq_vider is
        Port ( reset : in STD_LOGIC;
               clk100 : in STD_LOGIC;
               clk25 : out STD_LOGIC);
    end COMPONENT;

    COMPONENT SYNC is
        PORT(
            CLK: IN std_logic;
            HSYNC, VSYNC: OUT std_logic;
            R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            UP, DOWN, LEFT, RIGHT: IN std_logic;
            RESTART: IN std_logic;
            RSEL, GSEL, BSEL: IN std_logic;     
            SH_SEL: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            SPEED:IN STD_LOGIC
        );
    end COMPONENT;

    COMPONENT debouncer is
        Port (
            clk : in STD_LOGIC;
            btn_in : in STD_LOGIC;
            btn_out : out STD_LOGIC
        );
    end COMPONENT;

begin

    C1: SYNC PORT MAP(
        CLK => VGA_CLK,
        HSYNC => VGA_HS,
        VSYNC => VGA_VS,
        R => VGA_R,
        G => VGA_G,
        B => VGA_B,
        UP => debounced_UP,
        DOWN => debounced_DOWN,
        LEFT => debounced_LEFT,
        RIGHT => debounced_RIGHT,
        RESTART => debounced_RESTART,
        RSEL => RED,
        GSEL => GREEN,
        BSEL => BLUE,
        SH_SEL => SHAPE,
        SPEED=>SPEED
    );

    C2: freq_vider PORT MAP(
        reset => RESET,
        clk100 => CLOCK100,
        clk25 => VGA_CLK
    );

    D1: debouncer PORT MAP(clk => VGA_CLK, btn_in => UP, btn_out => debounced_UP);
    D2: debouncer PORT MAP(clk => VGA_CLK, btn_in => DOWN, btn_out => debounced_DOWN);
    D3: debouncer PORT MAP(clk => VGA_CLK, btn_in => LEFT, btn_out => debounced_LEFT);
    D4: debouncer PORT MAP(clk => VGA_CLK, btn_in => RIGHT, btn_out => debounced_RIGHT);
    D5: debouncer PORT MAP(clk => VGA_CLK, btn_in => RESTART, btn_out => debounced_RESTART);

end Behavioral;
