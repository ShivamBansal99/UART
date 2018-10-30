
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity UART_TEST is

end UART_TEST;

architecture Behavioral of UART_TEST is

component Master_circuit 
    Port ( reset : in STD_LOGIC;
           clock_original : in STD_LOGIC;
           tx_en : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           rx_en : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(7 downto 0);
           tx_out : out STD_LOGIC 
           --states : out integer ;
          -- rclk : out std_logic_vector(7 downto 0)
           );
end component ;

signal clk, tx_out : std_logic := '0';
signal led: Std_logic_vector(7 downto 0) ;
signal rx_in_raw : std_logic := '1';
constant data1 : std_logic_vector (9 downto 0) := "1001100010";
constant data2 : std_logic_vector (9 downto 0) := "1101010100";
signal PB0 : std_logic := '0';
constant SW0 : std_logic := '1';
constant SW1 : std_logic := '1';
signal check : std_logic := '1';
signal state : integer:=0 ;
signal  rclk : Std_logic_vector(7 downto 0):="00000000";
begin

ma_instance: Master_circuit port map(
    reset => pb0,
    clock_original => clk,
    tx_en => sw0,
    rx_in => rx_in_raw,
    rx_en => sw1,
    led => led,
    tx_out => tx_out
   -- states => state ,
   -- rclk=> rclk 
    
);

clock_proc: process begin
    wait for 5 ns;
    clk <= not clk;
end process;

other_inputs_proc: process begin
    
    wait for 500000ns;
    
    PB0 <= '0';
    
    wait for 500000ns;
    wait for 500000ns;
    
    for i in 0 to 9 loop
        wait for 104160 ns;
        rx_in_raw <= data1(i);
    end loop;
    wait for 100000ns;
    for i in 0 to 9 loop
            wait for 104160 ns;
            rx_in_raw <= data2(i);
        end loop;
    
    wait for 104160 ns;

    
end process;
    
end Behavioral;