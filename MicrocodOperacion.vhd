library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity microcodOperacion is
    Port ( codOpera : in  STD_LOGIC_VECTOR (4 downto 0);
           sal : out  STD_LOGIC_VECTOR (19 downto 0));
end microcodOperacion;

architecture Behavioral of microcodOperacion is
-- Microcode orden: SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALUOP SDMD WD SR LF.
type aux is array(0 to 31) of std_logic_vector(19 downto 0);-- 24 microinstrucciones de 20 bits
	constant codigos : aux := ( 	--microinstrucciones
		"00001000000001110001", --VERIFICACION
		"00000000010000000000", --LI
		"00000100010000001000",--LWI
		"00001000000000001100",--SWI
		"00001010000100110101",--SW
		"00001100010100110011",--ADDI
		"00001100010101110011",--SUBI
		"00000100010100000011",--ANDI
		"00000100010100010011",--ORI
		"00000100010100100011",--XORI
		"00000100010111010011",--NANDI
		"00000100010111000011",--NORI
		"00000100010110100011",--XNORI
		"10010000001100110011",--BEQI
		"10010000001100110011",--BNEI
		"10010000001100110011",--BLTI
		"10010000001100110011",--BLETI
		"10010000001100110011",--BGTI
		"10010000001100110011",--BGEIT
		"00010000000000000000",--B
		"01010000000000000000",--CALL
		"00100000000000000000",--RET
		"00000000000000000001",--NOP
		"00000110010100110001",--LW
		others => ( others => '0' )
	);
begin
	
	sal <= codigos( conv_integer(codOpera) );

end Behavioral;

