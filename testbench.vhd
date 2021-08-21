library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library WORK;
use WORK.PACKAGE_DIGITAL_CLOCK.ALL;

entity testbench is

end testbench;



architecture BHV of testbench is
     
    signal CLOCK:std_logic:= '0';
    signal RESET, SET_TIME, SET_ALARM, STOP_ALARM, 
              ALARM_ON, CLOCK_ON, ALARM                 : std_logic;
    signal H_IN1 : unsigned(1 downto 0);
    signal H_IN0, M_IN1, M_IN0 : unsigned(3 downto 0);
    signal H_OUT1, H_OUT0, M_OUT1, M_OUT0,
           S_OUT1, S_OUT0: std_logic_vector(6 downto 0);
    
begin
    
    RESET <= '1', '0' after 1ns;
    
    CLOCK <= not CLOCK after PERIOD/2;
    
    
--    SET_TIME <=    '0', '0' after 2000 ms, '1' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms, '0' after 140000 ms;
--    SET_ALARM <=   '0', '0' after 2000 ms, '0' after 5000 ms, '1' after 7000 ms, '0' after 10000 ms, '0' after 140000 ms;
--    STOP_ALARM <=  '0', '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms, '0' after 140000 ms;
--    ALARM_ON <=    '0', '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '1' after 10000 ms, '1' after 140000 ms;
--    CLOCK_ON <=    '0', '1' after 2000 ms, '1' after 5000 ms, '1' after 7000 ms, '1' after 10000 ms, '1' after 140000 ms;
--    H_IN1 <=    b"00",b"00" after 2000ms,b"00" after 5000ms,b"00" after 7000ms,b"00" after 10000ms,b"00" after 140000 ms;
--    H_IN0 <=      x"0",x"0" after 2000 ms,x"4" after 5000 ms,x"4" after 7000 ms,x"0" after 10000 ms,x"0" after 140000 ms;
--    M_IN1 <=      x"0",x"0" after 2000 ms,x"2" after 5000 ms,x"2" after 7000 ms,x"0" after 10000 ms,x"0" after 140000 ms;
--    M_IN0 <=      x"0",x"0" after 2000 ms,x"0" after 5000 ms,x"2" after 7000 ms,x"0" after 10000 ms,x"0" after 140000 ms;
    
    -- input 1 :
--    SET_TIME <=            '0',    '0' after 2000 ms,    '1' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
--    SET_ALARM <=       '0',     '0' after 2000 ms,    '0' after 5000 ms, '1' after 7000 ms, '0' after 10000 ms;
--    STOP_ALARM <=    '0',     '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
--    ALARM_ON <=       '0',      '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '1' after 10000 ms ;
--    CLOCK_ON <=        '0',      '1' after 2000 ms, '1' after 5000 ms, '1' after 7000 ms, '1' after 10000 ms ; 
--    H_IN1 <=                 b"00",b"00" after 2000ms,b"01" after 5000ms,b"01" after 7000ms,b"00" after 10000ms;
--    H_IN0 <=                 x"0" ,  x"0" after 2000 ms,x"7" after 5000 ms,x"7" after 7000 ms,x"0" after 10000 ms;
--    M_IN1 <=                x"0",   x"0" after 2000 ms,x"3" after 5000 ms,x"3" after 7000 ms,x"0" after 10000 ms;
--    M_IN0 <=                x"0",   x"0" after 2000 ms,x"4" after 5000 ms,x"5" after 7000 ms,x"0" after 10000 ms;
    
    
    -- input 2 :
