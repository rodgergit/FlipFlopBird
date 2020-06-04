LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY power_up IS
	PORT
		(SIGNAL clk, vert_sync								: IN std_logic;
       SIGNAL pixel_row, pixel_column					: IN std_logic_vector(9 DOWNTO 0);
		 SIGNAL score : IN std_logic_vector(8 downto 0); -- change to pipes passed
		 SIGNAL random_num 									: IN std_logic_vector(2 downto 0);
		 SIGNAL state : IN std_logic_vector(2 downto 0);
		 SIGNAL red, green, blue, powerUp_on				: OUT std_logic);		
END power_up;

architecture behavior of power_up is





SIGNAL y_pos_gen           : std_logic_vector(9 downto 0);



SiGNAL gap_x_motion			: std_logic_vector(10 DOWNTO 0);



-------------------- power up item

-- power up position
-------------------------------------------------------------------------------------
signal powerUp_y_pos       : std_logic_vector(9 downto 0);  
signal powerUp_x_pos       : std_logic_vector(10 downto 0); 
-------------------------------------------------------------------------------------


signal t_powerUp_on : std_logic;


-- power up shape
-------------------------------------------------------------------------------------
signal powerUp_sizeOne_x : std_logic_vector(10 downto 0); 
signal powerUp_sizeTwo_x : std_logic_vector(10 downto 0);
signal powerUp_sizeThree_x : std_logic_vector(10 downto 0);

signal powerUp_sizeOne_y : std_logic_vector(9 downto 0);
signal powerUp_sizeTwo_y : std_logic_vector(9 downto 0);
signal powerUp_sizeThree_y : std_logic_vector(9 downto 0);
-------------------------------------------------------------------------------------



signal score_checkpoint : std_logic_vector(8 downto 0); -- change to pipes passed checky
BEGIN   

gap_x_motion <= CONV_STD_LOGIC_VECTOR(0,11) when state = "000" else -- need input from control unit , state
					 CONV_STD_LOGIC_VECTOR(1,11) when state = "001" else
					 CONV_STD_LOGIC_VECTOR(2,11) when state = "010" else
					 CONV_STD_LOGIC_VECTOR(3,11) when state = "011" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "100" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "101" else
					 CONV_STD_LOGIC_VECTOR(0,11) when state = "111" else
					 CONV_STD_LOGIC_VECTOR(0,11);
					 



-- powerup shape
-------------------------------------------------------------------------------------
powerUp_sizeOne_x <= CONV_STD_LOGIC_VECTOR(5, 11); 
powerUp_sizeTwo_x <= CONV_STD_LOGIC_VECTOR(10, 11);
powerUp_sizeThree_x <= CONV_STD_LOGIC_VECTOR(15, 11);

powerUp_sizeOne_y <= CONV_STD_LOGIC_VECTOR(5, 10);
powerUp_sizeTwo_y <= CONV_STD_LOGIC_VECTOR(10, 10);
powerUp_sizeThree_y <= CONV_STD_LOGIC_VECTOR(15, 10);
-------------------------------------------------------------------------------------

gapGen : process (random_num)
begin	
	
	case random_num is
		
		when "010" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(110, 10);
		when "001" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(150, 10);
		when "110" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(100, 10);
		when "100" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(190, 10);
		when "111" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(350, 10);
		when "011" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(220, 10);
		when "101" => y_pos_gen <= CONV_STD_LOGIC_VECTOR(260, 10);
		when others => y_pos_gen <= CONV_STD_LOGIC_VECTOR(250,10);
	end case;

end process gapGen ;

-- shape to display
-------------------------------------------------------------------------------------
powerUp_on <= t_powerUp_on;
t_powerUp_on <= '1' when (((('0' & (powerUp_y_pos - powerUp_sizeThree_y) <= '0' & pixel_row) and ('0' & pixel_row <= '0' & powerUp_y_pos )) and 
								(('0' & (powerUp_x_pos - powerUp_sizeTwo_x) <= '0' & pixel_column) and ('0' & pixel_column <= '0' & (powerUp_x_pos - powerUp_sizeOne_x)))) or 
							((('0' & powerUp_y_pos - powerUp_sizetwo_y <= '0' & pixel_row) and ('0' & pixel_row <= '0' & (powerup_y_pos - powerUp_sizeOne_y))) and 
							  (('0' & (powerUp_x_pos - powerUp_sizeThree_x) <= '0' & pixel_column) and ('0' & pixel_column <= '0' & powerUp_x_pos))))	
						else 
							'0';

-------------------------------------------------------------------------------------




Red <= (t_powerUp_on); 
Green <= '1' and (not t_powerUp_on) ; --pb1
Blue <=  (not t_powerUp_on) ; 

powerUpMovement: process (vert_sync, powerUp_x_pos, gap_x_motion, score)
begin

	if (rising_edge(vert_sync)) then
		if (score = score_checkpoint + "001100100") then
			score_checkpoint <= score;
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

END behavior;

