library IEEE;
use IEEE.STD_LOGIC_1164.all;

package components is
component Condicion is
    Port ( rbanderas : in  STD_LOGIC_VECTOR (3 downto 0);
           eq, neq, lt, le, gthan, get : out  STD_LOGIC);
end component;

component Control is
    Port ( clk, clr : in  STD_LOGIC;
           eq, neq, lt, le, gthan, get : in  STD_LOGIC;
           tipor, beqi, bneqi, blti, bleti, bgti, bgeti : in  STD_LOGIC;
           na : in  STD_LOGIC;
           sdopc, sm : out  STD_LOGIC);
end component;

component DecoInstruc is
    Port ( codOper : in  STD_LOGIC_VECTOR (4 downto 0);
           tipor : out  STD_LOGIC;
           beqi : out  STD_LOGIC;
           bneqi : out  STD_LOGIC;
           blti : out  STD_LOGIC;
           bleti : out  STD_LOGIC;
           bgti : out  STD_LOGIC;
           bgeti : out  STD_LOGIC);
end component;

component DemuxCodOpera is
    Port ( codigo : in  STD_LOGIC_VECTOR (4 downto 0);
           sal : out  STD_LOGIC_VECTOR (4 downto 0);
           sdopc : in  STD_LOGIC);
end component;

component DemuxS is
    Port ( sm : in  STD_LOGIC;
           codFunc : in  STD_LOGIC_VECTOR (19 downto 0);
           codOper : in  STD_LOGIC_VECTOR (19 downto 0);
           s : out  STD_LOGIC_VECTOR (19 downto 0));
end component;

component MicrocodFuncion is
    Port ( codFunc : in  STD_LOGIC_VECTOR (3 downto 0);
           sal : out  STD_LOGIC_VECTOR (19 downto 0));
end component;

component microcodOperacion is
    Port ( codOpera : in  STD_LOGIC_VECTOR (4 downto 0);
           sal : out  STD_LOGIC_VECTOR (19 downto 0));
end component;

component Nivel is
    Port ( clk, clr : in  STD_LOGIC;
           na : out  STD_LOGIC);
end component;

component RegistroEstado is
    Port ( clk, clr : in  STD_LOGIC;
           lf : in  STD_LOGIC;
           bandin : in  STD_LOGIC_VECTOR (3 downto 0);
           bandout : out  STD_LOGIC_VECTOR (3 downto 0));
end component;
 
end components;

