LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird IS
	PORT
		(SIGNAL mouse1, clk, vert_sync	: IN std_logic;
      SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		signal state : in std_logic_vector(2 downto 0);	
		signal bird_on : out std_logic;
		signal ground_on : out std_logic);
END bird;

architecture behavior of bird is

SIGNAL bird_signal					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL bird_y_pos				: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(320,10);
SiGNAL bird_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL bird_y_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);

-- bird_x_pos and bird_y_pos show the (x,y) for the centre of bird
bird_x_pos <= CONV_STD_LOGIC_VECTOR(320,11);

bird_signal <= '1' when ( ('0' & bird_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & bird_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & bird_y_pos <= pixel_row + size) and ('0' & pixel_row <= bird_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';




rgb:process (bird_signal)
begin

	bird_on <= bird_signal;
	
end process;


Move_Bird: process (vert_sync, mouse1, state)  	
begin
	-- Move bird once every vertical sync
	if (rising_edge(vert_sync)) then
	
		if(state = "000") then
			bird_y_pos <= CONV_STD_LOGIC_VECTOR(320,10);
			ground_on <= '0';
		end if;
	
		if(state = "001" or state = "010" or state = "011") then
		
			ground_on <= '0';
		
			-- Flap logic
			if (mouse1 = '1') then
				bird_y_motion <= - CONV_STD_LOGIC_VECTOR(3,10);
			else
				-- Falling logic
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);
			end if;
		
			-- Caps the bird to the top of the screen
			if (bird_y_pos <= size) then
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
			end if;
		
			-- Caps the bird to the bottom of the screen
			if ( ('0' & bird_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) ) then
				bird_y_motion <= -CONV_STD_LOGIC_VECTOR(2,10);
				ground_on <= '1';
			end if;
			
			
			bird_y_pos <= bird_y_pos + bird_y_motion;
			
		end if;
		
	end if;
end process Move_Bird;

END behavior;

