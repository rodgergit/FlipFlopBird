LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird IS
	PORT
		(SIGNAL mouse1, clk, vert_sync	: IN std_logic;
        SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL red, green, blue 			: OUT std_logic;		
		signal bird_on : out std_logic);
END bird;

architecture behavior of bird is

SIGNAL bird_signal					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);
signal placeholderPB1 : std_logic := '1';
signal placeholderPB2 : std_logic := '0';

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);

-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(320,11);

bird_signal <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';




rgb:process (bird_signal)
begin

	bird_on <= bird_signal;

	-- Colours for pixel data on video signal
	-- Changing the background and ball colour by pushbuttons
	Red <=  '1'; -- pb1
	Green <= not bird_signal; --pb2
	Blue <=  not bird_signal;
	
end process;


Move_Bird: process (vert_sync, mouse1)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then
		
		-- Flap logic
		if (mouse1 = '1') then
			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(3,10);
		else
			-- Falling logic
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		
		-- Caps the bird to the top of the screen
		if (ball_y_pos <= size) then
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		
		-- Caps the bird to the bottom of the screen
		if ( ('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) ) then
			ball_y_motion <= -CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		
		ball_y_pos <= ball_y_pos + ball_y_motion;
		
	end if;
end process Move_Bird;

END behavior;

