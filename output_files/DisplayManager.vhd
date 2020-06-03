library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DisplayManager is 
	port(
	clk : in std_logic;
	bird_on : in std_logic;
	pipe_on : in std_logic;
	r, g, b : out std_logic);
end entity DisplayManager;

architecture behaviour of DisplayManager is

begin

	pixel: process
	
	begin
	
	wait until clk'event and clk ='1';
	
	if bird_on = '1' then
		r <= '1';
		g <= '0';
		b <= '0';
		
	elsif pipe_on = '1' then
		r <= '0';
		g <= '1';
		b <= '0';
		
	else
		r <= '0';
		g <= '1';
		b <= '1';
		
	end if;

		
	end process pixel;
	
	end architecture;