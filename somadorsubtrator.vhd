LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY somadorsubtrator IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Op : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END somadorsubtrator;

ARCHITECTURE arch OF somadorsubtrator	 IS

COMPONENT somador16 IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Cin : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Cout : OUT STD_LOGIC);
END COMPONENT;

COMPONENT mux2_1 IS
	PORT(E1, E0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  SEL : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

SIGNAL mux_somador: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

	mux: mux2_1 PORT MAP(E1 => NOT(B), E0 => B, SEL => Op, S => mux_somador);
	somador: somador16 PORT MAP(A => A, B => mux_somador, Cin => Op, S => S);

END;