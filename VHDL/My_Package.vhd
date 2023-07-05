library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 

package MY_WATERING_SYSTEM is
    
    subtype STATE is std_ulogic_vector(1 downto 0);
    constant ST0 : STATE:="00";
    constant ST1 : STATE:="01";
    constant ST2 : STATE:="11";

    component WATERING_SYSTEM is
        port(
            TEMP_IN,LIGHT_IN,CLOCK,RESET : in std_logic;
            MOIS_IN : in std_logic_vector (2 downto 0);
            SEG : out std_logic_vector (6 downto 0);
            FSTATE : out std_logic_vector (1 downto 0);
            MOIS_OUT : out std_logic_vector (2 downto 0);
            TEMP_OUT,LIGHT_OUT : out std_logic);
    end component WATERING_SYSTEM;

    component SEG_7
        port(X : in std_logic_vector(1 downto 0);
            LETTER : out std_logic_vector(6 downto 0)
        );
    end component SEG_7;

end package MY_WATERING_SYSTEM;