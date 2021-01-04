library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.main.all;

entity Procesador is
    Port (   clk, clr : in  STD_LOGIC;
              microInstruccion : out  STD_LOGIC_VECTOR (19 downto 0);
              PC_salida : out  STD_LOGIC_VECTOR (15 downto 0);
			  RD_1 : out  STD_LOGIC_VECTOR (15 downto 0);
			  RD_2 : out  STD_LOGIC_VECTOR (15 downto 0);
              SR_Out: out  STD_LOGIC_VECTOR (15 downto 0);
			  memoria_datos : out STD_LOGIC_VECTOR(15 downto 0);
			  salidaALU : out  STD_LOGIC_VECTOR (15 downto 0));
end Procesador;

architecture Behavioral of Procesador is
	signal instruccion : std_logic_vector(24 downto 0);
	signal pc : std_logic_vector(15 downto 0);
	signal banderas : std_logic_vector(3 downto 0);
	signal microinstr : std_logic_vector(19 downto 0);
	signal sdmpOut : std_logic_vector(15 downto 0);
	signal sr2out : std_logic_vector(3 downto 0);
	signal swdout : std_logic_vector(15 downto 0);
	signal readata1 : std_logic_vector(15 downto 0);
	signal readata2 : std_logic_vector(15 downto 0);
	signal srout : std_logic_vector(15 downto 0);
	signal extsigout : std_logic_vector(15 downto 0);
	signal extdirout : std_logic_vector(15 downto 0);
	signal sextout : std_logic_vector(15 downto 0);
	signal sop1out : std_logic_vector(15 downto 0);
	signal sop2out : std_logic_vector(15 downto 0);
	signal aluout : std_logic_vector(15 downto 0);
	signal sdmdout : std_logic_vector(15 downto 0);
	signal memdataout : std_logic_vector(15 downto 0);
	
begin
	control : Componentes 
	   port map (
	       instruccion(3 downto 0), 
	       instruccion(24 downto 20), 
	       banderas, clk, clr, 
	       microinstr(0), 
	       microinstr 
	   );
	memoProg : MemProg port map (pc(9 downto 0), instruccion);
	pilax : pila port map(sdmpOut, microinstr(18), microinstr(17), microinstr(16), clk, clr, pc);
	archivoReg : archivoRegx port map (clk, clr, microinstr(10), microinstr(12), microinstr(11), instruccion(19 downto 16), instruccion(15 downto 12), sr2out, instruccion(7 downto 4), swdout, readata1, readata2);
	sr2 : Mux4 port map(instruccion(11 downto 8), instruccion(19 downto 16), sr2out, microinstr(15));
	swd : Mux16 port map(instruccion(15 downto 0), srout, swdout, microinstr(14));
	sdmp : Mux16 port map(instruccion(15 downto 0), srout, sdmpOut, microinstr(19));
	extsig : ExtensorSigno port map(instruccion(11 downto 0), extsigout);
	extdir : ExtensorDirec port map(instruccion(11 downto 0), extdirout);
	sext : Mux16 port map(extsigout, extdirout, sextout, microinstr(13));
	sop1 : Mux16 port map(readata1, pc, sop1out, microinstr(9));
	sop2 : Mux16 port map(readata2, sextout, sop2out, microinstr(8));
	alu : alux port map(sop1out, sop2out, microinstr(7 downto 4), banderas, aluout);
	sdmd : Mux16 port map(aluout, instruccion(15 downto 0), sdmdout, microinstr(3));
	memdatos : MemoriaDatos port map(sdmdout(9 downto 0), readata2, microinstr(2), clk, memdataout);
	sr : Mux16 port map(memdataout, aluout, srout, microinstr(1));
	
	-- SALIDAS
	microInstruccion <= microinstr;
	PC_salida <= pc;
	SR_Out <= srout;
	RD_1 <= readata1;
	RD_2 <= readata2;
	memoria_datos <= memdataout;
	salidaALU <= aluout;
end Behavioral;