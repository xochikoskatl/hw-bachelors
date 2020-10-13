library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Tarea10101corr is
port(
	CLOCK_50: in std_logic;
	key: in std_logic;
	renglones: inout std_logic_vector (3 downto 0);
	columnas: inout std_logic_vector (3 downto 0);
	HEX0: out std_logic_vector (6 downto 0);
	HEX1: out std_logic_vector (6 downto 0);
	HEX2: out std_logic_vector (6 downto 0);
	HEX3: out std_logic_vector (6 downto 0)
);
end Tarea10101corr;

architecture comportamiento of Tarea10101corr is
	signal cuenta: integer range 0 to 3:= 0;
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:='1';
	signal vector: std_logic_vector (7 downto 0);
	signal entrada: std_logic_vector (6 downto 0);
	signal A: std_logic_vector (6 downto 0);
	signal B: std_logic_vector (6 downto 0);
	signal C: std_logic_vector (6 downto 0);
	signal D: std_logic_vector (6 downto 0);
	signal guion: std_logic_vector (6 downto 0);
	signal flag: std_logic:='0';
	signal sw: std_logic;

begin 
	
	vector <= renglones&columnas;

	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50='1') then
			if (prescaler < 5000000) then
				prescaler <= prescaler + 1;
				auxclock <= '1';
			else
				prescaler <= 0;
				auxclock <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock = '0') then
			if (sw = '0') then
				guion <= "1111111";
				sw <= '1';
			else
				guion <= "1110111";
				sw <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
				if (columnas = "1111") then
					if (cuenta < 3) then
						cuenta <= cuenta + 1;
					else
						cuenta <= 0;
					end if;
					flag <= '0';
				else
					flag <= '1';
				end if;
		end if;
	end process;
	
	renglones <= 	"0111" when cuenta = 0 else
						"1011" when cuenta = 1 else
						"1101" when cuenta = 2 else
						"1110" when cuenta = 3;
						
	entrada <=  "1111001" when vector = "01110111" else --1
					"0100100" when vector = "01111011" else --2
					"0110000" when vector = "01111101" else --3
					"0001000" when vector = "01111110" else --A
					"0011001" when vector = "10110111" else --4
					"0010010" when vector = "10111011" else --5
					"0000010" when vector = "10111101" else --6
					"0000011" when vector = "10111110" else --B
					"1111000" when vector = "11010111" else --7
					"0000000" when vector = "11011011" else --8
					"0011000" when vector = "11011101" else --9
					"1000110" when vector = "11011110" else --C
					"0111111" when vector = "11100111" else --*
					"1000000" when vector = "11101011" else --0
					"0001001" when vector = "11101101" else --#
					"0100001" when vector = "11101110" else --D
					"1111111";
					
	HEX0 <= 	guion when A = "1110111" else
				A;
	HEX1 <= 	guion when B = "1110111" else
				B;
	HEX2 <= 	guion when C = "1110111" else
				C;
	HEX3 <= 	guion when D = "1110111" else
				D;
	
	process(flag)
	begin
		if (key = '0') then
			A <= "1110111";
			B <= "1111111";
			C <= "1111111";
			D <= "1111111";
		else
			if (flag 'event and flag = '1') then
				A <= entrada;
				B <= A;
				C <= B;
				D <= C;
			end if;
		end if;
	end process;
		
end comportamiento;
