----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2021 04:44:00 AM
-- Design Name: 
-- Module Name: Counter_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CounterTb is
--  Port ( );
end CounterTb;
architecture Behavioral of CounterTb is
component counter
Port ( clk: in std_logic;
       rst: in std_logic;
       button: in std_logic;
       cnt_out: out std_logic_vector(3 downto 0)
);
end component;
signal clk_o, rst_o, button_o: std_logic;
signal cnt: std_logic_vector(3 downto 0);
begin
uut: counter port map(
clk => clk_o, 
rst=> rst_o, 
button => button_o, 
cnt_out => cnt);

clock_process : process
begin
clk_o <= '0'; wait for 10 ns;
clk_o <= '1'; wait for 10 ns;
end process;
button_proc: process
begin
button_o <= '0'; wait for 20 ms;
button_o <= '1'; wait for 20 ms;
button_o <= '0'; wait for 20 ms;
button_o <= '1'; wait for 20 ms;
button_o <= '0'; wait for 20 ms;
button_o <= '1'; wait for 20 ms;
button_o <= '0'; wait for 20 ms;
button_o <= '1'; wait for 20 ms;
end process;

reset_proc: process
begin
rst_o <= '1'; wait for 30 ns;
rst_o <= '0'; wait for 10 ns;
wait;
end process;
end Behavioral;