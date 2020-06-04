library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_decoder is
    port (
        bcd: in std_logic_vector(1 downto 0);
        ss:  out std_logic_vector(7 downto 0)
    );
end entity seven_seg_decoder;

architecture arch of seven_seg_decoder is
begin
    ss <= "00000011" when bcd = "00" else -- 0
          "10011111" when bcd = "01" else -- 1
          "00100101" when bcd = "10" else -- 2
          "00001101" when bcd = "11" else -- 3
          "11111111";
end architecture arch;
