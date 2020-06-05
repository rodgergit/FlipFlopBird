library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DisplayManager is 
	port(
	clk : in std_logic;
	text_on : in std_logic;
	bird_on : in std_logic;
	pipe_on : in std_logic;
	powerUp_on : in std_logic;
	rom_data : in std_logic;
	r, g, b : out std_logic);
end entity DisplayManager;

architecture behaviour of DisplayManager is

begin

	pixel: process
	
	begin
	
	wait until clk'event and clk ='1';
	
	if text_on = '1' then
		r <= rom_data;
		g <= rom_data;
		b <= '0';
		
	elsif bird_on = '1' then
		r <= '1';
		g <= '0';
		b <= '0';
	
	elsif pipe_on = '1' then
		r <= '0';
		g <= '1';
		b <= '0';
		
	elsif powerUp_on = '1' then
		r <= '0';
		g <= '0';
		b <= '1';
		
	else
		r <= '0';
		g <= '0';
		b <= '0';
		
	end if;

		
	end process pixel;
	
	end architecture;