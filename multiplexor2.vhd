
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( e1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  e2 : in  STD_LOGIC_VECTOR (15 downto 0);
           s : inout  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC);
end mux2;

architecture Behavioral of mux2 is

begin

	process(e1,e2,sel,s)
	begin
		case sel is
			when '0' => s <= e1;
			when others => s <= e2;
		end case;
	end process;

end Behavioral;

