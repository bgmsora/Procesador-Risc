library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package main is

component alux IS

	GENERIC (
				N : INTEGER := 16
				);
	PORT (	
		A, B  : IN  STD_LOGIC_VECTOR(N - 1 DOWNTO 0);	
		AOP   : IN  STD_LOGIC_VECTOR(3     DOWNTO 0);
		FLAGS : OUT STD_LOGIC_VECTOR(3     DOWNTO 0);
		S     : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
	);
	
END component;

component archivoRegx is
    Port ( clk, clr : in  STD_LOGIC;
           wr, she, dir : in  STD_LOGIC;
           write_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           read_reg1, read_reg2 : in  STD_LOGIC_VECTOR (3 downto 0);
           shamt : in  STD_LOGIC_VECTOR (3 downto 0);
           write_data : in  STD_LOGIC_VECTOR (15 downto 0);
           read_data1, read_data2 : inout  STD_LOGIC_VECTOR (15 downto 0));
end component;

component ExtensorDirec IS

	PORT (
	
		ENTRADA : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		
		SALIDA : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	
	);

END component;

component ExtensorSigno IS

	PORT (

		ENTRADA : IN STD_LOGIC_VECTOR(11 DOWNTO 0);

		SALIDA : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)

	);

END component;

component MemoriaDatos is

	generic(
		m : integer := 10; --bits de dir -> log2(#palabras) --2k=2048.
		n : integer := 16 --tamano de palabra
	);
	
    Port ( dir : in  STD_LOGIC_VECTOR (m - 1 downto 0);
           data_in : in  STD_LOGIC_VECTOR (n - 1 downto 0);
           wd : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (n - 1 downto 0));
end component;

component MemProg is
	generic(
		n : integer := 10 --bits de CP / log2(#palabras)
	);
	port(
		pc : in std_logic_vector (n - 1 downto 0);
		inst : out std_logic_vector (24 downto 0)
		);
end component;

component Mux4 is
    Port ( in0, in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           salida : out  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC);
end component;

component Mux16 is
    Port ( in0, in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           salida : out  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC);
end component;

component pila is
	port(
		d : in std_logic_vector (15 downto 0);
		up : in std_logic;
		down : in std_logic;
		wpc : in std_logic;
		clk : in std_logic;
		clr : in std_logic;
		pc_sal : out std_logic_vector (15 downto 0)
		);
end component;

component Componentes is --Control
    Port ( codFunc : in  STD_LOGIC_VECTOR (3 downto 0);
           codOper : in  STD_LOGIC_VECTOR (4 downto 0);
           banderas : in  STD_LOGIC_VECTOR (3 downto 0);
           clk, clr, lf : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (19 downto 0));
end component;

end main;