--    SET_TIME <=            '0',    '0' after 2000 ms,    '1' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
--    SET_ALARM <=       '0',     '0' after 2000 ms,    '0' after 5000 ms, '1' after 7000 ms, '0' after 10000 ms;
--    STOP_ALARM <=    '0',     '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
--    ALARM_ON <=       '0',      '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '1' after 10000 ms ;
--    CLOCK_ON <=        '0',      '1' after 2000 ms, '1' after 5000 ms, '1' after 7000 ms, '1' after 10000 ms ; 
--    H_IN1 <=                 b"00",b"00" after 2000ms,b"10" after 5000ms,b"10" after 7000ms,b"00" after 10000ms;
--    H_IN0 <=                 x"0" ,  x"0" after 2000 ms,x"1" after 5000 ms,x"1" after 7000 ms,x"0" after 10000 ms;
--    M_IN1 <=                x"0",   x"0" after 2000 ms,x"4" after 5000 ms,x"5" after 7000 ms,x"0" after 10000 ms;
--    M_IN0 <=                x"0",   x"0" after 2000 ms,x"9" after 5000 ms,x"0" after 7000 ms,x"0" after 10000 ms;
    
    
    
    
        -- input 3:
    SET_TIME <=            '0',    '0' after 2000 ms,    '1' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
    SET_ALARM <=       '0',     '0' after 2000 ms,    '0' after 5000 ms, '1' after 7000 ms, '0' after 10000 ms;
    STOP_ALARM <=    '0',     '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '0' after 10000 ms;
    ALARM_ON <=       '0',      '0' after 2000 ms, '0' after 5000 ms, '0' after 7000 ms, '1' after 10000 ms ;
    CLOCK_ON <=        '0',      '1' after 2000 ms, '1' after 5000 ms, '1' after 7000 ms, '1' after 10000 ms ; 
    H_IN1 <=                 b"00",b"00" after 2000ms,b"10" after 5000ms,b"10" after 7000ms,b"00" after 10000ms;
    H_IN0 <=                 x"0" ,  x"0" after 2000 ms,x"0" after 5000 ms,x"1" after 7000 ms,x"0" after 10000 ms;
    M_IN1 <=                x"0",   x"0" after 2000 ms,x"5" after 5000 ms,x"0" after 7000 ms,x"0" after 10000 ms;
    M_IN0 <=                x"0",   x"0" after 2000 ms,x"9" after 5000 ms,x"0" after 7000 ms,x"0" after 10000 ms;
    
--    SET_TIME <=    '0' after 130000 ms, '1' after 4000 ms, '0' after 5000 ms, '0' after 6000 ms, '0' after 120000 ms;
--    SET_ALARM <=   '0' after 130000 ms, '0' after 4000 ms, '1' after 5000 ms, '0' after 6000 ms, '0' after 120000 ms;
--    STOP_ALARM <=  '0' after 130000 ms, '0' after 4000 ms, '0' after 5000 ms, '0' after 6000 ms, '0' after 120000 ms;
--    ALARM_ON <=    '0' after 130000 ms, '0' after 4000 ms, '0' after 5000 ms, '1' after 6000 ms, '1' after 120000 ms;
--    CLOCK_ON <=    '1' after 130000 ms, '1' after 4000 ms, '1' after 5000 ms, '1' after 6000 ms, '1' after 120000 ms;
--    H_IN1 <=      x"0" after 130000 ms,x"0" after 4000 ms,x"0" after 5000 ms,x"0" after 6000 ms,x"0" after 120000 ms;
--    H_IN0 <=      x"0" after 130000 ms,x"4" after 4000 ms,x"4" after 5000 ms,x"0" after 6000 ms,x"0" after 120000 ms;
--    M_IN1 <=      x"0" after 130000 ms,x"2" after 4000 ms,x"2" after 5000 ms,x"0" after 6000 ms,x"0" after 120000 ms;
--    M_IN0 <=      x"0" after 130000 ms,x"0" after 4000 ms,x"2" after 5000 ms,x"0" after 6000 ms,x"0" after 120000 ms;
    

    REL: Main port map(RESET => RESET,
                              CLK => CLOCK,
                              SET_TIME => SET_TIME,
                              SET_ALARM => SET_ALARM,
                              STOP_ALARM =>STOP_ALARM,
                              ALARM_ON => ALARM_ON,
                              CLOCK_ON => CLOCK_ON,
                              H_IN1 => H_IN1,
                              H_IN0 => H_IN0,
                              M_IN1 => M_IN1,
                              M_IN0 => M_IN0,
                              ALARM => ALARM,
                              H_OUT1 => H_OUT1,
                              H_OUT0 => H_OUT0,
                              M_OUT1 => M_OUT1,
                              M_OUT0 => M_OUT0,
                              S_OUT1 => S_OUT1,
                              S_OUT0 => S_OUT0
                              ); 


end BHV;