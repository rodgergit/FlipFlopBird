LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		(SIGNAL clk, vert_sync								: IN std_logic;
       SIGNAL pixel_row, pixel_column					: IN std_logic_vector(9 DOWNTO 0);
		 SIGNAL random_num 									: IN std_logic_vector(2 downto 0);
		 SIGNAL red, green, blue, pipe_on				: OUT std_logic);		
END pipes;

architecture behavior of pipes is

signal pipes_on 				: std_logic;



SIGNAL y_pos_gen           : std_logic_vector(9 downto 0);
SIGNAL y_pos_gen_two       : std_logic_vector(9 downto 0);

SIGNAL gap_y_pos				: std_logic_vector(9 DOWNTO 0)  := CONV_STD_LOGIC_VECTOR(350,10);
SiGNAL gap_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11);
SIGNAL gapOne_y_pos			: std_logic_vector(9 DOWNTO 0)  := CONV_STD_LOGIC_VECTOR(300,10);
SiGNAL gapOne_x_pos			: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(999,11);

SiGNAL gap_x_motion			: std_logic_vector(10 DOWNTO 0);
SIGNAL gap_size_x 			: std_logic_vector(10 DOWNTO 0);
SIGNAL gap_size_y  			: std_logic_vector(9 DOWNTO 0);


-------------------- power up item

signal powerUp_y_pos       : std_logic_vector(9 downto 0);
signal powerUp_x_pos       : std_logic_vector(10 downto 0);



signal powerUp_on : std_logic;


signal powerUp_sizeOne_x : std_logic_vector(10 downto 0); 
signal powerUp_sizeTwo_x : std_logic_vector(10 downto 0);
signal powerUp_sizeThree_x : std_logic_vector(10 downto 0);

signal powerUp_sizeOne_y : std_logic_vector(9 downto 0);
signal powerUp_sizeTwo_y : std_logic_vector(9 downto 0);
signal powerUp_sizeThree_y : std_logic_vector(9 downto 0);



signal difficulty_level : std_logic_vector(1 downto 0) := "00"; -- 00 = easy / 01 = med /  10 = hard
signal pipes_passed : integer := 0;

signal tenPipe_checkpoint : integer := 0;
BEGIN   

gap_x_motion <= CONV_STD_LOGIC_VECTOR(1,11) when difficulty_level = "00" else
					 CONV_STD_LOGIC_VECTOR(2,11) when difficulty_level = "01" else
					 CONV_STD_LOGIC_VECTOR(3,11) when difficulty_level = "10" else
					 CONV_STD_LOGIC_VECTOR(1,11);


gap_size_x <= CONV_STD_LOGIC_VECTOR(100, 11);
gap_size_y <= CONV_STD_LOGIC_VECTOR(75, 10);


powerUp_sizeOne_x <= CONV_STD_LOGIC_VECTOR(5, 11); 
powerUp_sizeTwo_x <= CONV_STD_LOGIC_VECTOR(10, 11);
powerUp_sizeThree_x <= CONV_STD_LOGIC_VECTOR(15, 11);

powerUp_sizeOne_y <= CONV_STD_LOGIC_VECTOR(5, 10);
powerUp_sizeTwo_y <= CONV_STD_LOGIC_VECTOR(10, 10);
powerUp_sizeThree_y <= CONV_STD_LOGIC_VECTOR(15, 10);


