library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pila is
	port(
		d : in std_logic_vector (15 downto 0);  --data
		up : in std_logic;
		down : in std_logic;
		wpc : in std_logic;
		clk : in std_logic;
		clr : in std_logic;
		pc_sal : out std_logic_vector (15 downto 0)
		);
end pila;

architecture Behavioral of pila is
type type_pila is array( 0 to 7 ) of std_logic_vector( 15 downto 0 );
        begin
        process( clr, clk )
        variable sp : integer range 0 to 7;
        variable pc : type_pila;
        begin
            if( clr = '1' ) then
                for i in 0 to 7 loop
                pc( i ) := ( others => '0' );
                end loop;
                sp := 0;
            elsif( clk'event and clk = '1' ) then
                if( wpc = '1' and up = '0' and down = '0' ) then
                pc( sp ) := d;
                end if;
                if( wpc = '1' and up = '1' and down = '0' ) then
                sp := sp + 1;
                pc( sp ) := d;
                end if;
                if( wpc = '0' and up = '0' and down = '1' ) then
                sp := sp - 1;
                pc(sp) := pc( sp ) + 1;
                end if;
                if( wpc = '0' and up = '0' and down = '0' ) then
                pc( sp ) := pc( sp ) + 1;
                end if;
            end if;
            pc_sal <= pc( sp );
    end process;
--type banco is array (0 to 7) of std_logic_vector (15 downto 0);
--signal aux : banco;
--begin
--	process(clk, clr, aux) 
--	variable sp : std_logic_vector(2 downto 0);
--	begin
--		if (clr = '1') then
--			sp := "000";
--			for i in 0 to 7 loop
--				aux(i) <= "0000000000000000";
--			end loop;
--		elsif (rising_edge(clk)) then
--			if (wpc = '0' and up = '0' and down = '0') then
--				--sp = sp
--				aux(conv_integer(sp)) <= aux(conv_integer(sp)) + 1;
--			elsif (wpc = '1' and up = '1' and down = '0') then
--				sp := sp + 1;
--				aux(conv_integer(sp)) <= D;
--			elsif (wpc = '1' and up = '0' and down = '0') then
--				--sp = sp
--				aux(conv_integer(sp)) <= D;
--			elsif(wpc = '0' and up = '0' and down = '1') then    --cambiarlo por un else normal
--				sp := sp - 1;
--				aux(conv_integer(sp)) <= aux(conv_integer(sp)) + 1;
--			end if;
--		end if;
--		pc_sal <= aux(conv_integer(sp));
--	end process;
end Behavioral;
