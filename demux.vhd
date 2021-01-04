
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demultiplexor is
    Port ( sel : in  STD_LOGIC_VECTOR (3 downto 0);
           entrada : in  STD_LOGIC;
           salida : inout  STD_LOGIC_VECTOR (15 downto 0));
end demultiplexor;

architecture Behavioral of demultiplexor is

begin
	process(sel, entrada, salida)
	begin
		salida <= (others => '0');
		
		case sel is
			when "0000" => salida(0) <= entrada;
			when "0001" => salida(1) <= entrada;
			when "0010" => salida(2) <= entrada;
			when "0011" => salida(3) <= entrada;
			when "0100" => salida(4) <= entrada;
			when "0101" => salida(5) <= entrada;
			when "0110" => salida(6) <= entrada;
			when "0111" => salida(7) <= entrada;
			when "1000" => salida(8) <= entrada;
			when "1001" => salida(9) <= entrada;
			when "1010" => salida(10) <= entrada;
			when "1011" => salida(11) <= entrada;
			when "1100" => salida(12) <= entrada;
			when "1101" => salida(13) <= entrada;
			when "1110" => salida(14) <= entrada;
			when others => salida(15) <= entrada;
		end case;
	end process;

end Behavioral;

