----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2021 04:39:03 AM
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity counter is
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             button: in std_logic;
             cnt_out : out STD_LOGIC_VECTOR (3 downto 0));
end counter;

architecture Behavioral of counter is
  signal cnt: unsigned(3 downto 0);
  signal cnt_shift: std_logic_vector(3 downto 0);
  signal button_buf1, button_buf2, button_pulse: std_logic;
  signal clk_100Hz: std_logic;
  signal counter: integer range 0 to 99999;
  signal db_button: std_logic;
begin

--COUNTER DEFINITION....
counter_definition:process (clk)
begin
if clk'event and clk ='1' then
 if rst ='1' then
  cnt <= "0000";
 elsif button_pulse ='1' then
cnt <= cnt + 1;
end if; 
end if;
end process;
cnt_out<=std_logic_vector(cnt);

--CLOCK DEFINITION....
clock_divider_definition:process(clk)
begin
if clk'event and clk = '1' then
if counter < 99999 then
counter <= counter + 1;
 clk_100Hz <= '0';
else
counter <= 0;
clk_100Hz <= '1';
end if;
end if;
end process;

--SHIFT-REGISSTER DEFINITION....
shift_register_definition:process(clk)
begin
if clk'event and clk = '1' then
 if rst ='1' then
  cnt_shift <=(others=>'0');
  elsif clk_100Hz = '1' then
  cnt_shift(0) <= button;   
  cnt_shift(3 downto 1) <= cnt_shift (2 downto 0);
 end if;
 end if;
 end process;
db_button <= '1'  when cnt_shift = "1111" else '0'; 
 button_buf1 <= db_button when rising_edge(clk);
 button_buf2 <= button_buf1 when rising_edge(clk);
 button_pulse <= button_buf1 and not button_buf2;
end Behavioral;
