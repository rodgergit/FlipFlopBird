library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DisplayManager is 
	port(
	clk : in std_logic;
	r, g, b : out std_logic_vector(2 downto 0));
end entity DisplayManager;