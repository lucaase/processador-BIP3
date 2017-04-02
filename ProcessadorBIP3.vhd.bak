LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ProcessadorBIP3 IS
PORT(
  clk, rst: IN STD_LOGIC
);
END ProcessadorBIP3;

ARCHITECTURE arqfinal OF ProcessadorBIP3 IS

SIGNAL sAddr, sAddr2: STD_LOGIC_VECTOR (10 downto 0); 
SIGNAL sIn_Data, sOut_Data, sData: STD_LOGIC_VECTOR (15 downto 0);
SIGNAL sRd, sWr : STD_LOGIC;

BEGIN
liga1: WORK.CPU port map(clk => clk, rst => rst, Data =>sData , Out_Data => sOut_Data, Addri=> sAddr, Addrd=> sAddr2, Rd=> sRd, Wr=>sWr, In_Data => sIn_Data);
liga2: WORK.IMemory port map(clk=> clk, Addr=> sAddr, Data=>sData);
liga3: WORK.DMemory port map(clk=> clk, Rd=>sRd, Wr=>sWr, Addr=> sAddr2, In_Data=> sIn_Data, Out_Data=> sOut_Data);
END arqfinal;