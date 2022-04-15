-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end test;

architecture behavior_T of test is

component Parallel_To_Serial is
 port( CLK, RESET, WR: in std_logic;
 Date : in std_logic_vector(6 downto 0);
 TXD : out std_logic);
end component;

--input signal
signal CLK,WR:std_logic:='0';
signal RESET:std_logic:='1';
signal Date :std_logic_vector(6 downto 0):=(others=>'0');

--output signal
signal TXD :std_logic:='0';

--clk_period
constant clk_period: time:=12ns;

begin 

--maping
uut:Parallel_To_Serial port map(
CLK=>CLK,
WR=>WR,
RESET=>RESET,
DATE=>DATE,
TXD=>TXD
);

clock_generate: process
begin
clk<='0';
wait for clk_period/2;
clk<='1';
wait for clk_period/2;

end process;

main_process:process
begin
reset<='0';
wr<='0';
wait for clk_period*5;
reset<='1';
wait for clk_period*3;
wr<='1';
date<="1010100";
wait for clk_period*2;
wr<='0';
wait for clk_period*15;
wr<='1';
date<="1011100";
wait for clk_period*2;
wr<='0';
wait for clk_period*15;
wr<='1';
date<="0000000";
wait for clk_period*2;
wr<='0';
wait for clk_period*15;
wr<='1';
date<="1111111";
wait for clk_period*2;
wr<='0';
wait for clk_period*15;
reset<='0';
wait for clk_period*5;

wait;
end process;
end behavior_T;
