LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY alux IS

	GENERIC (
				N : INTEGER := 16 --ALU DE 16 BITS :v
				);
	PORT (
		A, B  : IN  STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		AOP   : IN  STD_LOGIC_VECTOR(3     DOWNTO 0);
		FLAGS : OUT STD_LOGIC_VECTOR(3     DOWNTO 0);
		S     : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
	);
END alux;
ARCHITECTURE Arquitectura OF alux IS
BEGIN
	FROM : PROCESS (A, B, AOP)
		VARIABLE EB, P, G, RES : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		VARIABLE C : STD_LOGIC_VECTOR (N DOWNTO 0);
		VARIABLE RFZ : STD_LOGIC;
	BEGIN
		C := (OTHERS => '0');
		IF (AOP = "0011" OR AOP = "0111") THEN
			C(0) := AOP(2);
			FOR I IN 0 TO N - 1 LOOP 
				EB(I) := B(I) XOR AOP(2);
				P(I) := A(I) XOR EB(I);
				G(I) := A(I) AND EB(I);
				RES(I) := P(I) XOR C(I);
				C(I + 1) := G(I) OR (P(I) AND C(I));
			END LOOP;
		ELSIF (AOP = "0000") THEN
			RES := A AND B;
		ELSIF (AOP = "0001") THEN
			RES := A OR B;
		ELSIF (AOP = "0010" OR AOP = "1110") THEN
			RES := A XOR B;
		ELSIF (AOP = "0110" OR AOP = "1010") THEN
			RES := A XNOR B;
		ELSIF (AOP = "1101") THEN
			RES := A NAND B;
		ELSIF (AOP = "1100") THEN
			RES := A NOR B;
		ELSE
			RES := (OTHERS => '0');
		END IF;
		RFZ := RES(0);
		FOR J IN 1 TO N - 1 LOOP 
			RFZ := RFZ OR RES(J);
		END LOOP;
		FLAGS(0) <= C(N);--C
		FLAGS(1) <= NOT RFZ;--Z
		FLAGS(2) <= RES(N - 1);--N
		FLAGS(3) <= C(N) XOR C(N - 1);--OV
		S <= RES;
	END PROCESS;
END Arquitectura;