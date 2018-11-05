----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 03:48:41 PM
-- Design Name: 
-- Module Name: timing_circuit - Behavioral
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

--entity timing_circuit is
  --  Port ( tx_empty : in STD_LOGIC;
    --       rx_empty : in STD_LOGIC;
      --     reset : in STD_LOGIC;
        --   clk : in STD_LOGIC;
          -- uld_rx : out STD_LOGIC;
           --ld_tx : out STD_LOGIC);
--end timing_circuit;

--architecture Behavioral of timing_circuit is
--signal count : integer:=0; 
--signal uldr : std_logic:='0'; 
--begin
--process(reset,clk)
--begin
--if(rx_empty='0' )then
--        uld_rx<='1';
--        else uld_rx<='0';
--end if;
--if(tx_empty='1') then 
--ld_tx<='1' ;
--else ld_tx<='0' ;
--end if ;
--end process ;

--end Behavioral;


entity timing_circuit is
Port(
    tx_empty: in std_logic;
    rx_empty: in std_logic;
    reset : in STD_LOGIC;
    clk: in std_logic;
    uld_rx: out std_logic;
    ld_tx: out std_logic;
    addra: out integer range 0 to 1919;
    addrb: out integer range 0 to 1579;
    wea: out std_logic;
    enb: out std_logic 

);
end entity;

architecture Behavioral of Timing_Circuit is
signal done: std_logic:='0';
signal uld: std_logic:='0';
signal addra1: integer range 0 to 1919:=0;
signal addrb1: integer range 0 to 1579:=0;
signal ld:StD_LOGIC:= '0' ;
signal recieve:integer:=0 ;
begin
process(clk)
begin 
    if(rising_edge(clk)) then
if(reset='1') then
    uld_rx<='0';
    uld<='0' ;
    ld_tx<='1';
    ld<='1';
    addra<=0;
    addrb<=0;
    addrb1<=0;
    addra1<=0;
    wea<='0' ;
    enb<='0' ;
else 
        if(rx_empty='0' and uld='0') then
            addra1<=addra1+1;
            addra<=addra1;
            wea<='1';
            uld<='1' ;
            uld_rx<='1';
            recieve<=0 ;
        else wea<='1' ;
             uld_rx<='0' ;
             uld<='0' ;
             addra<=addra1 ;    
        end if;
        if(tx_empty='1' and ld='0' and recieve<1580 and addra1/=addrb1)then
            ld_tx<='1';
            ld<='1';
            addrb1<=addrb1+1;
            addrb<=addrb1;
            enb<='1';
            recieve<=recieve+1 ;
         elsif(tx_empty='0') then
            ld_tx<='0' ;
            ld<='0';
            enb<='0' ;
            addrb<=addrb1;
        end if;
    end if;
end if ;
end process;


end Behavioral;
