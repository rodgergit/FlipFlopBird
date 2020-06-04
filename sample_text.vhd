LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity sample_text is
	port(	pixel_row, pixel_col: IN std_logic_vector(9 downto 0);
			character_address: OUT std_logic_vector(5 downto 0);
			font_row, font_col: OUT std_logic_vector(2 downto 0);
			text_on : out std_logic);
end entity;

architecture behaviour of sample_text is

signal gameover : std_logic := '0';
signal menu : std_logic := '0';
signal game : std_logic := '1';

begin 
	process(pixel_col, pixel_row)
		variable v_font_row, v_font_col: std_logic_vector(2 downto 0);
		variable v_character_address: std_logic_vector(5 downto 0);
		variable text_on_var : std_logic;
	begin	
			if (menu = '1') then
				-- Flipflop bird
				--F
				if(pixel_col >= CONV_STD_LOGIC_VECTOR(192, 10)) and -- 192
					(pixel_col <= CONV_STD_LOGIC_VECTOR(224, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(6, 6);
					text_on_var := '1';
				--L
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(224, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(12, 6);
					text_on_var := '1';
				--I
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(9, 6);
					text_on_var := '1';
				--P
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(16, 6);
					text_on_var := '1';
		
		
				--Space
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(32, 6);
					text_on_var := '1';
				
					
				--F
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(384, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(6, 6);
					text_on_var := '1';
				--L
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(384, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(416, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(12, 6);
					text_on_var := '1';
				--O
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(416, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(448, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(15, 6);
					text_on_var := '1';
				--P
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(448, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(480, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(16, 6);
					text_on_var := '1';
				
				-- newline
				-- b
				elsif (pixel_col >= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(255, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(287, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(2, 6);
					text_on_var := '1';
					
				-- i
				elsif (pixel_col >= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(255, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(287, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(9, 6);
					text_on_var := '1';
					
				-- r
				elsif (pixel_col >= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(255, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(287, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(18, 6);
					text_on_var := '1';
				
				-- d
				elsif (pixel_col >= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(384, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(255, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(287, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(4, 6);
					text_on_var := '1';
					
			   else
					v_character_address := CONV_STD_LOGIC_VECTOR(32,6);
					text_on_var := '0';
				end if;
				
			elsif (gameover = '1') then
				
				--GAMEOVER
				--G
				if(pixel_col >= CONV_STD_LOGIC_VECTOR(192, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(224, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(7, 6);
					text_on_var := '1';
					
				--A
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(224, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(1, 6);
					text_on_var := '1';
					
				--M
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(13, 6);
					text_on_var := '1';
					
				--E
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
					
				--O
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(15, 6);
					text_on_var := '1';
					
				--V
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(352, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(384, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(22, 6);
					text_on_var := '1';
					
				--E
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(384, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(416, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
					
				--R
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(416, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(448, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(223, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(255, 10)) then
					v_font_row := pixel_row(4 downto 2);
					v_font_col := pixel_col(4 downto 2);
					v_character_address := CONV_STD_LOGIC_VECTOR(18, 6);
					text_on_var := '1';
					
				else
					v_character_address := CONV_STD_LOGIC_VECTOR(32,6);
					text_on_var := '0';
				end if;
				
				
			elsif (game = '1') then
				
				--Life
				--L
				if(pixel_col >= CONV_STD_LOGIC_VECTOR(32, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(48, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(12, 6);
					text_on_var := '1';
				
				--i
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(48, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(64, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(9, 6);
					text_on_var := '1';
				
				--f
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(64, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(80, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(6, 6);
					text_on_var := '1';
					
				--e	
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(80, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(96, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
			
			
				--Score
				--S
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(256, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(272, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(19, 6);
					text_on_var := '1';
					
				--C
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(272, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(3, 6);
					text_on_var := '1';
					
				--O
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(288, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(304, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(15, 6);
					text_on_var := '1';
					
				--R
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(304, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(18, 6);
					text_on_var := '1';
					
				--E
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(320, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(336, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
					
				--Level
				--L
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(512, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(528, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(12, 6);
					text_on_var := '1';
					
				--e
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(528, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(544, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
					
				--v
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(544, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(560, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(22, 6);
					text_on_var := '1';
					
				--e
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(560, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(576, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(5, 6);
					text_on_var := '1';
					
				--l
				elsif(pixel_col >= CONV_STD_LOGIC_VECTOR(576, 10)) and
					(pixel_col <= CONV_STD_LOGIC_VECTOR(592, 10)) and
					(pixel_row >= CONV_STD_LOGIC_VECTOR(31, 10)) and
					(pixel_row <= CONV_STD_LOGIC_VECTOR(47, 10)) then
					v_font_row := pixel_row(3 downto 1);
					v_font_col := pixel_col(3 downto 1);
					v_character_address := CONV_STD_LOGIC_VECTOR(12, 6);
					text_on_var := '1';
					
				else
					v_character_address := CONV_STD_LOGIC_VECTOR(32,6);
					text_on_var := '0';
				end if;
			
			end if;

		character_address <= v_character_address;
		font_row <= v_font_row;
		font_col <= v_font_col;
		text_on <= text_on_var;
	end process;
end architecture behaviour;