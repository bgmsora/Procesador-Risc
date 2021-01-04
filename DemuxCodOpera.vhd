
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DemuxCodOpera is
    Port ( codigo : in  STD_LOGIC_VECTOR (4 downto 0);
           sal : out  STD_LOGIC_VECTOR (4 downto 0);
           sdopc : in  STD_LOGIC);
end DemuxCodOpera;

architecture Behavioral of DemuxCodOpera is

begin
	process(sdopc, codigo)
	begin
		if(sdopc = '1') then
			sal <= codigo;
		else
			sal <= "00000";
		end if;
	end process;

end Behavioral;

