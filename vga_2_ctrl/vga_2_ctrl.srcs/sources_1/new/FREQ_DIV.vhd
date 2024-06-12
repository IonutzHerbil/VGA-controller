library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_vider is
    Port ( reset : in STD_LOGIC;
           clk100 : in STD_LOGIC;
           clk25 : out STD_LOGIC);
end freq_vider;

architecture Behavioral of freq_vider is
signal b:std_logic:='0';
begin

    process(clk100, reset)
        variable count : integer := 0;
    begin
        if reset = '1' then--if reset=1, restart the counter
            count := 0;
            b <= '0';
        elsif rising_edge(clk100) then
            count := count + 1;
            if count = 2 then 
                b <= not b;
                count := 0;  
            end if;
        end if;
    end process;
    clk25<=b;--assign the clock,the output signal
end Behavioral;
