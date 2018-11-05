
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transmitter is
    Port ( reset : in STD_LOGIC;
       txclk : in STD_LOGIC;
       ld_tx : in STD_LOGIC;
       tx_out : out STD_LOGIC;
       tx_en : in STD_LOGIC;
       tx_data : in STD_LOGIC_VECTOR (7 downto 0);
       tx_empty : out STD_LOGIC
       --ld: out std_logic_vector(7 downto 0)
       );
end transmitter;

architecture Behavioral of transmitter is
Type State1 Is (idle,s1,s2,s3) ;
Signal state : State1:=idle ;
signal count : integer range 0 to 7 :=0;
signal data : STD_LOGIC_vector(7 downto 0);
signal var : std_logic:='1';
signal st : STD_LOGIC_vector(7 downto 0):="00000000";
begin
--with state select st <= 
   -- "00000000" when idle,
  --  "10000000" when s0,
   -- "01000000" when s1,
  --  "00100000" when s2,
  --  "00010000" when s3,
   -- "00001000" when s4,
   -- "00000100" when s5,
   -- "00000010" when s6,
  --  "00000001" when s7,
  --  "11111111" when start ;

--ld<=st;
process(txclk)
begin   
if rising_edge(txclk)then
if (reset='1') then
        tx_out<='1';
        tx_empty<='1';
        state<=Idle;
else if tx_en='0' then
        tx_out<='1';
        tx_empty<='0';
        state<=idle ;
    else 
    
        case state is
 
        when Idle =>
          tx_empty <= '1';
          tx_out <= '1';         
          count <= 0;
          if ld_tx = '1' then
            tx_empty <= '0';
            data <= tx_data;
            state <= s1;
          else
            state <= Idle;
          end if;
 
        when s1 =>
          
          tx_out <= '0';
          state   <= s2;         
 
 
        when s2 =>
          tx_out <= data(count);
            
            if count < 7 then
              count <= count + 1;
              state   <= s2;
            else
              count <= 0;
              state   <= s3;
            end if;

  
        when s3 =>
          tx_out <= '1';
          state   <= Idle; 
                   
 
      end case;
     end if;
end if;
end if ;
end process ;
end Behavioral;

