library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lives_manager is
    port (
        clk:   in std_logic;
        reset: in std_logic;
        state: in std_logic_vector(2 downto 0);

        ground_on:  in std_logic;
        pipe_on:    in std_logic;
        bird_on:    in std_logic;
        powerup_on: in std_logic;

        lives_out: out std_logic_vector(1 downto 0)
    );
end entity lives_manager;

architecture arch of lives_manager is
    signal lives: unsigned(1 downto 0);
    signal bird_on_prev: std_logic;
begin
    process (clk, reset, state, lives)
        variable count: unsigned(26 downto 0);
    begin
        if (reset = '0' or state = "000") then
            lives <= "11";
            count := (others => '0');
        elsif (rising_edge(clk)) then
            if (state = "001" or state = "010" or state = "011") then
                if (ground_on = '1' and bird_on = '1' and bird_on_prev = '0') then
                    lives <= "00";
                elsif (pipe_on = '1' and bird_on = '1' and bird_on_prev = '0') then
                    lives <= lives - 1;
                elsif (powerup_on = '1' and bird_on = '1' and bird_on_prev = '0') then
                    lives <= lives + 1;
                end if;

                if (count = to_unsigned(74999999, 27)) then
                    count := (others => '0');
                    invincible <= '0';
                else
                    count := count + 1;
                end if;
            end if;
        end if;

        lives_out <= std_logic_vector(lives);
    end process;
end architecture arch;
