library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
    port (
        -- control inputs
        clk:   in std_logic;
        reset: in std_logic; -- button 0
        pause: in std_logic; -- button 1
        conf:  in std_logic; -- button 2
        sel:   in std_logic; -- sw0

        -- status signals
        distance_passed: in std_logic;
        all_lives_lost:  in std_logic

        led_out: out std_logic_vector(8 downto 0)
    );
end entity control_unit;

architecture arch of control_unit is
    type state is (menu, level1, level2, level3, death, paused);

    signal current_state: state;
    signal next_state:    state;

    signal mode:       std_logic;
begin
    main: process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                current_state <= menu;
            else
                current_state <= next_state;
            end if;
        end if;
    end process main;

    output_decoder: process(current_state)
    begin
        case (current_state) is
            when menu =>
                led_out <= "10000000";
            when level1 =>
                led_out <= "01000000";
            when level2 =>
                led_out <= "00100000";
            when level3 =>
                led_out <= "00010000";
            when death =>
                led_out <= "00001000";
            when paused =>
                led_out <= "00000100";
            when others =>
                led_out <= "11111111";
        end case;
    end process output_decoder;

    next_state_decoder: process(current_state, pause, mode, distance_passed, all_lives_lost)
        variable resumed_state: state;
    begin
        next_state <= menu;
        case (current_state) is
            when menu =>
                if (conf = '1') then
                    mode <= sel;
                    next_state <= level1;
                end if;
            when level1 =>
                if (all_lives_lost = '1') then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state <= level1;
                elsif (mode = '1' and distance_passed = '1') then
                    next_state <= level2;
                end if;
            when level2 =>
                if (all_lives_lost = '1') then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state <= level2;
                elsif (mode = '1' and distance_passed = '1') then
                    next_state <= level3;
                end if;
            when level3 =>
                if (all_lives_lost = '1') then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state <= level3;
                end if;
            when death =>
                if (conf = '1') then
                    if (sel = '0') then
                        next_state <= menu;
                    elsif (sel = '1') then
                        next_state <= level1;
                    end if;
                end if;
            when paused =>
                if (pause = '1') then
                    next_state <= resumed;
                end if;
            when others =>
                next_state <= menu;
        end case;
    end process next_state_decoder;
end architecture arch;
