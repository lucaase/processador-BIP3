LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPU IS
PORT(
    clk, rst: IN STD_LOGIC; 
	Data, Out_Data:IN STD_LOGIC_VECTOR(15 downto 0);
	Addri, Addrd: OUT STD_LOGIC_VECTOR(10 downto 0); -- Addri pra memória de instruções, Addrd pra memória de dados.
	Rd, Wr: OUT STD_LOGIC;
	In_Data: OUT STD_LOGIC_VECTOR(15 downto 0)
);
END CPU;

ARCHITECTURE cp OF CPU IS

SIGNAL sn, sz, sSelB, sWrAcc, sWrStatus: STD_LOGIC;
SIGNAL sData, sData2: STD_LOGIC_VECTOR(10 downto 0);
SIGNAL sSelA: STD_LOGIC_VECTOR(1 downto 0);
SIGNAL sOp: STD_LOGIC_VECTOR(2 downto 0);


BEGIN
liga1: WORK.ProcessadorBIP port map(clk => clk, rst => rst, Data => Data, N => sn, Z => sz, WrRam => Wr, RdRam => Rd, Op => sOp, SelA => sSelA, SelB => sSelB, WrAcc => sWrAcc, WrStatus =>sWrStatus, s_PC => Addri);
liga2: WORK.PO port map(Op => sOp, clk=>clk, rst=>rst, SelB => sSelB, WrAcc => sWrAcc, WrStatus => sWrStatus, SelA => sSelA, Operando => sData, Out_Data => Out_Data, N => sn, Z => sz, Addr => sData2, In_Data => In_Data);
END;
