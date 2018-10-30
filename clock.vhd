----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 05:03:19 PM
-- Design Name: 
-- Module Name: clock - Behavioral
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

entity clock is
  Port (reset: in std_logic;
        clk: in std_logic;
        baud : out std_logic;
        baud16 : out std_logic
   );
end clock;

architecture Behavioral of clock is
signal temp_clk16: STD_LOGIC:='0';
signal count5207: integer range 0 to 5207 :=0;
signal temp_clk: STD_LOGIC:='0';
signal count325: integer range 0 to 325 :=0;
begin
-- clock reciever
process(clk)
begin
if(clk='1' and clk'EVENT)then
  if(count325<325)then
     count325<=count325+1;
  else
   count325<=0;
   temp_clk16<=not(temp_clk16);
end if;
end if;
end process;
baud<=temp_clk;
-- clock transmitter
process(clk)
begin
if(clk='1' and clk'EVENT)then
  if(count5207<5207)then
     count5207<=count5207+1;
  else
   count5207<=0;
   temp_clk<=not(temp_clk);
end if;
end if;
end process;
baud16<=temp_clk16;
end Behavioral;