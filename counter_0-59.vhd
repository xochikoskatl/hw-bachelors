library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Tarea09190 is
port(
	CLOCK_50: std_logic;
	HEX0: out std_logic_vector (6 downto 0);
	HEX1: out std_logic_vector (6 downto 0);
	HEX2: out std_logic_vector (6 downto 0);
	HEX3: out std_logic_vector (6 downto 0)
);
end Tarea09190;

architecture comportamiento of Tarea09190 is
	signal cuenta: integer range 0 to 59:= 0;
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:='1';

begin 
	process (CLOCK_50) -- realiza un pulso de reloj cada segundo
	begin
		if (CLOCK_50 'event and CLOCK_50='1') then
			if (prescaler < 50000000) then
				prescaler <= prescaler + 1;
				auxclock <= '1';
			else
				prescaler <= 0;
				auxclock <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock) -- lista de sensibilidad, se ejecuta cada segundo
	begin
		if (auxclock 'event and auxclock='0') then
			if (cuenta < 59) then
				cuenta <= cuenta + 1;
			else
				cuenta <= 0;
			end if;
		end if;
	end process;
	
	HEX0 <= 	"1000000" when cuenta = 0 else
				"1111001" when cuenta = 1 else
				"0100100" when cuenta = 2 else 
				"0110000" when cuenta = 3 else 
				"0011001" when cuenta = 4 else
				"0010010" when cuenta = 5 else
				"0000011" when cuenta = 6 else
				"1111000" when cuenta = 7 else
				"0000000" when cuenta = 8 else
				"0011000" when cuenta = 9 else
				"1000000" when cuenta = 10 else
				"1111001" when cuenta = 11 else
				"0100100" when cuenta = 12 else 
				"0110000" when cuenta = 13 else 
				"0011001" when cuenta = 14 else
				"0010010" when cuenta = 15 else
				"0000011" when cuenta = 16 else
				"1111000" when cuenta = 17 else
				"0000000" when cuenta = 18 else
				"0011000" when cuenta = 19 else
				"1000000" when cuenta = 20 else
				"1111001" when cuenta = 21 else
				"0100100" when cuenta = 22 else 
				"0110000" when cuenta = 23 else 
				"0011001" when cuenta = 24 else
				"0010010" when cuenta = 25 else
				"0000011" when cuenta = 26 else
				"1111000" when cuenta = 27 else
				"0000000" when cuenta = 28 else
				"0011000" when cuenta = 29 else
				"1000000" when cuenta = 30 else
				"1111001" when cuenta = 31 else
				"0100100" when cuenta = 32 else 
				"0110000" when cuenta = 33 else 
				"0011001" when cuenta = 34 else
				"0010010" when cuenta = 35 else
				"0000011" when cuenta = 36 else
				"1111000" when cuenta = 37 else
				"0000000" when cuenta = 38 else
				"0011000" when cuenta = 39 else
				"1000000" when cuenta = 40 else
				"1111001" when cuenta = 41 else
				"0100100" when cuenta = 42 else 
				"0110000" when cuenta = 43 else 
				"0011001" when cuenta = 44 else
				"0010010" when cuenta = 45 else
				"0000011" when cuenta = 46 else
				"1111000" when cuenta = 47 else
				"0000000" when cuenta = 48 else
				"0011000" when cuenta = 49 else
				"1000000" when cuenta = 50 else
				"1111001" when cuenta = 51 else
				"0100100" when cuenta = 52 else 
				"0110000" when cuenta = 53 else 
				"0011001" when cuenta = 54 else
				"0010010" when cuenta = 55 else
				"0000011" when cuenta = 56 else
				"1111000" when cuenta = 57 else
				"0000000" when cuenta = 58 else
				"0011000";
				
	HEX1 <= 	"1111111" when cuenta = 0 else
				"1111111" when cuenta = 1 else
				"1111111" when cuenta = 2 else 
				"1111111" when cuenta = 3 else 
				"1111111" when cuenta = 4 else
				"1111111" when cuenta = 5 else
				"1111111" when cuenta = 6 else
				"1111111" when cuenta = 7 else
				"1111111" when cuenta = 8 else
				"1111111" when cuenta = 9 else
				"1111001" when cuenta = 10 else
				"1111001" when cuenta = 11 else
				"1111001" when cuenta = 12 else 
				"1111001" when cuenta = 13 else 
				"1111001" when cuenta = 14 else
				"1111001" when cuenta = 15 else
				"1111001" when cuenta = 16 else
				"1111001" when cuenta = 17 else
				"1111001" when cuenta = 18 else
				"1111001" when cuenta = 19 else
				"0100100" when cuenta = 20 else
				"0100100" when cuenta = 21 else
				"0100100" when cuenta = 22 else 
				"0100100" when cuenta = 23 else 
				"0100100" when cuenta = 24 else
				"0100100" when cuenta = 25 else
				"0100100" when cuenta = 26 else
				"0100100" when cuenta = 27 else
				"0100100" when cuenta = 28 else
				"0100100" when cuenta = 29 else
				"0110000" when cuenta = 30 else
				"0110000" when cuenta = 31 else
				"0110000" when cuenta = 32 else 
				"0110000" when cuenta = 33 else 
				"0110000" when cuenta = 34 else
				"0110000" when cuenta = 35 else
				"0110000" when cuenta = 36 else
				"0110000" when cuenta = 37 else
				"0110000" when cuenta = 38 else
				"0110000" when cuenta = 39 else
				"0011001" when cuenta = 40 else
				"0011001" when cuenta = 41 else
				"0011001" when cuenta = 42 else 
				"0011001" when cuenta = 43 else 
				"0011001" when cuenta = 44 else
				"0011001" when cuenta = 45 else
				"0011001" when cuenta = 46 else
				"0011001" when cuenta = 47 else
				"0011001" when cuenta = 48 else
				"0011001" when cuenta = 49 else
				"0010010" when cuenta = 50 else
				"0010010" when cuenta = 51 else
				"0010010" when cuenta = 52 else 
				"0010010" when cuenta = 53 else 
				"0010010" when cuenta = 54 else
				"0010010" when cuenta = 55 else
				"0010010" when cuenta = 56 else
				"0010010" when cuenta = 57 else
				"0010010" when cuenta = 58 else
				"0010010";
				
	HEX2 <= "1111111";
	HEX3 <= "1111111";
		
end comportamiento;
