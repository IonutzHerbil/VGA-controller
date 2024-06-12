library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Port (
        clk : in STD_LOGIC;
        btn_in : in STD_LOGIC;
        btn_out : out STD_LOGIC
    );
end debouncer;

architecture Behavioral of debouncer is
    constant DEBOUNCE_TIME : integer := 500000;
    signal counter : integer := 0;
    signal btn_state : STD_LOGIC := '0';
    signal btn_sync_0, btn_sync_1 : STD_LOGIC := '0';
begin
--synchronizint the button input to prevent any noise or boincing
    process(clk)
    begin
        if rising_edge(clk) then
            btn_sync_0 <= btn_in;
            btn_sync_1 <= btn_sync_0;
        end if;
    end process;


    process(clk)
    begin
        if rising_edge(clk) then
            if btn_sync_1 /= btn_state then
                counter <= counter + 1;
                if counter >= DEBOUNCE_TIME then--if the button has been held for enough time =>it s stable
                    counter <= 0;
                    btn_state <= btn_sync_1;
                end if;
            else
                counter <= 0;
            end if;
        end if;
    end process;
--output the debounced button
    btn_out <= btn_state;

end Behavioral;
