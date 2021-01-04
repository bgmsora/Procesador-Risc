library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Condicion is
    Port ( rbanderas : in  STD_LOGIC_VECTOR (3 downto 0);
           eq, neq, lt, le, gthan, get : out  STD_LOGIC);
end Condicion;

architecture Behavioral of Condicion is

begin

	eq <= rbanderas(1); -- z
	neq <= not rbanderas(1); -- not z
	lt <= (rbanderas(2) xor rbanderas(3)) and (not rbanderas(1)); -- (n xor ov) and not z
	le <= (rbanderas(2) xor rbanderas(3)) or rbanderas(1); -- ( n xor ov) or z
	gthan <= not rbanderas(1) and not( rbanderas(2) xor rbanderas(3) ); -- not z and not( n xor ov )
	get <= not(rbanderas(2) xor rbanderas(3)) or rbanderas(1); --not(n xor ov) or z
	
end Behavioral;


