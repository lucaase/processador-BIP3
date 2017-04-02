LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PO IS
	PORT(clk, rst : IN STD_LOGIC;
	     SelB, WrAcc, WrStatus : IN STD_LOGIC;
		  SelA : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  Op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  Operando : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  Out_Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  N, Z : OUT STD_LOGIC;
		  Addr : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
		  In_Data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END PO;

ARCHITECTURE arch OF PO IS

COMPONENT extensao IS
	PORT(E : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT mux3_1 IS
	PORT(E2, E1, E0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT mux2_1 IS
	PORT(E1, E0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  SEL : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT reg16 IS
	PORT(D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 CLK, EN, CLR : IN STD_LOGIC;
		 Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT reg2 IS
	PORT(D : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 CLK, EN, CLR : IN STD_LOGIC;
		 Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END COMPONENT;

COMPONENT ula IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  N, Z : OUT STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

SIGNAL ext_muxes, mux31_acc, acc_ula, mux21_ula, ula_mux31 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL sig_N, sig_Z : STD_LOGIC;

BEGIN
	ext: extensao PORT MAP(E => Operando, S => ext_muxes);
	mux31: mux3_1 PORT MAP(E2 => ula_mux31, E1 => ext_muxes, E0 => Out_Data, SEL => SelA, S => mux31_acc);
	mux21: mux2_1 PORT MAP(E1 => ext_muxes, E0 => Out_Data, SEL => SelB, S => mux21_ula);
	reg_acc: reg16 PORT MAP(D => mux31_acc, CLK => clk, EN => WrACC, CLR => rst, Q => acc_ula);
	reg_status: reg2 PORT MAP(D => (sig_N & sig_Z), CLK => clk, EN => WrStatus, CLR => rst, Q(1) => N, Q(0) => Z);
	alu: ula PORT MAP(A => acc_ula, B => mux21_ula, Op => Op, N => sig_N, Z => sig_Z, S => ula_mux31);
	In_Data <= acc_ula;
	Addr <= Operando;
END arch;