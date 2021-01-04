
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux4 is
    Port ( in0, in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           salida : out  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC);
end Mux4;

architecture Behavioral of Mux4 is

begin
	process(in0, in1, sel)
	begin
		if(sel = '0') then
			salida <= in0;
		else
			salida <= in1;
		end if;
	end process;

end Behavioral;
