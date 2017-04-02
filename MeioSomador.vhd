LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MeioSomador IS
PORT(A:IN STD_LOGIC;
	 B:IN STD_LOGIC;
	 S:OUT STD_LOGIC;
	 Cin:IN STD_LOGIC;
	 Cout:OUT STD_LOGIC);
END MeioSomador;

ARCHITECTURE MSoma OF MeioSomador IS
BEGIN
	S <= A XOR B XOR Cin;
	Cout <= (A AND Cin) OR (B AND Cin) OR (A AND B);
END MSoma;