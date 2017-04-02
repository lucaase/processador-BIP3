LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ula IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  N, Z : OUT STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ula;

ARCHITECTURE arch OF ula IS

COMPONENT somadorsubtrator IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Op : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT deslocador IS
	PORT(A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		  Dir : IN STD_LOGIC;
		  S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

SIGNAL saida, saida_desl, saida_somasub : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	deslc: deslocador PORT MAP(A => A, B => B, Dir => Op(0), S => saida_desl);
	somasub: somadorsubtrator PORT MAP (A => A, B => B, Op => Op(0), S => saida_somasub);
	
	WITH Op SELECT
		saida <= saida_somasub WHEN "000", -- soma
				 saida_somasub WHEN "001", -- subtracao
			 	 A AND B WHEN "010",       -- and
				 A OR B WHEN "011",        -- or
				 A XOR B WHEN "100",       -- xor
				 NOT(A) WHEN "101",        -- not
				 saida_desl WHEN "110",    -- deslocamento a esquerda
				 saida_desl WHEN "111",    -- deslocamento a direita
				 (OTHERS => '0') WHEN OTHERS;

	N <= saida(15);
	Z <= '1' WHEN saida = "0000000000000000" ELSE '0';
	S <= saida;
END;