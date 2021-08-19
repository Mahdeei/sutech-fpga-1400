library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity main is
     port(
         HIN1: in std_logic_vector(1 downto 0);
         HIN0, MIN1, MIN0: in std_logic_vector(3 downto 0);
         CLK, RESET: in std_logic;
         HOUT1, HOUT0, MOUT1, MOUT0, SOUT1, SOUT0: out std_logic_vector(7 downto 0)
         ); 
         
         
function BCD_TO_7SEG( 
    BCD: std_logic_vector ( 3 downto 0 ) := b"0000" )
    return std_logic_vector is
        variable RESULT: std_logic_vector(7 downto 0);
        
    begin
        case BCD is
            when b"0000" =>        -- 0
                RESULT:= b"00000001";
            when b"0001" =>        -- 1
                RESULT:= b"01001111";
            when b"0010" =>        -- 2
                RESULT:= b"00010010";
            when b"0011" =>        -- 3
                RESULT:= b"00000110";
            when b"0100" =>        -- 4
                RESULT:= b"01001100";
            when b"0101" =>        -- 5
                RESULT:= b"00100100";
            when b"0110" =>        -- 6
                RESULT:= b"00100000";
            when b"0111" =>        -- 7
                RESULT:= b"00001111";
            when b"1000" =>        -- 8
                RESULT:= b"00000000";
            when b"1001" =>        -- 9
                RESULT:= b"00000100";
            when others =>        
                RESULT:= b"01111111";
        end case;
        return RESULT;
    end function;

         
         
         
end main;

architecture Behavioral of main is
    
    subtype STATE_TYPE is std_ulogic_vector(2 downto 0);
    constant START                      : STATE_TYPE := b"000";
    constant WORK_NORMAL    : STATE_TYPE := b"001";
    constant SETUP_TIME            : STATE_TYPE := b"010";
    constant SETUP_ALARM        : STATE_TYPE := b"100";
    constant BUZZER_ON            : STATE_TYPE := b"111";
    

    signal H1: std_logic_vector(1 downto 0):= b"00";
    signal H0, M1, M0, S1, S0: std_logic_vector(3 downto 0):= b"0000" ;
    signal STATE , NEXTSTATE : STATE_TYPE ;
    signal SET_TIME , SET_ALARM , CLOCK_ON , ALARM_ON , STOP_ALARM : 
begin
    CHANGES: process ( CLK,RESET)
    begin
        if RESET='1' then
            STATE <= START;
        elsif CLK'event and CLK='1' then
                STATE <= NEXTSTATE;
        
        end if ;
end process CHANGES;


    CHANGES2 : process()
end Behavioral;
