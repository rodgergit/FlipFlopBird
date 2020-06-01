library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
    port (
        clk:   in std_logic;
        reset: in std_logic
    );
end entity control_unit;

architecture arch of control_unit is
    type state is (level1, level2, level3, death);
begin

end architecture arch;
