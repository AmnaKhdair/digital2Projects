-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
Entity Parallel_To_Serial is
 port( CLK, RESET, WR: in std_logic;
 Date : in std_logic_vector(6 downto 0);
 TXD : out std_logic);
 
End Parallel_To_Serial;

architecture BEHAVIOR of Parallel_To_Serial is 
type State is(	T0,T1,T2,T3,T4);
signal current_state,next_state: State;
signal n: integer range -1 to 7;
signal R_temp:std_logic_vector(6 downto 0);
signal p_temp:std_logic;
begin

P1: process(current_state,WR,n,p_temp)
begin 
case current_state is 
when T0=> if(wr='1') then 
          next_state<=T1;
          else next_state<=T0;
          end if;
when T1=> next_state<=T2;
when T2=> if (n=0) then 
          next_state<=T3;
          else next_state<=T2;
          end if;
when T3=> next_state<=T4;
when T4=> next_state<=T0;

end case;

end process;

P2:process(clk)

variable R:std_logic_vector(6 downto 0);
variable n_temp: integer range -1 to 7;
variable p:std_logic;

begin 

if(clk'event and clk='1') then 
n_temp:=n;
case current_state is 

when T0=> if( WR='1') then 
           R:=date;
           n_temp:=7;
           p:='0';
           end if;
when T1=>  TXD<='0';
when T2=>  
           TXD<=R(0); 
           R:='0'&R(6 downto 1);
           n_temp:= n_temp-1;
           p:=p xor R(0);
when T3=> TXD<= P;
when T4=> TXD<='1';

end case;
n<=n_temp;
p_temp<=p;
r_temp<=r;
end if;
end process;

P3: process (clk,reset) 
begin 
if (reset='0')then 
current_state<=T0;
elsif(clk'event and clk='1')then
current_state<=next_state;
end if;

end process;


end BEHAVIOR;