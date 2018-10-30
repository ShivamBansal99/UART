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
           tx_out : out STD_LOGIC ;
           LED_out: out STD_LOGIC_VECTOR(6 downto 0) ;
           anode_activate :out  STD_LOGIC_VECTOR(3 DOWNtO 0) 
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
signal ledo : integer ;
signal co : integer range 0 to 3 ;

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
process(txclk)
begin 
co<=co+1 ;
end process ;
process(txclk)
begin
    case co is
    when 0 =>
        Anode_Activate <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        ledo <= addrb;
        -- the first hex digit of the 16-bit number
    when 1 =>
        Anode_Activate <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        ledo <= addrb;
        -- the second hex digit of the 16-bit number
    when 2 =>
        Anode_Activate <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        ledo <= addrb;
        -- the third hex digit of the 16-bit number
    when 3 =>
        Anode_Activate <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        ledo <= addrb;
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;
LED_out<="0000001" when ledo=0 else
     "1001111" when ledo=1 else
     "0010010" when ledo=2 else
     "0000110" when ledo=3 else
     "1001100" when ledo=4 else
     "0100100" when ledo=5 else
     "0100000" when ledo=6 else
     "0001111" when ledo=7 else
     "0000000" when ledo=8 else
          "0000100" when ledo=9 else
          "0000010" when ledo=10 else
          "1100000" when ledo=11 else
          "0110001" when ledo=12 else
          "1000010" when ledo=13 else
          "0110000" when ledo=14 else
          "0111000"  ;
        

led<=rx_data ;

end Behavioral;