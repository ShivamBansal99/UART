----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2018 04:23:47 PM
-- Design Name: 
-- Module Name: timing - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
 Port (
 reset:in std_logic;
 dina:in std_logic_vector(7 downto 0); 
 doutb:out std_logic_vector(7 downto 0);
 addra:in integer range 0 to 15; 
 addrb:in integer range 0 to 15;
 en:in std_logic;
 clk:in std_logic;
 wea:in std_logic:='0'
 );
end memory;

architecture Behavioral of memory is
signal e:std_logic_vector(127 downto 0);
signal ab:integer range 0 to 127;
signal cd:integer range 0 to 127;
begin
process(clk)
begin
if(rising_edge(clk))then
if reset='1' then
    e<="00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
else if(wea='1')then
        ab<=addra*8;
        e(ab)<=dina(0);
        e(ab+1)<=dina(1);
        e(ab+2)<=dina(2);
        e(ab+3)<=dina(3);
        e(ab+4)<=dina(4);
        e(ab+5)<=dina(5);
        e(ab+6)<=dina(6);
        e(ab+7)<=dina(7);
      end if;
end if;
end if;
end process;
process(clk)
begin
if(rising_edge(clk))then
if(en='1')then
cd<=addrb*8;
doutb(0)<=e(cd);
doutb(1)<=e(cd+1);
doutb(2)<=e(cd+2);
doutb(3)<=e(cd+3);
doutb(4)<=e(cd+4);
doutb(5)<=e(cd+5);
doutb(6)<=e(cd+6);
doutb(7)<=e(cd+7);
else doutb<="11111111" ;
    cd<=0 ;
end if;
end if;
end process;

end Behavioral;

