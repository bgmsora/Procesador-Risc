library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port ( clk, clr : in  STD_LOGIC;
           eq, neq, lt, le, gthan, get : in  STD_LOGIC;
           tipor, beqi, bneqi, blti, bleti, bgti, bgeti : in  STD_LOGIC;
           na : in  STD_LOGIC;
           sdopc, sm : out  STD_LOGIC);
end Control;

architecture Behavioral of Control is
type estados is (E0);
signal edo_act, edo_sig : estados;
begin

	process(clk, clr)
	begin
		if(clr = '1') then
			edo_act <= e0;
		elsif(rising_edge(clk)) then
			edo_act <= edo_sig;
		end if;
	end process;

	process(edo_act, na, eq, neq, lt, le, gthan, get, tipor, beqi, bneqi, blti, bleti, bgti, bgeti)
	begin
		case edo_act is
			when e0 =>
				if(tipor = '1') then --tipo r
					sdopc <= '0';
					sm <= '0';
				elsif(beqi = '1') then --beqi
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if(eq = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				elsif(bneqi = '1') then --bneqi
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if( neq = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				elsif(blti = '1') then --blti
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if( lt = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				elsif(bleti = '1') then --bleti
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if( le = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				elsif(bgti = '1') then --bgti
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if( gthan = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				elsif( bgeti = '1' ) then --bgeti
					if(na = '1') then
						sdopc <= '0';
						sm <= '1';
					else
						if( get = '1') then --si se cumple
							sdopc <= '1';
							sm <= '1';
						else
							sdopc <= '0';
							sm <= '1';
						end if;
					end if;
				else	--otras instrucciones
					sdopc <= '1';
					sm <= '1';
				end if;
		end case;
		
		edo_sig <= e0;
		
	end process;

end Behavioral;
