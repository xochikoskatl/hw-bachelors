library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity Tarea09260reloj is
port(
	CLOCK_50: std_logic;
	HEX0: out std_logic_vector (6 downto 0);
	HEX1: out std_logic_vector (6 downto 0);
	HEX2: out std_logic_vector (6 downto 0);
	HEX3: out std_logic_vector (6 downto 0);
	SW: in std_logic_vector (9 downto 0)
);
end Tarea09260reloj;

architecture comportamiento of Tarea09260reloj is
	signal cuenta: integer range 0 to 59:= 0;
	signal cuenta09: integer range 0 to 9:= 0;
	signal cuenta09min: integer range 0 to 9:= 0;
	signal cuentamin: integer range 0 to 59:= 0;
	signal cuentahor: integer range 0 to 23:= 0;
	
	signal prescaler: integer range 0 to 50000000:= 0;
	signal prescaler1: integer range 0 to 60:= 0;
	signal prescaler2: integer range 0 to 60:= 0;
	
	signal auxclock: std_logic:='1';
	signal auxclock1: std_logic:='1';
	signal auxclock2: std_logic:='1';
	
	signal segundosu: std_logic_vector (6 downto 0);
	signal segundosd: std_logic_vector (6 downto 0);
	signal minutosu: std_logic_vector (6 downto 0);
	signal minutosd: std_logic_vector (6 downto 0);
	signal horasu: std_logic_vector (6 downto 0);
	signal horasd: std_logic_vector (6 downto 0);

begin 
	process (CLOCK_50)
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
	
	--contador del 0 al 9 segundos
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (cuenta09 < 9) then
				cuenta09 <= cuenta09 + 1;
			else
				cuenta09 <= 0;
			end if;
		end if;
	end process;
	
	--contador del 0 al 9 minutos
	process (auxclock1)
	begin
		if (auxclock1 'event and auxclock1='0') then
			if (cuenta09min < 9) then
				cuenta09min <= cuenta09min + 1;
			else
				cuenta09min <= 0;
			end if;
		end if;
	end process;

	--contador segundos
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (cuenta < 59) then
				cuenta <= cuenta + 1;
			else
				cuenta <= 0;
			end if;
		end if;
	end process;
	
	--contador minutos (60 veces mas lento que el contador de segundos)
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='1') then
			if (prescaler1 < 59) then
				prescaler1 <= prescaler1 + 1;
				auxclock1 <= '1';
			else
				prescaler1 <= 0;
				auxclock1 <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock1)
	begin
		if (auxclock1 'event and auxclock1='0') then
			if (cuentamin < 59) then
				cuentamin <= cuentamin + 1;
			else
				cuentamin <= 0;
			end if;
		end if;
	end process;
	
	--contador horas (60 veces mas lento que el contador de minutos)
	process (auxclock1)
	begin
		if (auxclock1 'event and auxclock1='1') then
			if (prescaler2 < 59) then
				prescaler2 <= prescaler2 + 1;
				auxclock2 <= '1';
			else
				prescaler2 <= 0;
				auxclock2 <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock2)
	begin
		if (auxclock2 'event and auxclock2='0') then
			if (cuentahor < 23) then
				cuentahor <= cuentahor + 1;
			else
				cuentahor <= 0;
			end if;
		end if;
	end process;
	
	segundosu <= 	"1000000" when cuenta09 = 0 else
						"1111001" when cuenta09 = 1 else
						"0100100" when cuenta09 = 2 else 
						"0110000" when cuenta09 = 3 else 
						"0011001" when cuenta09 = 4 else
						"0010010" when cuenta09 = 5 else
						"0000011" when cuenta09 = 6 else
						"1111000" when cuenta09 = 7 else
						"0000000" when cuenta09 = 8 else
						"0011000";
				
	segundosd <= 	"1000000" when cuenta <= 9 else
						"1111001" when cuenta > 9 and cuenta <= 19 else
						"0100100" when cuenta > 19 and cuenta <= 29 else
						"0110000" when cuenta > 29 and cuenta <= 39 else
						"0011001" when cuenta > 39 and cuenta <= 49 else
						"0010010";
				
	minutosu <= "1000000" when cuenta09min = 0 else
					"1111001" when cuenta09min = 1 else
					"0100100" when cuenta09min = 2 else 
					"0110000" when cuenta09min = 3 else 
					"0011001" when cuenta09min = 4 else
					"0010010" when cuenta09min = 5 else
					"0000011" when cuenta09min = 6 else
					"1111000" when cuenta09min = 7 else
					"0000000" when cuenta09min = 8 else
					"0011000"; 	
	
	minutosd <= "1000000" when cuentamin <= 9 else
					"1111001" when cuentamin > 9 and cuentamin <= 19 else
					"0100100" when cuentamin > 19 and cuentamin <= 29 else
					"0110000" when cuentamin > 29 and cuentamin <= 39 else
					"0011001" when cuentamin > 39 and cuentamin <= 49 else
					"0010010";
					
	horasu <= 	"1000000" when cuentahor = 0 else
					"1111001" when cuentahor = 1 else
					"0100100" when cuentahor = 2 else 
					"0110000" when cuentahor = 3 else 
					"0011001" when cuentahor = 4 else
					"0010010" when cuentahor = 5 else
					"0000011" when cuentahor = 6 else
					"1111000" when cuentahor = 7 else
					"0000000" when cuentahor = 8 else
					"0011000" when cuentahor = 9 else
					"1000000" when cuentahor = 10 else
					"1111001" when cuentahor = 11 else
					"0100100" when cuentahor = 12 else 
					"0110000" when cuentahor = 13 else 
					"0011001" when cuentahor = 14 else
					"0010010" when cuentahor = 15 else
					"0000011" when cuentahor = 16 else
					"1111000" when cuentahor = 17 else
					"0000000" when cuentahor = 18 else
					"0011000" when cuentahor = 19 else
					"1000000" when cuentahor = 20 else
					"1111001" when cuentahor = 21 else
					"0100100" when cuentahor = 22 else 
					"0110000";
					
	horasd <= 	"1000000" when cuentahor <= 9 else
					"1111001" when cuentahor > 9 and cuentahor <= 19 else
					"0100100";
					
	with sw(0) select
	HEX0 <= 	segundosu when '0',
				minutosu when others;
	
	with sw(0) select
	HEX1 <= 	segundosd when '0',
				minutosd when others;
				
	with sw(0) select
	HEX2 <= 	minutosu when '0',
				horasu when others;
				
	with sw(0) select
	HEX3 <= 	minutosd when '0',
				horasd when others;
		
end comportamiento;
