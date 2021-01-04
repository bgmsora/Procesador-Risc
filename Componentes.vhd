library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.components.all;

entity Componentes is
    Port ( codFunc : in  STD_LOGIC_VECTOR (3 downto 0);
           codOper : in  STD_LOGIC_VECTOR (4 downto 0);
           banderas : in  STD_LOGIC_VECTOR (3 downto 0);
           clk, clr, lf : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (19 downto 0));
end Componentes;

architecture Behavioral of Componentes is

signal mCodFunToDemux : STD_LOGIC_VECTOR (19 downto 0);
signal codOperTomCodOper : STD_LOGIC_VECTOR (4 downto 0);
signal mCodOperToDemux : STD_LOGIC_VECTOR (19 downto 0);
signal regEstadoToCond : STD_LOGIC_VECTOR (3 downto 0);
signal tipor, beqi, bneqi, blti, bleti, bgti, bgeti : STD_LOGIC;
signal na, sdopc, sm : STD_LOGIC;
signal eq, neq, lt, le, gthan, get : STD_LOGIC;


begin
	u1 : Condicion port map(regEstadoToCond, eq, neq, lt, le, gthan, get);
	u2 : Control port map(clk, clr, eq, neq, lt, le, gthan, get, tipor, beqi, bneqi, blti, bleti, bgti, bgeti, na, sdopc, sm);
	u3 : DecoInstruc port map(codOper, tipor, beqi, bneqi, blti, bleti, bgti, bgeti);
	u4 : DemuxCodOpera port map(codOper, codOperTomCodOper, sdopc );
	u5 : DemuxS port map( sm, mCodFunToDemux, mCodOperToDemux, s );
	u6 : MicrocodFuncion port map(codFunc, mCodFunToDemux);
	u7 : MicrocodOperacion port map(codOperTomCodOper, mCodOperToDemux);
	u8 : Nivel port map(clk, clr, na);
	u9 : RegistroEstado port map(clk, clr, lf, banderas, regEstadoToCond );
	
end Behavioral;
