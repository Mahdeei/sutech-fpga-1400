library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package PACKAGE_DIGITAL_CLOCK is 
    
    constant FREQ : integer := 10;
    constant PERIOD : time := 100 ms;
    
    component Main is
     port(
         H_IN1: in unsigned(1 downto 0);
         H_IN0, M_IN1, M_IN0: in unsigned(3 downto 0);
         CLK, RESET, SET_TIME , SET_ALARM , CLOCK_ON , ALARM_ON , STOP_ALARM: in std_logic;
         H_OUT1, H_OUT0, M_OUT1, M_OUT0, S_OUT1, S_OUT0: out std_logic_vector(7 downto 0);
         ALARM : out std_logic
     ); 
     end component;
     
     function BCD_TO_7SEG( 
    BCD: std_logic_vector ( 3 downto 0 ) := b"0000" )
    return std_logic_vector ;
    
    
    
    
end package;

package body PACKAGE_DIGITAL_CLOCK is 
    
             
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

    
    
end package body;
