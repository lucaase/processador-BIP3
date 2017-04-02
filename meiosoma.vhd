LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY meiosoma IS
	PORT(a,b : IN STD_LOGIC;
		 s,c : OUT STD_LOGIC);
END meiosoma;

ARCHITECTURE arch OF meiosoma IS
BEGIN
	s <= a XOR b;
	c <= a AND b;
END;