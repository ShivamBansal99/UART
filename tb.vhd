
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_rx is
end tb_rx;

architecture Behavioral of tb_rx is

component receiver
PORT(
    rxclk : in std_logic;
    reset : in std_logic;
    rx_en : in std_logic;
    uld_rx : in std_logic;
    rx_in : in std_logic;
    rx_data : out std_logic_vector (7 downto 0);
    rx_empty : out std_logic
    
    
    );
end component;

signal rxclk, reset, rx_en, uld_rx: std_logic := '0';
signal rx_in : std_logic := '1';
signal rx_empty : std_logic;
signal rx_data : std_logic_vector (7 downto 0);
constant data1 : std_logic_vector (9 downto 0) := "1001101010";
constant data2 : std_logic_vector (9 downto 0) := "1101010100";
begin

rx_instance: receiver port map(
    rxclk => rxclk,
    reset => reset,
    rx_en => rx_en,
    uld_rx => uld_rx,
    rx_in => rx_in,
    rx_data => rx_data,
    rx_empty => rx_empty
);

clock_proc: process begin
    wait for 3255 ns;
    rxclk <= not rxclk;
end process;

other_inputs_proc: process begin
    wait for 1 us;
    reset <= '1';
    wait for 10 us;
    reset <= '0';
    wait for 10 us;
    rx_en <= '1';
    for i in 0 to 9 loop
        wait for 104160 ns;
        rx_in <= data1 (i);
    end loop;
    wait for 104160 ns;
    uld_rx <= '1';
    wait for 104160 ns;
    uld_rx <= '0';
    for i in 0 to 9 loop
        wait for 104160 ns;
        rx_in <= data2 (i);
    end loop;
    wait for 6510 ns;
    uld_rx <= '1';
    wait for 6510 ns;
    uld_rx <= '0';
    wait for 10 us;
    rx_en <= '0';
end process;

end Behavioral;
