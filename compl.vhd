----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2018 01:32:40 PM
-- Design Name: 
-- Module Name: Master_circuit - Behavioral
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

entity Master_circuit is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           tx_en : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           rx_en : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(7 downto 0);
           tx_out : out STD_LOGIC 
--states : out integer ;
  --         r: out std_logic_vector(7 downto 0)
            );
end Master_circuit;

architecture Behavioral of Master_circuit is
component receiver
PORT(
    rxclk : in std_logic;
    reset : in std_logic;
    rx_en : in std_logic;
    uld_rx : in std_logic;
    rx_in : in std_logic;
    rx_data : out std_logic_vector (7 downto 0);
    rx_empty : out std_logic
    --stat : out integer 
    
    );
end component;
signal rxclk : std_logic;
signal txclk : std_logic;
signal ld_tx : std_logic;
signal tx_empty : std_logic;
signal rx_empty : std_logic;
signal tx_out2 : std_logic;
signal tx_data : std_logic_vector(7 downto 0);
signal rx_data : std_logic_vector(7 downto 0);
signal uld_rx : std_logic;
signal tx_en2 : std_logic;
signal rx_en2 : std_logic;
signal reset2 : std_logic:='0' ;
signal chst : integer :=1 ;
signal addra : integer range 0 to 15:=0 ;
signal addrb : integer range 0 to 15:=0 ;
signal wea : std_logic;
signal enb : std_logic;
begin
d1 : entity work.clock(Behavioral) port map(
reset=>reset,
clk=>clk, 
baud=>txclk, 
baud16=>rxclk);

Div_transmitter: ENTITY WORK.transmitter(Behavioral)
PORT MAP (
    reset => reset,
    txclk => txclk,
    ld_tx => ld_tx,
    tx_en => tx_en,
    tx_out => tx_out,
    tx_data => tx_data,
    tx_empty => tx_empty
);
--states<=chst ;
--if(chst=0) then led="11111111" ; end if ; 

rx_instance: ENTITY WORK.receiver(Behavioral) PORT MAP(
    rxclk => rxclk,
    reset => reset,
    rx_en => rx_en,
    uld_rx => uld_rx,
    rx_in => rx_in,
    rx_data => rx_data,
    rx_empty => rx_empty
    --stat => chst
);
timing_circuit: entity work.timing_circuit(Behavioral) port map(
    tx_empty=>tx_empty, 
    rx_empty=>rx_empty,
    reset=>reset,
    clk=>rxclk, 
    uld_rx=>uld_rx, 
    ld_tx=>ld_tx,
    addra=>addra ,
    addrb=>addrb ,
    wea=>wea ,
    enb=>enb 
    ) ;
memory: ENTITY WORK.memory(Behavioral) PORT MAP(
    dina=>rx_data ,
    doutb=>tx_data,
    addra=>addra,
    addrb=>addrb,
    en=>enb,
    clk=>rxclk,
    wea=>wea
);
    

led<=rx_data ;

end Behavioral;