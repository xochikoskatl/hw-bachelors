library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Tarea10311 is
	port(	CLOCK_50: in std_logic;
			KEY: 	in std_logic_vector (3 downto 0);
			HEX0, HEX1, HEX2, HEX3: out std_logic_vector (6 downto 0);
			GPIO_1: out std_logic_vector (35 downto 0));
end Tarea10311;

architecture comportamiento of Tarea10311 is
	signal cuenta: integer range 0 to 99;
	signal cuenta09: integer range 0 to 9;
	type estados is (encendido, apagado);
	signal estado_pr, sig_estado: estados;
	signal tempo: integer range 0 to 100;
	signal timeON: integer range 0 to 100;
	signal timeOFF: integer range 0 to 100;
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:= '1';
	signal prescaler1: integer range 0 to 50000000:= 0;
	signal auxclock1: std_logic:= '1';

begin

	timeON <= cuenta;
	timeOFF <= 100 - timeON;

	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler < 5000000) then
				prescaler <= prescaler + 1;
				auxclock <= '1';
			else 
				prescaler <= 0;
				auxclock <= '0';
			end if;
		end if;	
	end process;
	
	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler1 < 10000) then --20ms
				prescaler1 <= prescaler1 + 1;
				auxclock1 <= '1';
			else 
				prescaler1 <= 0;
				auxclock1 <= '0';
			end if;
		end if;	
	end process;
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then
				if (cuenta < 99) then
					cuenta <= cuenta + 1;
				else	
					cuenta <= 0;
				end if;
			else
				if (KEY(1) = '0') then
					if (cuenta > 0) then
						cuenta <= cuenta -1;
					else	
						cuenta <= 99;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then
				if (cuenta09 < 9) then
					cuenta09 <= cuenta09 + 1;
				else	
					cuenta09 <= 0;
				end if;
			else
				if (KEY(1) = '0') then
					if (cuenta09 > 0) then
						cuenta09 <= cuenta09 -1;
					else	
						cuenta09 <= 9;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	HEX0 <= 	"1000000" when cuenta09 = 0 else
				"1111001" when cuenta09 = 1 else
				"0100100" when cuenta09 = 2 else 
				"0110000" when cuenta09 = 3 else 
				"0011001" when cuenta09 = 4 else
				"0010010" when cuenta09 = 5 else
				"0000011" when cuenta09 = 6 else
				"1111000" when cuenta09 = 7 else
				"0000000" when cuenta09 = 8 else
				"0011000";
				
	HEX1 <= 	"1111111" when cuenta <= 9 else 
				"1111001" when cuenta > 9 and cuenta <= 19 else 
				"0100100" when cuenta > 19 and cuenta <= 29 else 
				"0110000" when cuenta > 29 and cuenta <= 39 else 
				"0011001" when cuenta > 39 and cuenta <= 49 else 
				"0010010" when cuenta > 49 and cuenta <= 59 else 	
				"0000010" when cuenta > 59 and cuenta <= 69 else 
				"1111000" when cuenta > 69 and cuenta <= 79 else 
				"0000000" when cuenta > 79 and cuenta <= 89 else
				"0011000"; 
				
	HEX2 <= 	"1111111";	
	HEX3 <= 	"1111111";

	process (auxclock1)
		variable cont: integer range 0 to 100;
	begin
		if (auxclock1 'event and auxclock1 = '0') then
			cont:=cont+1;
			if cont=tempo then
				estado_pr <= sig_estado;
				cont:=0;
			end if;
		end if;
	end process;
	
	process (estado_pr)
	begin
		case estado_pr is
			when encendido =>
				GPIO_1(0) <= '1';
				sig_estado <= apagado;
				tempo <= timeON;
			when apagado =>
				GPIO_1(0) <= '0';
				sig_estado <= encendido;
				tempo <= timeOFF;
		end case;
	end process;
	
end comportamiento;
