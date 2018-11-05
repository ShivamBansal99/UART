----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2018 01:46:44
-- Design Name: 
-- Module Name: Product - Behavioral
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

entity Product is
  Port (
    XI0Jn,XI0J0,XI0Jp,XInJn,XInJ0,XInJp,XIpJn,XIpJ0,XIpJp:in Integer;
    Res: out Integer );
end Product;

architecture Behavioral of Product is
type int_array is array(0 to 8) of Integer;
Signal arr1: int_array :=(8,16,8,16,32,16,8,16,8) ;
begin
res<=XI0Jn*arr1(3)+XI0J0*arr1(4)+XI0Jp*arr1(5)+XInJn*arr1(0)+XInJ0*arr1(1)+XInJp*arr1(2)+XIpJn*arr1(6)+XIpJ0*arr1(7)+XIpJp*arr1(8);

end Behavioral;
