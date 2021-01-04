
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroEstado is
    Port ( clk, clr : in  STD_LOGIC;
           lf : in  STD_LOGIC;
           bandin : in  STD_LOGIC_VECTOR (3 downto 0);
           bandout : out  STD_LOGIC_VECTOR (3 downto 0));
end RegistroEstado;

architecture Behavioral of RegistroEstado is

begin
	process(clk, clr) begin
		if clr = '1' then
			bandout <= "0000";
		elsif falling_edge(clk) then
			if lf = '1' then
				bandout <= bandin;
			end if;
		end if;
	end process;
end Behavioral;

