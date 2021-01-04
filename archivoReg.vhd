library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity archivoRegx is
    Port ( clk, clr : in  STD_LOGIC;
           wr, she, dir : in  STD_LOGIC;
           write_reg : in  STD_LOGIC_VECTOR (3 downto 0);
           read_reg1, read_reg2 : in  STD_LOGIC_VECTOR (3 downto 0);
           shamt : in  STD_LOGIC_VECTOR (3 downto 0);
           write_data : in  STD_LOGIC_VECTOR (15 downto 0);
           read_data1, read_data2 : inout  STD_LOGIC_VECTOR (15 downto 0));
end archivoRegx;

architecture Behavioral of archivoRegx is

--COMPONENTS
component registro is
    Port ( d : in  STD_LOGIC_VECTOR (15 downto 0);
           clk, clr, l : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component barrelShifter is
    Port ( shamt : in  STD_LOGIC_VECTOR (3 downto 0);
           dir : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (15 downto 0);
           q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component demultiplexor is
    Port ( sel : in  STD_LOGIC_VECTOR (3 downto 0);
           entrada : in  STD_LOGIC;
           salida : inout  STD_LOGIC_VECTOR (15 downto 0));
end component;

component mux2 is
    Port ( e1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  e2 : in  STD_LOGIC_VECTOR (15 downto 0);
           s : inout  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC);
end component;

--AUXILIARES
type banco is array(0 to 15) of std_logic_vector(15 downto 0);
signal arreglo : banco;
signal aux_l : std_logic_vector(15 downto 0);
signal aux_write_data : std_logic_vector(15 downto 0);
signal aux_bs : std_logic_vector(15 downto 0);
begin
	
	--registros
	ciclo : for i in 0 to 15 generate
		aux : registro port map(
			d => aux_write_data,
			clk => clk,
			clr => clr,
			l => aux_l(i),
			q => arreglo(i)
		);
	end generate;
	
	--multiplexores
	read_data1 <= arreglo(conv_integer(read_reg1));
	read_data2 <= arreglo(conv_integer(read_reg2));
	
	multiplexor2 : mux2 port map(
		e1 => write_data,
		e2 => aux_bs,
		s => aux_write_data,
		sel => she
	);
	
	--barrel shifter
	bs : barrelShifter port map (
		shamt => shamt,
      dir => dir,
      d => read_data2,
      q => aux_bs
	);
	
	--demultiplexor
	demux : demultiplexor port map( 
		sel => write_reg,
      entrada => wr,
      salida => aux_l
	);

end Behavioral;

