----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 05:09:58 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
Port (rin : in Std_logic ;
      tout : out std_logic ;
      clk : in std_logic ;
      reset : in std_logic ; 
        sw0 : in std_logic;
              sw1 : in std_logic
 );
end main;

architecture Behavioral of main is
component clock
Port (reset: in std_logic;
        clk: in std_logic;
        baud : out std_logic;
        baud16 : out std_logic
        
   );
end component ;
component timing_circuit
Port ( tx_empty : in STD_LOGIC;
           rx_empty : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           uld_rx : out STD_LOGIC;
           ld_tx : out STD_LOGIC);
end component ;
component transmitter
Port ( reset : in STD_LOGIC;
       txclk : in STD_LOGIC;
       ld_tx : in STD_LOGIC;
       tx_out : out STD_LOGIC;
       tx_en : in STD_LOGIC;
       tx_data : in STD_LOGIC_VECTOR (7 downto 0);
       tx_empty : out STD_LOGIC);
end component ;
component receiver
 Port ( reset : in STD_LOGIC;
          rxclk : in STD_LOGIC;
          uld_rx : in STD_LOGIC;
          rx_in : in STD_LOGIC;
          rx_en : in STD_LOGIC;
          rx_data : out STD_LOGIC_VECTOR (7 downto 0);
          rx_empty : out STD_LOGIC);
end component ;

signal clk16 :std_logic;
signal clk1 :std_logic;
signal datas :std_logic_vector(7 downto 0);
signal ld_tx :std_logic;
signal tx_empty :std_logic;
signal uld_rx :std_logic;
signal rx_empty :std_logic;
begin
a1: transmitter port map(reset,clk1,ld_tx,tout,sw0,datas,tx_empty) ;
a2: receiver port map(reset,clk16,uld_rx,rin,sw1,datas,rx_empty) ;
a3: clock port map(reset, clk, clk1, clk16) ;
a4: timing_circuit port map(tx_empty,rx_empty,reset,clk16,uld_rx,ld_tx) ;
 


end Behavioral;
