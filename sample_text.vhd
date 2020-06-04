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

begin 
	process(pixel_col, pixel_row)
		variable v_font_row, v_font_col: std_logic_vector(2 downto 0);
		variable v_character_address: std_logic_vector(5 downto 0);
		variable text_on_var : std_logic;
	begin	
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

			   else
					v_character_address := CONV_STD_LOGIC_VECTOR(32,6);
					text_on_var := '0';
				end if;

		character_address <= v_character_address;
		font_row <= v_font_row;
		font_col <= v_font_col;
		text_on <= text_on_var;
	end process;
end architecture behaviour;