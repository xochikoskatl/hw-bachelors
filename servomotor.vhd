library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Tarea10310PWM is
	port(	CLOCK_50: in std_logic;
			KEY: 	in std_logic_vector (3 downto 0);
			HEX0, HEX1, HEX2, HEX3: out std_logic_vector (6 downto 0);
			GPIO_1: out std_logic_vector (35 downto 0));
end Tarea10310PWM;

architecture comportamiento of Tarea10310PWM is
	signal cuenta: integer range 0 to 179;
	signal cuenta09: integer range 0 to 9;
	constant periodo: integer:=2143;
	type estados is (encendido, apagado);
	signal estado_pr, sig_estado: estados;
	signal tempo: integer range 0 to periodo;
	signal timeON: integer range 0 to periodo;
	signal timeOFF: integer range 0 to periodo;
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:= '1';
	signal prescaler1: integer range 0 to 50000000:= 0;
	signal auxclock1: std_logic:= '1';

begin

	timeON <= 56 + cuenta;
	timeOFF <= periodo - timeON;

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
			if (prescaler1 < 467) then --9.3333us
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
				if (cuenta < 179) then
					cuenta <= cuenta + 1;
				else	
					cuenta <= 0;
				end if;
			else
				if (KEY(1) = '0') then
					if (cuenta > 0) then
						cuenta <= cuenta -1;
					else	
						cuenta <= 179;
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
				"1000000" when cuenta > 99 and cuenta <= 109 else
				"1111001" when (cuenta > 9 and cuenta <= 19) or (cuenta > 109 and cuenta <= 119) else 
				"0100100" when (cuenta > 19 and cuenta <= 29) or (cuenta > 119 and cuenta <= 129) else 
				"0110000" when (cuenta > 29 and cuenta <= 39) or (cuenta > 129 and cuenta <= 139) else 
				"0011001" when (cuenta > 39 and cuenta <= 49) or (cuenta > 139 and cuenta <= 149) else 
				"0010010" when (cuenta > 49 and cuenta <= 59) or (cuenta > 149 and cuenta <= 159) else 				
				"0000010" when (cuenta > 59 and cuenta <= 69) or (cuenta > 159 and cuenta <= 169) else 
				"1111000" when (cuenta > 69 and cuenta <= 79) or (cuenta > 169 and cuenta <= 179)else 
				"0000000" when (cuenta > 79 and cuenta <= 89) else
				"0011000" when (cuenta > 89 and cuenta <= 99); 
				
	HEX2 <= 	"1111001" when cuenta > 99 else
				"1111111";
	
	HEX3 <= 	"1111111";

	process (auxclock1)
		variable cont: integer range 0 to periodo;
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
