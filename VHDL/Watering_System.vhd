library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WATERING_SYSTEM is
    port(TEMP_IN,LIGHT_IN,CLOCK,RESET : in std_logic;
        MOIS_IN : in std_logic_vector (2 downto 0);
        SEG : out std_logic_vector (6 downto 0);
        FSTATE : out std_logic_vector (1 downto 0);
        MOIS_OUT : out std_logic_vector (2 downto 0);
        TEMP_OUT,LIGHT_OUT : out std_logic);
end WATERING_SYSTEM;

architecture FSM of WATERING_SYSTEM is

    component SEG_7
        port(X : in std_logic_vector(1 downto 0);
            LETTER : out std_logic_vector(6 downto 0)
        );
    end component;

    subtype STATE is std_ulogic_vector(1 downto 0);
    constant ST0 : STATE:="00";
    constant ST1 : STATE:="01";
    constant ST2 : STATE:="11";
    signal CURR_STATE,NEXT_STATE : STATE;
    signal X : std_logic_vector (1 downto 0);
begin

    DisplayLetter: 
	SEG_7 port map(X,SEG);

    CLK_RESET:
    process(CLOCK,RESET)
    begin
       	if (RESET = '1') then CURR_STATE <= ST0;
       	elsif (rising_edge(CLOCK)) then CURR_STATE <= NEXT_STATE;
       	end if;
    end process CLK_RESET;
    
    MOIS_OUT <= MOIS_IN; 
    TEMP_OUT <= TEMP_IN; 
    LIGHT_OUT <= LIGHT_IN;

    COMBINATION:
    process(CURR_STATE,TEMP_IN,LIGHT_IN,MOIS_IN)
    begin
        case CURR_STATE is
            when ST0 =>
                if (TEMP_IN = '1' or LIGHT_IN = '1') and (MOIS_IN <= "001") then NEXT_STATE <= ST1;
                elsif (TEMP_IN = '0' and LIGHT_IN = '0') and (MOIS_IN <= "011") then NEXT_STATE <= ST1;
                else NEXT_STATE <= ST0; 
                end if;
            when ST1 => 
                if (MOIS_IN >= "111") then NEXT_STATE <= ST0; 
                elsif (MOIS_IN >= "011") and (TEMP_IN = '1' or LIGHT_IN = '1') then NEXT_STATE <= ST0; 
                else NEXT_STATE <= ST1;
                end if;
            when others =>
            	NEXT_STATE <= ST0; 
        end case;
    end process COMBINATION;

    OUTPUTPROCESS:
    process(CURR_STATE)
    begin
        case CURR_STATE is
            when ST0 => FSTATE <= "00"; X <= "00";
            when ST1 => FSTATE <= "01"; X <= "01";
            when others => FSTATE <= "11"; X <= "11";
        end case;
    end process;

end FSM;
