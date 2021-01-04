
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MemoriaDatos is

	generic(  
		m : integer := 10; --bits de dir -> log2(#palabras)
		n : integer := 16 --tamano de palabra
	);
	
    Port ( dir : in  STD_LOGIC_VECTOR (m - 1 downto 0);
           data_in : in  STD_LOGIC_VECTOR (n - 1 downto 0);
           wd : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (n - 1 downto 0));
end MemoriaDatos;

architecture Behavioral of MemoriaDatos is

	type aux is array (0 to 2**m - 1) of std_logic_vector(n - 1 downto 0);
	signal arreglo : aux;

begin

	process(clk)
	begin
		if(rising_edge(clk)) then 
			if (wd = '1') then
				arreglo(conv_integer(dir)) <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= arreglo(conv_integer(dir));

end Behavioral;