gapGen : process (random_num)
begin	
	
	case random_num is
		
		when "010" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(110, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(230, 10);
		when "001" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(150, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(400, 10);
		when "110" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(100, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(320, 10);
		when "100" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(190, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(260, 10);
		when "111" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(350, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(130, 10);
		when "011" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(220, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(264, 10);
		when "101" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(260, 10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(289, 10);
		when others => y_pos_gen <= CONV_STD_LOGIC_VECTOR(250,10);
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(440, 10);
	end case;

end process gapGen ;
------------------------------------------------------------

powerUp_on <= '1' when (((('0' & (powerUp_y_pos - powerUp_sizeThree_y) <= '0' & pixel_row) and ('0' & pixel_row <= '0' & powerUp_y_pos )) and 
								(('0' & (powerUp_x_pos - powerUp_sizeTwo_x) <= '0' & pixel_column) and ('0' & pixel_column <= '0' & (powerUp_x_pos - powerUp_sizeOne_x)))) or 
							((('0' & powerUp_y_pos - powerUp_sizetwo_y <= '0' & pixel_row) and ('0' & pixel_row <= '0' & (powerup_y_pos - powerUp_sizeOne_y))) and 
							  (('0' & (powerUp_x_pos - powerUp_sizeThree_x) <= '0' & pixel_column) and ('0' & pixel_column <= '0' & powerUp_x_pos))))	
						else 
							'0';

-------------------------------------------------------------

pipe_on <= pipes_on;
pipes_on <= '1' when ((('0' & gap_x_pos - gap_size_x <= '0' & pixel_column) and -- first pipe
							('0' & pixel_column <= '0' & gap_x_pos ) and 
							(('0' & gap_y_pos + gap_size_y <= '0' & pixel_row) or 
							('0' & gap_y_pos - gap_size_y >= '0' & pixel_row)))or -- second pipe
							( ( ('0' & gapOne_x_pos - gap_size_x <= '0' & pixel_column) and 
							('0' & pixel_column <= '0' & gapOne_x_pos ) and 
							(('0' & gapOne_y_pos + gap_size_y <= '0' & pixel_row) or 
							('0' & gapOne_y_pos - gap_size_y >= '0' & pixel_row)) )))	
					 else 
							'0';	

-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons

Red <= (not '0') and ( not pipes_on) and (powerUp_on); 
Green <= '1' and (not powerUp_on) ; --pb1
Blue <= (not pipes_on) and (not powerUp_on) ; 

powerUpMovement: process (vert_sync, powerUp_x_pos, gap_x_motion, pipes_passed)

begin

	if (rising_edge(vert_sync)) then
	
		if (pipes_passed = (tenPipe_checkpoint + 10)) then
			powerUp_x_pos <= CONV_STD_LOGIC_VECTOR(900,11);
			powerUp_y_pos <= y_pos_gen;
		else
			
			if(powerUp_x_pos <= CONV_STD_LOGIC_VECTOR(1,11)) then
				powerUp_x_pos <= CONV_STD_LOGIC_VECTOR(1,11);
			else
				powerUp_x_pos <= powerUp_x_pos - gap_x_motion;
			end if;
		end if;
			
	
	end if;

end process powerUpMovement;





gapPipe: process (vert_sync, gap_x_pos, pipes_passed)
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then
	
		-- Reset pipe position once it reaches the end of the screen
		if ( gap_x_pos <= CONV_STD_LOGIC_VECTOR(1,11) ) then
			gap_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x;
			gap_y_pos <= y_pos_gen;
			
			if pipes_passed = (tenPipe_checkpoint + 10) then
			
					if difficulty_level /= "10" then
							difficulty_level <= difficulty_level + "01";
					end if;
					
				tenPipe_checkpoint <= pipes_passed;
				
				
			end if;
			
			pipes_passed <= (pipes_passed + 2);
			
		else
			gap_x_pos <= gap_x_pos - gap_x_motion;
			
		end if;

	end if;
end process gapPipe;

gapPipeOne: process (vert_sync, gapOne_x_pos, pipes_passed)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then

		-- Bounce off top or bottom of the screen
		if ( gapOne_x_pos   <= CONV_STD_LOGIC_VECTOR(1,11) ) then
			gapOne_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x;
			gapOne_y_pos <= y_pos_gen_two;
					
		else
			gapOne_x_pos <= gapOne_x_pos - gap_x_motion;--
		end if;
		
	end if;
end process gapPipeOne;




END behavior;

