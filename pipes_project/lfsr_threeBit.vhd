library ieee; 
use ieee.std_logic_1164.all;

entity lfsr_threeBit is 
port (
  i_clk           : in  std_logic;
  o_lfsr          : out std_logic_vector (2 downto 0));
end lfsr_threeBit;

architecture rtl of lfsr_threeBit is  
	
	signal r_lfsr           : std_logic_vector (2 downto 0) := "110";

begin  
o_lfsr  <= r_lfsr(2 downto 0);

p_lfsr : process (i_clk) begin 
  
  if rising_edge(i_clk) then 
    
      r_lfsr(2) <= r_lfsr(0) ;
      r_lfsr(1) <= r_lfsr(2);
      r_lfsr(0) <= r_lfsr(1) xor r_lfsr(2);
    
  end if; 
end process p_lfsr; 

end architecture rtl;