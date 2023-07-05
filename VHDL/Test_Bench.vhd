library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity WS_TEST_BENCH is
end;

architecture MY_BENCH of WS_TEST_BENCH is

    component WATERING_SYSTEM
        port(TEMP_IN,LIGHT_IN,CLOCK,RESET : in std_logic;
            MOIS_IN : in std_logic_vector (2 downto 0);
            SEG : out std_logic_vector (6 downto 0);
            FSTATE : out std_logic_vector (1 downto 0);
            MOIS_OUT : out std_logic_vector (2 downto 0);
            TEMP_OUT,LIGHT_OUT : out std_logic);
    end component WATERING_SYSTEM;

    signal TEMP_IN,LIGHT_IN,CLOCK,RESET: std_logic;
    signal MOIS_IN: std_logic_vector (2 downto 0);
    signal SEG: std_logic_vector (6 downto 0);
    signal FSTATE: std_logic_vector (1 downto 0);
    signal MOIS_OUT: std_logic_vector (2 downto 0);
    signal TEMP_OUT,LIGHT_OUT: std_logic;

    constant CP: time := 100 ns;
    signal STOP: boolean;

begin

    PORTING:
    WATERING_SYSTEM port map ( TEMP_IN   => TEMP_IN,
        LIGHT_IN  => LIGHT_IN,
        CLOCK     => CLOCK,
        RESET     => RESET,
        MOIS_IN   => MOIS_IN,
        SEG       => SEG,
        FSTATE    => FSTATE,
        MOIS_OUT  => MOIS_OUT,
        TEMP_OUT  => TEMP_OUT,
        LIGHT_OUT => LIGHT_OUT );

    EXAMPLE:
    process
    begin
        TEMP_IN <= '0';
        LIGHT_IN <= '0';
        MOIS_IN <= "110";
        wait for CP;
        
        TEMP_IN <= '1';
        LIGHT_IN <= '1';
        MOIS_IN <= "001";
        wait for CP;
        
        TEMP_IN <= '0';
        LIGHT_IN <= '0';
        MOIS_IN <= "101";
        wait for CP;
        
        TEMP_IN <= '0';
        LIGHT_IN <= '0';
        MOIS_IN <= "011";
        wait for CP;
        
        TEMP_IN <= '0';
        LIGHT_IN <= '0';
        MOIS_IN <= "111";
        wait for CP;
        
        TEMP_IN <= '1';
        LIGHT_IN <= '1';
        MOIS_IN <= "010";
        wait for CP;
        
        TEMP_IN <= '1';
        LIGHT_IN <= '1';
        MOIS_IN <= "011";
        wait for CP;
        
        TEMP_IN <= '1';
        LIGHT_IN <= '1';
        MOIS_IN <= "010";
        wait for CP;


    STOP <= true;
    wait;
    end process EXAMPLE;

    CLOCKING:
    process
    begin
        while not STOP loop
            CLOCK <= '0', '1' after CP / 2;
            wait for CP;
        end loop;
        wait;
    end process CLOCKING;

end;