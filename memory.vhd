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
USE ieee.numeric_std.ALL;
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
 addra:in integer range 0 to 1919; 
 addrb:in integer range 0 to 1579;
 en:in std_logic;
 clk:in std_logic;
 wea:in std_logic:='0'
 
 );
end memory;

architecture Behavioral of memory is
signal e:std_logic_vector(15359 downto 0);
signal ab:integer range 0 to 15359;
signal cd:integer range 0 to 12639;
signal countI: integer range 0 to 157:=0;
signal countJ: integer range 0 to 9:=0;
signal done: Std_logic:='0';
signal i0j0,i0j1,i0j2,i1j0,i1j1,i1j2,i2j0,i2j1,i2j2: integer;
signal res: integer;
signal cenable :  std_logic:='0';
type int_array is array(0 to 8) of Integer;
Signal arr1: int_array :=(8,16,8,16,32,16,8,16,8) ;
signal spare:std_logic_vector(17 downto 0) ;
signal newline: integer range 0 to 157:=0;
begin

process(clk)

begin

if(rising_edge(clk))then
if reset='1' then
    e<= (others => '0');
    countI<=0;
    countJ<=0;
    done<='0';
    --"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
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
        if(addra=1919)then
            cenable<='1';
        end if;
      end if;
end if;
end if;
end process;
process(clk)
begin
if(rising_edge(clk))then
if(en='1')then
cd<=addrb*8;
counti<=addrb/160;
countj<=addrb mod 160;
if(newline=counti)then
    spare<=std_logic_vector(to_unsigned(to_integer(signed(e((counti*160+countj)*8 to (counti*160+countj+1)*8)-1))*arr1(0)+to_integer(signed(e((counti*160+countj+1)*8 to (counti*160+countj+2)*8-1)))*arr1(1)+to_integer(signed(e((counti*160+countj+2)*8 to (counti*160+countj+3)*8-1)))*arr1(2)+to_integer(signed(e(((counti+1)*160+countj)*8 to ((counti+1)*160+countj+1)*8-1)))*arr1(3)+to_integer(signed(e(((counti+1)*160+countj+1)*8 to ((counti+1)*160+countj+2)*8-1)))*arr1(4)+to_integer(signed(e(((counti+1)*160+countj+2)*8 to ((counti+1)*160+countj+3)*8-1)))*arr1(5)+to_integer(signed(e(((counti+2)*160+countj)*8 to ((counti+2)*160+countj)*8+1)-1))*arr1(6)+to_integer(signed(e(((counti+2)*160+countj+1)*8 to ((counti+2)*160+countj+2)*8-1)))*arr1(7)+to_integer(signed(e(((counti+2)*160+countj+2)*8 to ((counti+2)*160+countj+3)*8-1)))*arr1(8),18));
        doutb<=spare(14 downto 7) ;
   newline<=addrb/160;
else
    newline<=addrb/160;
end if;
else doutb<="11111111" ;
   cd<=0 ;
end if;
end if;
end process;


end Behavioral;

