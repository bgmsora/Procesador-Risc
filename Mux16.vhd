library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux16 is
    Port ( in0, in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           salida : out  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC);
end Mux16;

architecture Behavioral of Mux16 is

begin
	
	process(sel, in0, in1)
	begin
		if(sel = '0') then
			salida <= in0;
		else
			salida <= in1;
		end if;
			
	end process;

end Behavioral;