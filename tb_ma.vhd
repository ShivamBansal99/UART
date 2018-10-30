----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2018 05:37:59 PM
-- Design Name: 
-- Module Name: tb_ma - Behavioral
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

entity tb_ma is
--  Port ( );
end tb_ma;

architecture Behavioral of tb_ma is

component Master_circuit 
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           tx_en : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           rx_en : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(7 downto 0);
           tx_out : out STD_LOGIC 
           );
end component ;
 
signal reset,clock_original,tx_en,rx_in,rx_en,tx_out :Std_logic:='0' ;
signal led: Std_logic_vector(7 downto 0) ;
signal states : integer :=0;
constant data1 : std_logic_vector (9 downto 0) := "1001101010";
begin
ma_instance: Master_circuit port map(
    reset => reset,
    clk => clock_original,
    tx_en => tx_en,
    rx_in => rx_in,
    rx_en => rx_en,
    led => led,
    tx_out => tx_out 
);
 clock_proc: process begin
     wait for 5ns ;
     clock_original <= not clock_original ;
 end process;
 
 other_inputs_proc: process begin
    rx_in<='1';
     wait for 10 us;
     reset <= '0';
     wait for 10 us;
     rx_en <= '1';
     tx_en <= '0' ;
     for i in 0 to 9 loop
         wait for 104160 ns;
         rx_in <= data1 (i);
     end loop;
     wait for 10us;
     tx_en<='1';
     wait for 10us;
 end process;
 
end Behavioral;
