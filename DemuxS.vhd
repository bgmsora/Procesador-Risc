
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DemuxS is
    Port ( sm : in  STD_LOGIC;
           codFunc : in  STD_LOGIC_VECTOR (19 downto 0);
           codOper : in  STD_LOGIC_VECTOR (19 downto 0);
           s : out  STD_LOGIC_VECTOR (19 downto 0));
end DemuxS;

architecture Behavioral of DemuxS is

begin
	process(sm, codFunc, codOper)
	begin
		if(sm = '1') then
			s <= codOper;
		else
			s <= codFunc;
		end if;
	end process;

end Behavioral;

