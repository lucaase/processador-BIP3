LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY somadorcompleto IS
	PORT(a, b, cin : IN STD_LOGIC;
		 s, cout : OUT STD_LOGIC);
END somadorcompleto;

ARCHITECTURE arch OF somadorcompleto IS

COMPONENT meiosoma
	PORT(a,b : IN STD_LOGIC;
		 s,c : OUT STD_LOGIC);
END COMPONENT;

SIGNAL S1, S2, S3: STD_LOGIC;

BEGIN

	MS1: meiosoma PORT MAP(a => a, b => b, s => S1, c => S2);
	MS2: meiosoma PORT MAP(a => S1, b => cin, s => s, c => S3);
	Cout <= S2 OR S3;

END;