library ieee;
use ieee.std_logic_1164.all;

entity click_pulse is
    port (
        clk: in std_logic;

        mouse1: in std_logic;
        mouse2: in std_logic;

        mouse1_pulse: out std_logic;
        mouse2_pulse: out std_logic
    );
end entity click_pulse;

architecture arch of click_pulse is
    signal mouse1_prev: std_logic;
    signal mouse2_prev: std_logic;
begin
    process(clk, mouse1, mouse1_prev, mouse2, mouse2_prev)
    begin
        if (rising_edge(clk)) then
            if (mouse1 = '1' and mouse1_prev = '0') then
                mouse1_pulse <= '1';
            else
                mouse1_pulse <= '0';
            end if;
            mouse1_prev <= mouse1;

            if (mouse2 = '1' and mouse2_prev = '0') then
                mouse2_pulse <= '1';
            else
                mouse2_pulse <= '0';
            end if;
            mouse2_prev <= mouse2;
        end if;
    end process;
end architecture arch;
