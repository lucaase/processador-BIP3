LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY LPM;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY IMemory IS
	PORT(clk : IN STD_LOGIC; -- clock do sistema
		  Addr : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- endereco a ser lido
		  Data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); -- dado lido da memoria
END IMemory;

ARCHITECTURE arch OF IMemory IS
BEGIN

	M: lpm_ram_dq GENERIC MAP (LPM_WIDTH => 16, LPM_WIDTHAD => 11, LPM_NUMWORDS => 2048, LPM_FILE => "IMemory.mif")
					  PORT MAP (data => (OTHERS => '0'), address => Addr, we => '0', inclock => clk, outclock => clk, q => Data);
END arch;