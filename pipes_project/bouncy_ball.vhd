LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		(SIGNAL pb1, pb2, clk, vert_sync, horiz_sync	: IN std_logic;
       SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		 SIGNAL random_num : IN std_logic_vector(2 downto 0);
		 SIGNAL red, green, blue 			: OUT std_logic);		
END bouncy_ball;

architecture behavior of bouncy_ball is



SIGNAL size_x 					: std_logic_vector(9 DOWNTO 0);
SIGNAL size_y  				: std_logic_vector(9 DOWNTO 0);



signal placeholderPB1 : std_logic := '1';
signal placeholderPB2 : std_logic := '0';

signal pipe_on             : std_logic;
SIGNAL y_pos_gen           : std_logic_vector(9 downto 0);
SIGNAL gap_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL gap_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11);
SIGNAL gap_y_motion			: std_logic_vector(9 DOWNTO 0);
SiGNAL gap_x_motion			: std_logic_vector(10 DOWNTO 0);
SIGNAL gap_size_x 					: std_logic_vector(10 DOWNTO 0);
SIGNAL gap_size_y  				: std_logic_vector(9 DOWNTO 0);

signal pipeOne_on             : std_logic;
SIGNAL gapOne_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL gapOne_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(350,11);


BEGIN   



gap_x_motion <= CONV_STD_LOGIC_VECTOR(1,11);
gap_size_x <= CONV_STD_LOGIC_VECTOR(100, 11);
gap_size_y <= CONV_STD_LOGIC_VECTOR(75, 10);

--gap_y_pos <= CONV_STD_LOGIC_VECTOR(150, 10);
--gapOne_y_pos <= CONV_STD_LOGIC_VECTOR(250, 10);

gapGen : process (random_num)
begin	
	
	case random_num is
		when "110" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(90, 10);
		when "010" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(110, 10);
		when "001" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(150, 10);
		when "100" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(190, 10);
		when "011" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(220, 10);
		when "101" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(260, 10);
		when "111" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(400, 10);
		when others => y_pos_gen <= CONV_STD_LOGIC_VECTOR(250,10);
		
	end case;

end process gapGen ;
--		
--pipe_on <= '1' when ( ('0' & gap_x_pos - gap_size_x <= '0' & pixel_column) and ('0' & pixel_column <= '0' & gap_x_pos + gap_size_x) and 
--				(('0' & gap_y_pos + gap_size_y <= '0' & pixel_row) or ('0' & gap_y_pos - gap_size_y >= '0' & pixel_row)) )	-- x_pos - size <= pixel_column <= x_pos + size
--				else 
--				'0';	

pipe_on <= '1' when ( ('0' & gap_x_pos - gap_size_x <= '0' & pixel_column) and ('0' & pixel_column <= '0' & gap_x_pos ) and 
				(('0' & gap_y_pos + gap_size_y <= '0' & pixel_row) or ('0' & gap_y_pos - gap_size_y >= '0' & pixel_row)) )	-- x_pos - size <= pixel_column <= x_pos + size
				else 
				'0';	
			
pipeOne_on <= '1' when ( ('0' & gapOne_x_pos - gap_size_x <= '0' & pixel_column) and ('0' & pixel_column <= '0' & gapOne_x_pos ) and 
				(('0' & gapOne_y_pos + gap_size_y <= '0' & pixel_row) or ('0' & gapOne_y_pos - gap_size_y >= '0' & pixel_row)) )	-- x_pos - size <= pixel_column <= x_pos + size
				else 
				'0';		


-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons

Red <= (not placeholderPB2) and ( not pipe_on) and (not pipeOne_on); -- and (not lowPipe_on) and (not topPipe_on) ; --pb2
Green <= placeholderPB1 ; --pb1
Blue <= (not pipe_on) and (not pipeOne_on); -- (not lowPipe_on) and (not topPipe_on) ;


gapPipe: process (vert_sync, gap_x_pos)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then

		-- Bounce off top or bottom of the screen
		if ( gap_x_pos <= CONV_STD_LOGIC_VECTOR(1,11) ) then
			gap_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x;
			gap_y_pos <= y_pos_gen;
			
		else
			gap_x_pos <= gap_x_pos - gap_x_motion;--
		end if;

		
	end if;
end process gapPipe;

gapPipeOne: process (vert_sync, gapOne_x_pos)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then

		-- Bounce off top or bottom of the screen
		if ( gapOne_x_pos   <= CONV_STD_LOGIC_VECTOR(1,11) ) then
			gapOne_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x;
			gapOne_y_pos <= y_pos_gen;
			
			
		else
			gapOne_x_pos <= gapOne_x_pos - gap_x_motion;--
		end if;

		
	end if;
end process gapPipeOne;




END behavior;

