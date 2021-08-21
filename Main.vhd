library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library WORK;
use WORK.PACKAGE_DIGITAL_CLOCK.ALL;

entity Main is
     port(
         H_IN1: in unsigned(1 downto 0);
         H_IN0, M_IN1, M_IN0: in unsigned(3 downto 0);
         CLK, RESET, SET_TIME , SET_ALARM , CLOCK_ON , ALARM_ON , STOP_ALARM: in std_logic;
         H_OUT1, H_OUT0, M_OUT1, M_OUT0, S_OUT1, S_OUT0: out std_logic_vector(6 downto 0);
         ALARM : out std_logic
     ); 
         

end main;

architecture Behavioral of main is
    
    subtype STATE_TYPE is std_ulogic_vector(2 downto 0);
    constant START                     : STATE_TYPE := b"000";
    constant WORK_NORMAL      : STATE_TYPE := b"001";
    constant SETUP_TIME            : STATE_TYPE := b"010";
    constant SETUP_ALARM         : STATE_TYPE := b"100";
    constant BUZZER_ON            : STATE_TYPE := b"111";
    signal STATE , NEXTSTATE : STATE_TYPE ;
    signal H, M, S : integer ;
    signal ALARM_H, ALARM_M: integer ;
    signal COUNTER:      integer ;
    signal T_RES : std_logic;
    signal SECOND: std_logic;
    
    
    
begin
    FSM1: process
    begin
        if RESET='1' then
            STATE <= START;
            COUNTER <= 1;
            T_RES <= '1';
            SECOND <= '0';
        elsif CLK'event and CLK='1' then
                STATE <= NEXTSTATE;
                T_RES <= '0' ;
                SECOND <= '0';
                if(COUNTER < FREQ) then
                    COUNTER <=  COUNTER + 1;
                elsif(COUNTER = FREQ) then 
                    COUNTER <= 1;
                    SECOND <= '1';
                end if;
        end if ;
        wait on CLK,RESET;
end process;


    FSM2 : process
    begin
        case STATE is 
            when START =>
                if(T_RES='1') then
                    H  <= 0; 
                    M <= 0;
                    S  <= 0;
                    NEXTSTATE <= START;
                    ALARM <= '0';
                elsif(CLOCK_ON ='1') then 
                    NEXTSTATE <= WORK_NORMAL;
                end if;  
            when WORK_NORMAL =>
                ALARM <= '0';
                if(SET_ALARM='1') then
                    NEXTSTATE <= SETUP_ALARM;
                elsif(SET_TIME='1') then
                    NEXTSTATE <= SETUP_TIME;
                elsif(CLOCK_ON='0') then 
                    NEXTSTATE <= START;
                elsif(ALARM_ON ='1' and  H = ALARM_H and  M= ALARM_M and S < 10) then
                    NEXTSTATE <= BUZZER_ON;
                end if;
                
            when SETUP_ALARM =>       
                if(SET_ALARM ='0') then
                    NEXTSTATE <= WORK_NORMAL;
                else
                    ALARM_H <= to_integer(H_IN1) *10 + to_integer(H_IN0) ;  
                    ALARM_M <= to_integer(M_IN1) *10 + to_integer(M_IN0) ;        
                end if;   
            when SETUP_TIME =>    
                if(SET_TIME ='0') then
                    NEXTSTATE <= WORK_NORMAL;
                else
                    H <= to_integer(H_IN1) *10 + to_integer(H_IN0) ;  
                    M <= to_integer(M_IN1) *10 + to_integer(M_IN0) ;    
                end if;   

            when BUZZER_ON =>
                ALARM <= '1';
                if(ALARM_ON ='0' or  STOP_ALARM='1' or S >= 10) then
                    NEXTSTATE <= WORK_NORMAL;
                end if;
            when others =>
                NEXTSTATE <= START;
        end case;
        
        if (STATE /= START and STATE /= SETUP_TIME ) then 
            if(SECOND'event and SECOND = '1') then
                S <= S +1;
                if(S = 59) then
                    S <= 0;
                    M <= M +1;
                end if;
                if(S = 59 and M = 59) then
                    M <= 0;
                    H <= H +1;
                end if;
                if(S = 59 and M = 59 and H = 23) then
                    H <= 0;
                end if;
            end if;   
        end if ; 
        
        
        H_OUT1 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(H/10, 4)));
        H_OUT0 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(H mod 10,4)));
        M_OUT1 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(M/10,4)));
        M_OUT0 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(M mod 10,4)));
        S_OUT1 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(S/10,4)));
        S_OUT0 <= BCD_TO_7SEG(std_logic_vector(to_unsigned(S mod 10,4)));
        
        
        wait on STATE,T_RES,SET_TIME , SET_ALARM , CLOCK_ON , ALARM_ON , STOP_ALARM,
                H_IN1,H_IN0,M_IN1,M_IN0,ALARM_H,ALARM_M , H , M , S, SECOND;
end process ;

end Behavioral;
