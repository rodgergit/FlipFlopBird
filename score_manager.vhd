library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity score_manager is
    port (
        clk:   in std_logic;
        reset: in std_logic;
        state: in std_logic_vector(2 downto 0);

        pipe_passed: in std_logic;

        score_out: out std_logic_vector(8 downto 0)
    );
end entity score_manager;

architecture arch of score_manager is
    signal score: unsigned(8 downto 0);
begin
    process (clk, reset, state, score)
    begin
        if (reset = '0' or state = "000") then
            score <= to_unsigned(0, 9);
        elsif (rising_edge(clk)) then
            if (state = "001" or state = "010" or state = "011") then
                if (pipe_passed = '1') then
                    score <= score + 10;
                end if;
            end if;
        end if;

        score_out <= std_logic_vector(score);
    end process;
end architecture arch;