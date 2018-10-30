----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2018 02:13:25 PM
-- Design Name: 
-- Module Name: receiver - Behavioral_receiver
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity receiver is
Port (
uld_rx: in std_logic := '0';
rxclk: in std_logic;
rx_en: in std_logic := '0';
reset: in std_logic := '0';
rx_in: in std_logic ;

rx_data: out std_logic_vector(7 downto 0); 
rx_empty: out std_logic := '1'
--ctr: out std_logic_vector(3 downto 0)
--dummy2: out std_logic
 );

end receiver;

architecture Behavioral of receiver is
signal ctr16: std_logic_vector(3 downto 0) := "0000" ;
signal ctr8: std_logic_vector(3 downto 0) := "0000" ;
signal counter: std_logic_vector(3 downto 0) := "0000" ;
signal storage: std_logic_vector(7 downto 0) := "00000000";
--signal rxclock: std_logic := '0';
signal empty: std_logic := '1';
signal dummy: std_logic := '0';


begin
--d1 : entity work.receiver_clock(Behavioral) port map(clock_original, rxclock);

rx_empty <= empty;
--dummy2 <= dummy;
process(rxclk)
    begin
        if(reset = '1') then
            rx_data <= "00000000";
            empty <= '1';
            dummy <= '0';
            storage <= "00000000";
            counter <= "0000";
            ctr8 <= "0000";
            ctr16 <= "0000";
       
        
       elsif(rxclk = '0' and rxclk'event) then
            if(rx_in = '0' and rx_en = '1' and dummy ='0') then
                ctr8 <= ctr8 + 1;
            else 
                ctr8 <= "0000";
            end if;
            
            if(ctr8 = "1000") then    --start bit arrives
               dummy <= '1';
               ctr8 <= "0000"; 
--               counter <= "0000";
            end if;
            
            if(rx_en ='1' and dummy = '1') then
                
--                if(ctr16 <= "1110") then 
--                    ctr16 <= "0000";
--                else        
            ctr16 <= ctr16 +1;
            
            end if;
            
            if(ctr16 = "1111" and rx_en = '1' and dummy = '1') then
                counter <= counter +1;
              --  if(counter <= "0111" and uld_rx = '0') then
                    storage(to_integer(unsigned(counter))) <= rx_in;
             --   end if;
                  ctr16 <= "0000";
            end if;
            
            if(counter = "1000" and dummy = '1') then 
                empty <= '0';
                dummy <= '0';
                counter <= "0000";
                ctr8 <= "0000";
                ctr16 <= "0000";
--                if(rx_in = '0') then
--                    storage <= "00000000";    --#framing error
--                end if;
            end if;
            
            if(uld_rx ='1' ) then 
                rx_data <= storage;
                empty <= '1';
--                storage <= "00000000";
            end if;
        end if;  
    end process;                
   -- ctr<= counter;            
end Behavioral;
