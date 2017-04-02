LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY LPM;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY DMemory IS
	PORT(clk : IN STD_LOGIC; -- clock do sistema
		  Rd: IN STD_LOGIC; -- sinal de leitura
		  Wr: IN STD_LOGIC; -- sinal de escrita
		  Addr : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- endereco a ser lido ou escrito
		  In_Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- dado a ser gravado da memoria
		  Out_Data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); -- dado lido da memoria
END DMemory;

ARCHITECTURE arch OF DMemory IS
BEGIN

	M: lpm_ram_dq GENERIC MAP (LPM_WIDTH => 16, LPM_WIDTHAD => 11, LPM_NUMWORDS => 2048, LPM_FILE => "DMemory.mif")
					  PORT MAP (data => In_Data, address => Addr, we => Wr, inclock => clk, outclock => clk, q => Out_Data);
END arch;