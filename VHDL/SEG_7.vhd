library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEG_7 is
    port(X : in std_logic_vector(1 downto 0);
        LETTER : out std_logic_vector(6 downto 0)
    );
end SEG_7;

architecture DISPLAY of SEG_7 is

begin
    LETTERS:
    process(X)
    begin
        if (X = "00") then
	    LETTER <= "1000000"; -- dash
        elsif (X = "01") then
            LETTER <= "1110110"; -- H
        else
            LETTER <= "0000000"; -- nothing
        end if;
    end process;
end DISPLAY;

