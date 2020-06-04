LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		(SIGNAL clk, vert_sync								: IN std_logic;
       SIGNAL pixel_row, pixel_column					: IN std_logic_vector(9 DOWNTO 0);
		 SIGNAL random_num 									: IN std_logic_vector(2 downto 0); -- for random pipe height genneration 
		 signal state : in std_logic_vector(2 downto 0); -- to determine speed
		 SIGNAL red, green, blue, pipe_on				: OUT std_logic; -- for display
		 signal pipe_passed : out std_logic); -- connects to control unit which counts pipes
		 
END pipes;

architecture behavior of pipes is

signal pipes_on 				: std_logic; -- signal for pipe_on output signal



SIGNAL y_pos_gen           : std_logic_vector(9 downto 0); -- randomly assigns pipe height on spawn
SIGNAL y_pos_gen_two       : std_logic_vector(9 downto 0); -- randomly assigns pipe height of second pipe on spawn

SIGNAL gap_y_pos				: std_logic_vector(9 DOWNTO 0)  := CONV_STD_LOGIC_VECTOR(350,10); -- y position of gap zero (pipe)
SiGNAL gap_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11);  -- x position of gap zero (pipe)
SIGNAL gapOne_y_pos			: std_logic_vector(9 DOWNTO 0)  := CONV_STD_LOGIC_VECTOR(300,10);   -- y position of gap one (pipe one)
SiGNAL gapOne_x_pos			: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(999,11);   -- x position of gap one (pipe one)

SiGNAL gap_x_motion			: std_logic_vector(10 DOWNTO 0);  -- only motion that controls all pipes
SIGNAL gap_size_x 			: std_logic_vector(10 DOWNTO 0);  -- fixed width of pipes
SIGNAL gap_size_y  			: std_logic_vector(9 DOWNTO 0);   -- fixed distance between upper and lower pipes



signal pipeOne_passed : std_logic;  -- used to count pipes
signal pipeZero_passed : std_logic;  -- used to count pipes

signal pipeOne_AlreadyPassed_flag : std_logic := '0';   -- used inn the counting of pipes
signal pipeZero_AlreadyPassed_flag : std_logic := '0';   -- used in the counting of pipes


--signal difficulty_level : std_logic_vector(1 downto 0) := "00"; -- 00 = easy / 01 = med /  10 = hard


--signal tenPipe_checkpoint : integer := 0;
BEGIN   


					 
					 
	--gap_x_motion <= conv_STD_LOGIC_VECTOR(1,11); -- must be changed to below
gap_x_motion <= CONV_STD_LOGIC_VECTOR(0,11) when state = "000" else -- need input from control unit , state
					 CONV_STD_LOGIC_VECTOR(1,11) when state = "001" else
					 CONV_STD_LOGIC_VECTOR(2,11) when state = "010" else
					 CONV_STD_LOGIC_VECTOR(3,11) when state = "011" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "100" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "101" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "111" else
					 CONV_STD_LOGIC_VECTOR(0,11);
					 


gap_size_x <= CONV_STD_LOGIC_VECTOR(100, 11); --fixed size
gap_size_y <= CONV_STD_LOGIC_VECTOR(75, 10);   -- fixed size




gapGen : process (random_num) -- generates the pseudo random height of gap between pipes
begin	
	
	case random_num is   -- based on random number input
		
		when "010" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(110, 10);   -- pipe one
						  y_pos_gen_two <= CONV_STD_LOGIC_VECTOR(230, 10);  -- pipe two
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

-------------------------------------------------------------

pipe_on <= pipes_on;   -- for display
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

Red <= (not '0') and ( not pipes_on) ; --and (t_powerUp_on); 
Green <= '1' ;-- and (not t_powerUp_on) ; --pb1
Blue <= (not pipes_on); -- and (not t_powerUp_on) ; 



gapPipeZero: process (vert_sync, gap_x_pos, state)
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then
		
		if (state = "000") then
			gap_x_pos <= conv_STD_LOGIC_VECTOR(639, 11);
		else
	
			if ( gap_x_pos  <= CONV_STD_LOGIC_VECTOR(1,11) ) then -- whhen the pipe slides off the screen
				gap_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x; -- reset it to the other side
				gap_y_pos <= y_pos_gen_two; -- generate a new height
				pipeZero_AlreadyPassed_flag <= '0'; ---- reset flag to 0 
			else
				if ( gap_x_pos  <= CONV_STD_LOGIC_VECTOR(320,11) and pipeZero_AlreadyPassed_flag = '0'  ) then -- record pipe as passed when it passes half way
					pipeZero_passed <= '1';
					pipeZero_AlreadyPassed_flag <= '1';  -- put flag up to stop multiple pipe passeds for one pipe	
				end if;
				gap_x_pos <= gap_x_pos - gap_x_motion;--
			end if;
		end if;
	end if;
end process gapPipeZero;

gapPipeOne: process (vert_sync, gapOne_x_pos, state)  	
begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync)) then

		if (state = "000") then
			gapOne_x_pos <= conv_STD_LOGIC_VECTOR(999, 11);
		else
		--reset posiition
			if ( gapOne_x_pos  <= CONV_STD_LOGIC_VECTOR(1,11) ) then
				gapOne_x_pos <= CONV_STD_LOGIC_VECTOR(639, 11) + gap_size_x;
				gapOne_y_pos <= y_pos_gen_two;
				pipeOne_AlreadyPassed_flag <= '0';
			else
				if ( gapOne_x_pos  <= CONV_STD_LOGIC_VECTOR(320,11) and pipeZero_AlreadyPassed_flag = '0' ) then
					pipeOne_passed <= '1';
					pipeone_AlreadyPassed_flag <= '1';
				end if;
				gapOne_x_pos <= gapOne_x_pos - gap_x_motion;--	
			end if;
		end if;
	end if;
end process gapPipeOne;

pipe_passed <= pipeOne_passed or pipeZero_passed; -- send to control unit


END behavior;

