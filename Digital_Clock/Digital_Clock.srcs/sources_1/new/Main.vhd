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
         H_OUT1, H_OUT0, M_OUT1, M_OUT0, S_OUT1, S_OUT0: out std_logic_vector(7 downto 0);
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
    signal STATE , NEXTSTATE :        STATE_TYPE ;
    signal H, M, S :                         integer ;
    signal ALARM_H, ALARM_M:     integer ;
    signal COUNTER , SECOND:      integer ;
    signal T_RES : std_logic;
    
    
    
begin
    FSM1: process
    begin
        if RESET='1' then
            STATE <= START;
            COUNTER <= 1;
            T_RES <= '1';
        elsif CLK'event and CLK='1' then
                STATE <= NEXTSTATE;
                T_RES <= '0' ;
                if(COUNTER < FREQ) then
                    COUNTER <=  COUNTER + 1;
                elsif(COUNTER = FREQ) then 
                    COUNTER <= 1;
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
                elsif(CLOCK_ON ='1') then 
                    NEXTSTATE <= WORK_NORMAL;
                end if;  
            when WORK_NORMAL =>
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
                ALARM_H <= to_integer(H_IN1) *10 + to_integer(H_IN0) ;  
                ALARM_M <= to_integer(M_IN1) *10 + to_integer(M_IN0) ;       
                if(SET_ALARM ='0') then
                    NEXTSTATE <= WORK_NORMAL;
                end if;   
            when SETUP_TIME =>
                H <= to_integer(H_IN1) *10 + to_integer(H_IN0) ;  
                M <= to_integer(M_IN1) *10 + to_integer(M_IN0) ;    
                if(SET_TIME ='0') then
                    NEXTSTATE <= WORK_NORMAL;
                end if;   

            when BUZZER_ON =>
                ALARM <= '1';
                if(ALARM_ON ='0' or  STOP_ALARM='1' or S = 10) then
                    NEXTSTATE <= WORK_NORMAL;
                    ALARM <= '0';
                end if;
        end case;
        
        if (STATE /= START and STATE =  SETUP_TIME ) then 
            if(COUNTER =FREQ ) then
                             S <= S +1;
                             if(S =60) then
                                S <= 0;
                                M <= M +1;
                             end if;
                             if(M =60) then
                                M <= 0;
                                H <= H +1;
                             end if;
                             if(H =24) then
                                H <= 0;
                             end if;
                        end if;   
        end if ; 
        wait on STATE,T_RES,SET_TIME , SET_ALARM , CLOCK_ON , ALARM_ON , STOP_ALARM,
                H_IN1,H_IN0,M_IN1,M_IN0,ALARM_H,ALARM_M , H , M , S;
end process ;

end Behavioral;