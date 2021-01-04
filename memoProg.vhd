library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MemProg is
	generic(
		n : integer := 10 --bits de CP / log2(#palabras)
	);
	port(
		pc : in std_logic_vector (n - 1 downto 0);
		inst : out std_logic_vector (24 downto 0)
		);
end MemProg;

architecture Funcion of MemProg is
	--Instrucciones tipo R
	constant tipo_r : std_logic_vector (4 downto 0) := "00000";
	--Carga y Almacenamiento
	constant li : std_logic_vector (4 downto 0) := "00001";
	constant lwi : std_logic_vector (4 downto 0) := "00010";
	constant lw : std_logic_vector (4 downto 0) := "10111";
	constant swi : std_logic_vector (4 downto 0) := "00011";
	constant sw : std_logic_vector (4 downto 0) := "00100";
	--Aritmticas
	constant addi : std_logic_vector (4 downto 0) := "00101";
	constant subi : std_logic_vector (4 downto 0) := "00110";
	--Identificador Aritmticas R
	constant add : std_logic_vector (3 downto 0) := "0000";
	constant sub : std_logic_vector (3 downto 0) := "0001";
	--Logicas
	constant andi : std_logic_vector (4 downto 0) := "00111";
	constant ori : std_logic_vector (4 downto 0) := "01000";
	constant xori : std_logic_vector (4 downto 0) := "01001";
	constant nandi : std_logic_vector (4 downto 0) := "01010";
	constant nori : std_logic_vector (4 downto 0) := "01011";
	constant xnori : std_logic_vector (4 downto 0) := "01100";
	--Identificador Logicas R
	constant andr : std_logic_vector (3 downto 0) := "0010";
	constant orr : std_logic_vector (3 downto 0) := "0011";
	constant xorr : std_logic_vector (3 downto 0) := "0100";
	constant nandr : std_logic_vector (3 downto 0) := "0101";
	constant norr : std_logic_vector (3 downto 0) := "0110";
	constant xnorr : std_logic_vector (3 downto 0) := "0111";
	constant notr : std_logic_vector (3 downto 0) := "1000";
	--Identificador Corrimiento R
	constant sllr : std_logic_vector (3 downto 0) := "1001";
	constant srlr : std_logic_vector (3 downto 0) := "1010";
	--Saltos Condicionales e Incondicionales
	constant beqi : std_logic_vector (4 downto 0) := "01101";
	constant bnei : std_logic_vector (4 downto 0) := "01110";
	constant blti : std_logic_vector (4 downto 0) := "01111";
	constant bleti : std_logic_vector (4 downto 0) := "10000";
	constant bgti : std_logic_vector (4 downto 0) := "10001";
	constant bgeti : std_logic_vector (4 downto 0) := "10010";
	constant b : std_logic_vector (4 downto 0) := "10011";
	--Manejo de Subrutinas
	constant call : std_logic_vector (4 downto 0) := "10100";
	constant ret : std_logic_vector (4 downto 0) := "10101";
	--Otros
	constant nop : std_logic_vector (4 downto 0) := "10110";
	constant su : std_logic_vector (3 downto 0) := "0000"; -- sin usar
	--Registros
	constant R0 : std_logic_vector (3 downto 0) := "0000";
	constant R1 : std_logic_vector (3 downto 0) := "0001";
	constant R2 : std_logic_vector (3 downto 0) := "0010";
	constant R3 : std_logic_vector (3 downto 0) := "0011";
	constant R4 : std_logic_vector (3 downto 0) := "0100";
	constant R5 : std_logic_vector (3 downto 0) := "0101";
	constant R6 : std_logic_vector (3 downto 0) := "0110";
	constant R7 : std_logic_vector (3 downto 0) := "0111";
	constant R8 : std_logic_vector (3 downto 0) := "1000";
	constant R9 : std_logic_vector (3 downto 0) := "1001";
	constant R10 : std_logic_vector (3 downto 0) := "1010";
	constant R11 : std_logic_vector (3 downto 0) := "1011";
	constant R12 : std_logic_vector (3 downto 0) := "1100";
	constant R13 : std_logic_vector (3 downto 0) := "1101";
	constant R14 : std_logic_vector (3 downto 0) := "1110";
	constant R15 : std_logic_vector (3 downto 0) := "1111";
	
	--PROGRAMA
	type aux is array(0 to 2**n - 1) of std_logic_vector(24 downto 0);
	constant programa : aux := (
		--Proyecto parte 2, Burbuja
		LI & R3 & x"0028",   --TAMANO DEL ARREGLO                                  Lo pidio de 40  (28)  seria 251 a 212
		CALL & SU  & x"0029",   --Salto a rellenar datos
		LI & R1 & x"0000",   --Pivote interno i primer for
		LI & R2 & x"0000",   --Donde inicia el arreglo en memoria
		LI & R10 & x"0000",   --Direccion 0 ascendete, 1 descendete
		
		--burbuja
		CALL & SU & x"000B",   --saltamos al burbuja FOR interno
		ADDI & R1 & R1 & x"001",  --i++                                    6
		BNEI &R1 &R3 & x"FFE",
		
		--mando a imprimir
		CALL & SU & x"0021",  
		NOP & X"00000",   --FIN                                             9
        B & x"00009",
        
        --For interno del burbuja 
        SUBI & R4 & R3 & x"001",   --FOR                                       11
        LI & R5 & x"0000",  --PIVOTE J
		ADDI & R9 & R2 & x"000", --establecemos el inicio del arreglo
		LW & R6 & R9 & x"000",  --en j                                REINICIO    14
		LW & R7 & R9 & x"001",   --en j+1
		--Aqui vemos si es descendente o no
		BEQI & R10 & R11 & x"00C",
		BLETI & R6 & R7 &  x"005", --VAMOS A CAMBIAR    EL IF DE <=                            18
		ADDI & R5 & R5 & x"001",   --J++
		ADDI & R9 & R9 & x"001",   --PASO AL SIGUIENTE VALOR DEL ARREGLO
		BNEI &R5 &R4 & x"FFA",   --reinicio salto
		RET & SU & SU & SU & SU & SU,  --volvemos al burbuja
		SW & R7 & R9 & x"000",   --CAMBIO                                           23
		SW & R6 & R9 & x"001", 
		ADDI & R5 & R5 & x"001",  --J++
		ADDI & R9 & R9 & x"001",  --PASO AL SIGUIENTE VALOR DEL ARREGLO
		BNEI &R5 &R4 & x"FF4",
		RET & SU & SU & SU & SU & SU,
		BGETI & R6 & R7 &  x"FFA",   --Vamo a cambiar   El otro if  >=                29
		ADDI & R5 & R5 & x"001",   --J++
		ADDI & R9 & R9 & x"001", --PASO AL SIGUIENTE VALOR DEL ARREGLO
		BNEI &R5 &R4 & x"FEF",   --reinicio salto
		RET & SU & SU & SU & SU & SU,
		
		--imprimir valores (lo hace bien imprime los 7 datos) --------------------------------------------------------
		SUBI & R4 & R3 & x"000",   --FOR                                      33
        LI & R5 & x"0000",  --PIVOTE J
        ADDI & R9 & R2 & x"000", --establecemos el inicio del arreglo
		LW & R1 & R9 & x"000",                                                 --36          (24)
		ADDI & R9 & R9 & x"001",
		ADDI & R5 & R5 & x"001", --J++
		BLTI & R4 & R5 & x"FFD",  --SALTO AL FOR DE NUEVO    --THIS
		RET & SU & SU & SU & SU & SU,
		
		--Ingreso de datos desde 251, 250, 249-----------------------------------------------------------------------
		LI & R11 & x"0001",    --MI uno	para comparar direccion   -41
		
		SUBI & R4 & R3 & x"000",    --copiamos el tamano
		LI & R6 & x"00FB",  --desde que numero iniciamos 251
		LI & R5 & x"0000",  --j=0
		tipo_r & R1 & R6 & R5 & SU & sub,   -- R1=R6-R5
		SW & R1 & R5 & x"000",   --MEM[R5+0]=R1
		ADDI & R5 & R5 & x"001",  --J++
		BLTI & R4 & R5 & x"FFD",                                      --48(30)
		RET & SU & SU & SU & SU & SU,
		
		others => (others => '0')
	);
	
	begin
		inst <= programa( conv_integer(PC) );
end Funcion;

