----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 01:37:19 PM
-- Design Name: 
-- Module Name: receiver - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity receiver is
    Port ( reset : in STD_LOGIC;
           rxclk : in STD_LOGIC;
           uld_rx : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           rx_en : in STD_LOGIC;
           rx_data : out STD_LOGIC_VECTOR (7 downto 0);
--           stat : out integer ;
           rx_empty : out STD_LOGIC);
           
end receiver;
architecture Behavioral of receiver is
Type State1 Is (idle,start,s0,s1,s2,s3,s4,s5,s6,s7,stop) ;
signal st: integer:=0;
Signal state : State1:=idle ;
signal counter : integer:=0;
signal temp : STD_LOGIC:='0';
signal count : integer:=0;
signal data : STD_LOGIC_VECTOR(7 downto 0):="00000000" ;
signal datae : STD_LOGIC_VECTOR(7 downto 0):="00000000" ;
begin
process(rxclk)
begin   
--rx_data<="11001100";
    if(reset='0' and rx_en='1') then
--        stat <= st ;
        case state is 
        when idle =>
            st<=0 ;
            if(uld_rx='1') then
                rx_data<=data;
                datae <= data ;
                rx_empty<='1';
             else 
		rx_data<="00000000";
		datae<="00000000";
             end if;
             if(rx_in='0') then
                  state<=start;
             else state<=idle;
             end  if ;
        when start =>
            st<=1 ;
            if(rxclk'event and rxclk='1') then
                if(rx_in='0') then
                    count<=count+1;
                    state<=start;
                else 
                    count<=0;
                    state<=idle ;
                end if;
            end if;
            if(count>=8) then
                count<=0 ;
                state<=s0;
            end if;
            rx_empty<='1';
        when s0 =>
        st<=2 ;
           count<=count+1; 
           if(count=31) then
           data(0) <= rx_in ;
           count<=0 ;
           state<= s1 ;
           else state<=s0; 
           end if ;
        when s1 =>
        st<=3 ;
              count<=count+1; 
              if(count=31) then
              data(1) <= rx_in ;
              count<=0 ;
              state<= s2 ;
              else state<=s1;  
              end if ;
        when s2 =>
        st<=4 ;
                 count<=count+1; 
                 if(count=31) then
                 data(2) <= rx_in ;
                 count<=0 ;
                 state<= s3 ;
                 else state<=s2;  
                 end if ;
        when s3 =>
        st<=5 ;
                    count<=count+1; 
                    if(count=31) then
                    data(3) <= rx_in ;
                    count<=0 ;
                    state<= s4 ;
                    else state<=s3;  
                    end if ;
        when s4 =>
        st<=6 ;
                       count<=count+1; 
                       if(count=31) then
                       data(4) <= rx_in ;
                       count<=0 ;
                       state<= s5 ;
                       else state<=s4;  
                       end if ;
        when s5 =>
        st<=7 ;
                          count<=count+1; 
                          if(count=31) then
                          data(5) <= rx_in ;
                          count<=0 ;
                          state<= s6 ;
                          else state<=s5;  
                          end if ;
        when s6 =>
        st<=8 ;
                             count<=count+1; 
                             if(count=31) then
                             data(6) <= rx_in ;
                             count<=0 ;
                             state<= s7 ;
                             else state<=s6;  
                             end if ;
        when s7 =>
        st<=9 ;
                                count<=count+1; 
                                if(count=31) then
                                data(7) <= rx_in ;
                                count<=0 ;
                                state<= stop ;
                                else state<=s7;  
                                end if ;
                                
        when stop => 
        st<=10 ;
           count<=count+1; 
           if(count=16) then
              if(rx_in = '1') then
                rx_empty<='0' ;
              else data<="11111111";
              rx_empty<='1';
              end if;
              state<=idle;
              count<=0 ;
           end if ;          
        end case ; 
    else state<= idle ;
        st<=0 ;
        rx_data<="00000000";
        data<="00000000";
    end if;    
end process ;
end Behavioral;
