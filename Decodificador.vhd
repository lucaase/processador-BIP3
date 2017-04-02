LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Decodificador IS
	PORT(clk, rst: IN STD_LOGIC;
		 Opcode: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		 N, Z: IN STD_LOGIC;
		 Branch, WrPC, SelB, WrAcc, WrRam, RdRam, WrStatus: OUT STD_LOGIC;
		 SelA: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		 Op: OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END Decodificador;

ARCHITECTURE arch OF Decodificador IS

TYPE estado IS (inicial, HLT, LD4, LD3, OORI, EADD, EADD2, EADD4, SUB4, OOR, SUB3, EADD3, ANNDI, EADDI1,ESP1,ESP2,STO,LD,LD2,LDI,SUB1,SUB2,SUBI1,BEQ,BNE,BGT,BGE,BLT,BLE,JMP,NO,ANND,ANND1,ANND2,ANND3,OOR1,OOR2,OOR3,ORI,XOOR,XOOR1,XOOR2,XOOR3,XORI,SLLL,SRLL);
SIGNAL estado_atual, prox_estado: estado;

BEGIN

	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			IF(rst = '1') THEN
				estado_atual <= inicial;
			ELSE
				estado_atual <= prox_estado;
			END IF;
		END IF;
	END PROCESS;

	PROCESS(estado_atual, Opcode)
	BEGIN
		CASE estado_atual IS
			WHEN inicial =>
				--BIP I
				
				IF (Opcode = "00000") THEN
					prox_estado <= HLT;
				ELSIF (Opcode = "00001") THEN
					prox_estado <= STO;
				ELSIF (Opcode = "00010") THEN
					prox_estado <= LD;
				ELSIF (Opcode = "00011") THEN
					prox_estado <= LDI;
				ELSIF (Opcode = "00100") THEN
					prox_estado <= EADD;
				ELSIF (Opcode = "00101") THEN
					prox_estado <= EADDI1;
		        ELSIF (Opcode = "00110") THEN
					prox_estado <= SUB1;
				ELSIF (Opcode = "00111") THEN
					prox_estado <= SUBI1;
					
				--BIP II
				
				ELSIF (Opcode = "01000") THEN
					prox_estado <= BEQ;
				ELSIF ( Opcode = "01001" ) THEN
	                prox_estado <= BNE;
				ELSIF ( Opcode = "01010") THEN
					prox_estado <= BGT;
				ELSIF ( Opcode = "01011") THEN
					prox_estado <= BGE;
				ELSIF ( Opcode = "01100") THEN
					prox_estado <= BLT;
				ELSIF ( Opcode = "01010") THEN
					prox_estado <= BGT;
				ELSIF ( Opcode = "01011") THEN
					prox_estado <= BGE;
				ELSIF ( Opcode = "01100") THEN
					prox_estado <= BLT;
				ELSIF ( Opcode = "01101") THEN
					prox_estado <= BLE;
				ELSIF ( Opcode = "01110") THEN
					prox_estado <= JMP;
					
				--BIP III
				
				ELSIF (Opcode = "01111") THEN
					prox_estado <= NO;
				ELSIF ( Opcode = "10000") THEN
	                		prox_estado <= ANND;
				ELSIF ( Opcode = "10001") THEN
					prox_estado <= ANNDI;
				ELSIF ( Opcode = "10010") THEN
					prox_estado <= OOR;
				ELSIF ( Opcode = "10011") THEN
					prox_estado <= OORI;
				ELSIF ( Opcode = "10101") THEN
					prox_estado <= XOOR;
				ELSIF ( Opcode = "10101") THEN
					prox_estado <= XORI;
				ELSIF ( Opcode = "10110") THEN
					prox_estado <= SLLL;
				ELSIF ( Opcode = "10111") THEN
					prox_estado <= SRLL;
				END IF;
				
			WHEN HLT =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= HLT;
				
			WHEN STO =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '1';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
			WHEN LD =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= LD2;
				
			WHEN LD2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= LD3;
			
			WHEN LD3 =>
			    SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= LD4;
			
			WHEN LD4 =>
			    SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= inicial;
			
			WHEN LDI =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "01";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
			WHEN EADD =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= EADD2;
				
			WHEN EADD2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= EADD3;
			
			WHEN EADD3 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= EADD4;
			
			WHEN EADD4 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '1';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= inicial;
				
			WHEN EADDI1 =>
				SelB <= '1';
				Op <= "000";
				WrStatus <= '1';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
			WHEN ESP1 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ESP2;
				
			WHEN ESP2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= inicial;
			
				
			WHEN SUB1 =>
				SelB <= '0';
				Op <= "001";
				WrStatus <= '1';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= SUB2;
				
			WHEN SUB2 =>
				SelB <= '0';
				Op <= "001";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= SUB3;
			
			WHEN SUB3 =>
				SelB <= '0';
				Op <= "001";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= SUB4;
			
			WHEN SUB4 =>
				SelB <= '0';
				Op <= "001";
				WrStatus <= '1';
				SelA <= "10";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= inicial;
				
			WHEN SUBI1 =>
				SelB <= '1';
				Op <= "001";
				WrStatus <= '1';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
			--BIP II
			WHEN BEQ =>
				IF (Z='1') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				WHEN BNE =>
				IF (Z='0') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				
				WHEN BGT =>
				IF (Z='0' AND N='0') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				WHEN BGE=>
				IF (N='0') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				WHEN BLT =>
				IF (N='1') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				WHEN BLE =>
				IF (Z='1' OR N='1') THEN
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				ELSE
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '0';
					WrPC <= '1';
					prox_estado <= ESP1;
				END IF;
				
				WHEN JMP =>
				
					SelB <= '0';
					Op <= "000";
					WrStatus <= '0';
					SelA <= "00";
					WrAcc <= '0';
					WrRam <= '0';
					RdRam <= '0';
					Branch <= '1';
					WrPC <= '1';
					prox_estado <= ESP1;
				
				
			--BIP III	
			WHEN NO =>
				SelB <= '0';
				Op <= "101";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
			WHEN ANND =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ANND1;
				
				WHEN ANND1 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ANND2;
				
			WHEN ANND2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ANND3;
				
				WHEN ANND3 =>
				SelB <= '0';
				Op <= "010";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ESP2;
				
				WHEN ANNDI =>
				SelB <= '1';
				Op <= "010";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
				
				WHEN OOR =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= OOR1;
				
				WHEN OOR1 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= OOR2;
				
			WHEN OOR2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= OOR3;
				
				WHEN OOR3 =>
				SelB <= '0';
				Op <= "011";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ESP2;
				
				WHEN OORI =>
				SelB <= '1';
				Op <= "011";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
				
				WHEN XOOR =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= XOOR1;
				
				WHEN XOOR1 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= XOOR2;
				
			WHEN XOOR2 =>
				SelB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SelA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= XOOR3;
				
				WHEN XOOR3 =>
				SelB <= '0';
				Op <= "100";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				prox_estado <= ESP2;
				
				WHEN XORI =>
				SelB <= '1';
				Op <= "100";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
				WHEN SLLL =>
				SelB <= '1';
				Op <= "110";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
				WHEN SRLL =>
				SelB <= '1';
				Op <= "111";
				WrStatus <= '0';
				SelA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				prox_estado <= ESP1;
				
				WHEN OTHERS =>
				prox_estado <= inicial;
			 
			
		END CASE;
	END PROCESS;
END arch;
