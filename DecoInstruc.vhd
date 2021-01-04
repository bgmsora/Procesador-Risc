library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecoInstruc is
    Port ( codOper : in  STD_LOGIC_VECTOR (4 downto 0);
           tipor : out  STD_LOGIC;
           beqi : out  STD_LOGIC;
           bneqi : out  STD_LOGIC;
           blti : out  STD_LOGIC;
           bleti : out  STD_LOGIC;
           bgti : out  STD_LOGIC;
           bgeti : out  STD_LOGIC);
end DecoInstruc;

architecture Behavioral of DecoInstruc is

begin
	
	process(codOper) begin
		
		case codOper is
			when "00000" =>
				tipor <= '1';
				beqi <= '0';
				bneqi <= '0';
				blti <= '0';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '0';
			when "01101" =>
				tipor <= '0';
				beqi <= '1';
				bneqi <= '0';
				blti <= '0';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '0';
			when "01110" =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '1';
				blti <= '0';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '0';
			when "01111" =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '0';
				blti <= '1';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '0';
			when "10000" =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '0';
				blti <= '0';
				bleti <= '1';
				bgti <= '0';
				bgeti <= '0';
			when "10001" =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '0';
				blti <= '0';
				bleti <= '0';
				bgti <= '1';
				bgeti <= '0';
			when "10010" =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '0';
				blti <= '0';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '1';
			when others =>
				tipor <= '0';
				beqi <= '0';
				bneqi <= '0';
				blti <= '0';
				bleti <= '0';
				bgti <= '0';
				bgeti <= '0';
		end case;
		
	end process;

end Behavioral;


