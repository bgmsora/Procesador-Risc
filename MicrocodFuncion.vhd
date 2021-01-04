library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MicrocodFuncion is
    Port ( codFunc : in  STD_LOGIC_VECTOR (3 downto 0);
           sal : out  STD_LOGIC_VECTOR (19 downto 0));
end MicrocodFuncion;

architecture Behavioral of MicrocodFuncion is
-- Microcode orden: SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALUOP SDMD WD SR LF.
	type aux is array(0 to 15) of std_logic_vector(19 downto 0);-- 11 microinstrucciones de 20 bits
	constant codigos : aux := ( 	--microinstrucciones para tipo r
		"00000100010000110011", --add
		"00000100010001110011", --sub
		"00000100010000000011",--and
		"00000100010000010011",--or
		"00000100010000100011",--xor
		"00000100010011010011",--nand
		"00000100010011000011",--nor
		"00000100010010100011",--xnor
		"00000100010011000011",--not
		"00001001110000000000",--sll
		"00001001010000000000",--srl
		others => ( others => '0' )
	);
begin
	
	sal <= codigos( conv_integer(codFunc) );

end Behavioral;

