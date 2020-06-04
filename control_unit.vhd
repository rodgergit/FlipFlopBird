library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port (
        -- control inputs
        clk:   in std_logic;
        reset: in std_logic; -- button 0
        sel:   in std_logic; -- sw0
        conf:  in std_logic; -- mouse1
        pause: in std_logic; -- mouse2

        -- status signals
        lives: in std_logic_vector(1 downto 0);
        score: in std_logic_vector(8 downto 0);

        -- control signals
        state_out: out std_logic_vector(2 downto 0);
        mode_out:  out std_logic;

        -- control outputs
        led_out: out std_logic_vector(9 downto 0)
    );
end entity control_unit;

architecture arch of control_unit is
    type state_type is (menu, level1, level2, level3, death, paused);
    signal state:      state_type;
    signal next_state: state_type;

    signal mode:  std_logic;
begin
    main: process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                state <= menu;
            else
                state <= next_state;
            end if;
        end if;
    end process main;

    output_decoder: process (state)
    begin
        case (state) is
            when menu =>
                state_out <= "000";
                led_out <= "1000000000";
            when level1 =>
                state_out <= "001";
                led_out <= "0100000000";
            when level2 =>
                state_out <= "010";
                led_out <= "0010000000";
            when level3 =>
                state_out <= "011";
                led_out <= "0001000000";
            when death =>
                state_out <= "100";
                led_out <= "0000100000";
            when paused =>
                state_out <= "101";
                led_out <= "0000010000";
            when others =>
                state_out <= "111";
                led_out <= "1111111111";
        end case;
    end process output_decoder;

    next_state_decoder: process (state, sel, conf, pause, lives, score, mode)
        variable resumed_state: state_type;
    begin
        case (state) is
            when menu =>
                if (conf = '1') then
                    mode <= sel;
                    mode_out <= sel;
                    next_state <= level1;
                else
                    next_state <= menu;
                end if;
            when level1 =>
                if (lives = "00") then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state := level1;
                elsif (mode = '1' and score = "001100100") then
                    next_state <= level2;
                else
                    next_state <= level1;
                end if;
            when level2 =>
                if (lives = "00") then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state := level2;
                elsif (mode = '1' and score = "011001000") then
                    next_state <= level3;
                else
                    next_state <= level2;
                end if;
            when level3 =>
                if (lives = "00") then
                    next_state <= death;
                elsif (pause = '1') then
                    next_state <= paused;
                    resumed_state := level3;
                else
                    next_state <= level3;
                end if;
            when death =>
                if (conf = '1') then
                    next_state <= menu;
                else
                    next_state <= death;
                end if;
            when paused =>
                if (pause = '1') then
                    next_state <= resumed_state;
                else
                    next_state <= paused;
                end if;
            when others =>
                next_state <= menu;
        end case;
    end process next_state_decoder;
end architecture arch;
