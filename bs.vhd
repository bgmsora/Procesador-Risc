library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity barrelShifter is
    Port ( shamt : in  STD_LOGIC_VECTOR (3 downto 0);
           dir : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (15 downto 0);
           q : out  STD_LOGIC_VECTOR (15 downto 0));
end barrelShifter;

architecture Behavioral of barrelShifter is

begin
	process(dir, shamt, d)
		variable aux : std_logic_vector(15 downto 0);	
		begin
			aux := d;
			--corrimiento izquierda
			if (dir = '1') then 
				for i in 0 to 3 loop
					if(shamt(i) = '0') then
						aux := aux;
					else
						for j in 15 downto 0 loop
							if(j < 2**i) then
								aux(j) := '0';
							else
								aux(j) := aux(j - 2**i);
							end if;
						end loop;
					end if;
				end loop;
			else
				--corrimiento derecha
				for i in 0 to 3 loop
					if(shamt(i) = '0') then
						aux := aux;
					else
						for j in 0 to 15 loop
							if(j >= 16-2**i) then 
								aux(j) := '0';
							else
								aux(j) := aux(j + 2**i);
							end if;
						end loop;
					end if;
				end loop;
			end if;
		q <= aux;
	end process;
end Behavioral;
