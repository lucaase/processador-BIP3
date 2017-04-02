LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Somador IS
PORT(A:IN STD_LOGIC_VECTOR (10 DOWNTO 0);
	 B:IN STD_LOGIC_VECTOR (10 DOWNTO 0);
	 S:OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
	 Cout:OUT STD_LOGIC);
END Somador;

ARCHITECTURE SomaCompleto OF Somador IS
COMPONENT MeioSomador
PORT(A:IN STD_LOGIC;
	 B:IN STD_LOGIC;
	 S:OUT STD_LOGIC;
	 Cin:IN STD_LOGIC;
	 Cout:OUT STD_LOGIC);
END COMPONENT;

SIGNAL s0, s1, s2, s3, s4, s5, s6, s7, s8, s9:STD_LOGIC;
	BEGIN
		Som00:MeioSomador port map (A=>A(0), B=>B(0), Cin=>'0', S=>S(0), Cout=>s0);
		Som01:MeioSomador port map (A=>A(1), B=>B(1), Cin=>s0, S=>S(1), Cout=>s1);
		Som02:MeioSomador port map (A=>A(2), B=>B(2), Cin=>s1, S=>S(2), Cout=>s2);
		Som03:MeioSomador port map (A=>A(3), B=>B(3), Cin=>s2, S=>S(3), Cout=>s3);
		Som04:MeioSomador port map (A=>A(4), B=>B(4), Cin=>s3, S=>S(4), Cout=>s4);
		Som05:MeioSomador port map (A=>A(5), B=>B(5), Cin=>s4, S=>S(5), Cout=>s5);
		Som06:MeioSomador port map (A=>A(6), B=>B(6), Cin=>s5, S=>S(6), Cout=>s6);
		Som07:MeioSomador port map (A=>A(7), B=>B(7), Cin=>s6, S=>S(7), Cout=>s7);
		Som08:MeioSomador port map (A=>A(8), B=>B(8), Cin=>s7, S=>S(8), Cout=>s8);
		Som09:MeioSomador port map (A=>A(9), B=>B(9), Cin=>s8, S=>S(9), Cout=>s9);
		Som10:MeioSomador port map (A=>A(10), B=>B(10), Cin=>s9, S=>S(10));
END SomaCompleto;