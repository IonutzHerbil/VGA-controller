
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SQUARE is
    Port ( XCUR : in INTEGER;
           YCUR : in INTEGER;
           XPOS : in INTEGER;
           YPOS : in INTEGER;
           DRAW_SQ : OUT STD_LOGIC);
end SQUARE;

architecture Behavioral of SQUARE is

begin
IF Xcur>(Xpos-50) AND Xcur<(Xpos+50) AND Ycur>(Ypos-50) AND Ycur<(Ypos+50) THEN
	 DRAW_SQ<='1';
	 ELSE
	 DRAW_SQ<='0';
 END IF;
 

end Behavioral;
