library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro is
    Port ( d : in  STD_LOGIC_VECTOR (15 downto 0);
           clk, clr, l : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (15 downto 0));
end registro;

architecture Behavioral of registro is

begin
	process(clk, clr)
	begin
		if(clr = '1') then
			q <= "0000000000000000";
		elsif(rising_edge(clk)) then
			if(l = '1') then
				q <= d;
			end if;
		end if;
	end process;

end Behavioral;

