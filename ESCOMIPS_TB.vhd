LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ESCOMIPS_TB IS
END ESCOMIPS_TB;
 
ARCHITECTURE behavior OF ESCOMIPS_TB IS 
 
    COMPONENT Procesador
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic;
         microInstruccion : OUT  std_logic_vector(19 downto 0);
         PC_salida : OUT  std_logic_vector(15 downto 0);
         RD_1 : OUT  std_logic_vector(15 downto 0);
         RD_2 : OUT  std_logic_vector(15 downto 0);
         SR_Out : OUT  std_logic_vector(15 downto 0);
         memoria_datos : OUT  std_logic_vector(15 downto 0);
         salidaALU : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';

 	--Outputs
   signal microInstruccion : std_logic_vector(19 downto 0);
   signal PC_salida : std_logic_vector(15 downto 0);
   signal RD_1 : std_logic_vector(15 downto 0);
   signal RD_2 : std_logic_vector(15 downto 0);
   signal SR_Out : std_logic_vector(15 downto 0);
   signal memoria_datos : std_logic_vector(15 downto 0);
   signal salidaALU : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Procesador PORT MAP (
          clk => clk,
          clr => clr,
          microInstruccion => microInstruccion,
          PC_salida => PC_salida,
          RD_1 => RD_1,
          RD_2 => RD_2,
          SR_Out => SR_Out,
          memoria_datos => memoria_datos,
          salidaALU => salidaALU
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		clr <= '1';
      wait for 30 ns;
		clr <= '0';
		wait;
   end process;

END;
