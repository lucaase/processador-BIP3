LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ProcessadorBIP IS
PORT(
  clk, rst: IN STD_LOGIC;
  Data: IN STD_LOGIC_VECTOR (15 downto 0);
  N, Z: IN STD_LOGIC;
  WrRam, RdRam, SelB, WrAcc, WrStatus: OUT STD_LOGIC;
  Op: OUT STD_LOGIC_VECTOR (2 downto 0);
  SelA: OUT STD_LOGIC_VECTOR (1 downto 0);
  s_PC: OUT STD_LOGIC_VECTOR(10 downto 0) -- Funcinando quando era s� sinal, mas precisava da sa�da pra conectar com mem�ria.
);
END ProcessadorBIP;

ARCHITECTURE Controle of ProcessadorBIP IS
SIGNAL Si_PC: STD_LOGIC_VECTOR (10 downto 0);
SIGNAL s0: STD_LOGIC_VECTOR (10 downto 0);
SIGNAL enaMux: STD_LOGIC;
SIGNAL enaPC: STD_LOGIC;
SIGNAL muxPC: STD_LOGIC_VECTOR (10 downto 0);
SIGNAL s1: STD_LOGIC_VECTOR (10 downto 0);
SIGNAL s2: STD_LOGIC_VECTOR (15 downto 11);

BEGIN
s1 <= Data (10 downto 0);
liga1: WORK.Somador PORT MAP (A=> "00000000001", B=> Si_PC, S=> s0);
liga2: WORK.Multiplexador PORT MAP (A=> s1, B=> s0, sel => enaMux, S=> muxPC);
liga3: WORK.PC PORT MAP (E=> muxPC, EN => enaPC, S=> Si_PC, clk=> clk, rst => rst);
liga4: WORK.Decodificador PORT MAP(Branch=> enaMux, WrPC => enaPC, SelA => SelA, SelB => SelB, WrAcc => WrAcc, Op => Op, WrRam => WrRam, RdRam => RdRam, WrStatus => WrStatus, N => N, Z => Z, Opcode => s2, clk => '1', rst => '1');
s_PC <= Si_PC;
END Controle;    