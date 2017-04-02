LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY somador16 IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Cin : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Cout : OUT STD_LOGIC);
END somador16;

ARCHITECTURE arch OF somador16 IS

COMPONENT somadorcompleto
	PORT(a, b, cin : IN STD_LOGIC;
		 s, cout : OUT STD_LOGIC);
END COMPONENT;

SIGNAL c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15: STD_LOGIC;

BEGIN

	SC1: somadorcompleto PORT MAP(a => A(0), b => B(0), cin => Cin, s => S(0), cout => c1);
	SC2: somadorcompleto PORT MAP(a => A(1), b => B(1), cin => c1, s => S(1), cout => c2);
	SC3: somadorcompleto PORT MAP(a => A(2), b => B(2), cin => c2, s => S(2), cout => c3);
	SC4: somadorcompleto PORT MAP(a => A(3), b => B(3), cin => c3, s => S(3), cout => c4);
	SC5: somadorcompleto PORT MAP(a => A(4), b => B(4), cin => c4, s => S(4), cout => c5);
	SC6: somadorcompleto PORT MAP(a => A(5), b => B(5), cin => c5, s => S(5), cout => c6);
	SC7: somadorcompleto PORT MAP(a => A(6), b => B(6), cin => c6, s => S(6), cout => c7);
	SC8: somadorcompleto PORT MAP(a => A(7), b => B(7), cin => c7, s => S(7), cout => c8);
	SC9: somadorcompleto PORT MAP(a => A(8), b => B(8), cin => c8, s => S(8), cout => c9);
	SC10: somadorcompleto PORT MAP(a => A(9), b => B(9), cin => c9, s => S(9), cout => c10);
	SC11: somadorcompleto PORT MAP(a => A(10), b => B(10), cin => c10, s => S(10), cout => c11);
	SC12: somadorcompleto PORT MAP(a => A(11), b => B(11), cin => c11, s => S(11), cout => c12);
	SC13: somadorcompleto PORT MAP(a => A(12), b => B(12), cin => c12, s => S(12), cout => c13);
	SC14: somadorcompleto PORT MAP(a => A(13), b => B(13), cin => c13, s => S(13), cout => c14);
	SC15: somadorcompleto PORT MAP(a => A(14), b => B(14), cin => c14, s => S(14), cout => c15);
	SC16: somadorcompleto PORT MAP(a => A(15), b => B(15), cin => c15, s => S(15), cout => Cout);
END;