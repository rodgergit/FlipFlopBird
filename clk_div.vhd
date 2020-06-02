library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
    port (
        clk:     in std_logic; -- 50 MHz input
        reset:   in std_logic;
        clk_out: out std_logic
    );
end entity clk_div;

-- half second clock
-- -----------------
-- the period of a 50 MHz clock is 20 ns, the frequency of a clock with a 0.5 s period is 2 Hz. the division factor is 25 million

-- to create a 2 Hz clock the output needs to be 0 for 12.5 million cycles of the 50 MHz clock and 1 for another 12.5 million cycles
-- since the count starts at 0 the actual value count must reach is 1 less than 12.5 million (12,499,999)

architecture arch1 of clk_div is
begin
    process (clk, reset)
        -- the minimum number of bits to hold a value of 12,499,999 is 24 bits (24 bis can cold 16,777,216 different values)
        variable count: unsigned(23 downto 0);
        variable clk_2s: std_logic := '0';
    begin
        if (reset = '1') then
            count := (others => '0');
        elsif (rising_edge(clk)) then
            if (count = to_unsigned(12499999, 24)) then
                -- once count reaches 12,499,999 it is reset to 0 and the clock signal is inverted, this repeats
                count := (others => '0');
                clk_2s := not clk_2s;
            else
                count := count + 1;
            end if;
        end if;

        clk_out <= clk_2s;

    end process;
end architecture arch1;

-- two second clock
-- ----------------
-- the period of a 50 MHz clock is 20 ns, the frequency of a clock with a 2 s period is 0.5 Hz. the division factor is 100 million

-- to create a 0.5 Hz clock the output needs to be 0 for 50 million cycles of the 50 MHz clock and 1 for another 50 million cycles
-- since the count starts at 0 the actual value count must reach is 1 less than 50 million (49,999,999)

architecture arch2 of clk_div is
begin
    process (clk, reset)
        -- the minimum number of bits to hold a value of 49,999,999 is 26 bits (26 bis can cold 67,108,864 different values)
        variable count: unsigned(25 downto 0);
        variable clk_2s: std_logic := '0';
    begin
        if (reset = '1') then
            count := (others => '0');
        elsif (rising_edge(clk)) then
            if (count = to_unsigned(49999999, 26)) then
                -- once count reaches 49,999,999 it is reset to 0 and the clock signal is inverted, this repeats
                count := (others => '0');
                clk_2s := not clk_2s;
            else
                count := count + 1;
            end if;
        end if;

        clk_out <= clk_2s;

    end process;
end architecture arch2;

-- three second clock
-- ------------------
-- the period of a 50 MHz clock is 20 ns, the frequency of a clock with a 3 s period is 0.3 Hz. the division factor is 150 million

-- to create a 0.3 Hz clock the output needs to be 0 for 75 million cycles of the 50 MHz clock and 1 for another 75 million cycles
-- since the count starts at 0 the actual value count must reach is 1 less than 75 million (74,999,999)

architecture arch3 of clk_div is
begin
    process (clk, reset)
        -- the minimum number of bits to hold a value of 74,999,999 is 27 bits (27 bis can cold 134,217,728 different values)
        variable count: unsigned(26 downto 0);
        variable clk_3s: std_logic := '0';
    begin
        if (reset = '1') then
            count := (others => '0');
        elsif (rising_edge(clk)) then
            if (count = to_unsigned(74999999, 27)) then
                -- once count reaches 74,999,999 it is reset to 0 and the clock signal is inverted, this repeats
                count := (others => '0');
                clk_3s := not clk_3s;
            else
                count := count + 1;
            end if;
        end if;

        clk_out <= clk_3s;

    end process;
end architecture arch3;

-- simulating
-- ----------
-- clock divider is bypassed as it is unfeasible to simulate

architecture arch4 of clk_div is
begin
    clk_out <= clk;
end architecture arch4;
