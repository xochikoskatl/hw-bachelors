library ieee;
use ieee.std_logic_1164.all;

entity Tarea10240semaforo is
port (
	CLOCK_50: in std_logic;
	SW: in std_logic_vector (9 downto 0);
	HEX0:	out std_logic_vector (6 downto 0);
	HEX1:	out std_logic_vector (6 downto 0);
	HEX2:	out std_logic_vector (6 downto 0);
	HEX3:	out std_logic_vector (6 downto 0)
);
end Tarea10240semaforo;

architecture main of Tarea10240semaforo is
	signal est_act: std_logic_vector (2 downto 0):="000";
	signal est_fut: std_logic_vector (2 downto 0);
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:= '1';
	signal prescaler1: integer range 0 to 50000000:= 0;
	signal auxclock1: std_logic:= '1';
	signal vp: std_logic_vector (6 downto 0);
	signal flag: std_logic;
	
begin

	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler < 50000000) then
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
		if (CLOCK_50 'event and CLOCK_50='1') then
			if (prescaler1 < 5000000) then
				prescaler1 <= prescaler1 + 1;
				auxclock1 <= '1';
			else
				prescaler1 <= 0;
				auxclock1 <= '0';
			end if;
		end if;
	end process;
	
	process (auxclock1) -- bloque para obtener la señal parpadeante
	begin
		if (auxclock1 'event and auxclock1 = '0') then
			if (flag = '0') then
				vp <= "1000001";
				flag <= '1';
			else
				vp <= "1111111";
				flag <= '0';
			end if;
		end if;
	end process;

	process(auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			est_act <= est_fut;
		end if;
	end process;
	
	process(est_act)
	begin
		case est_act is
			
			when "000" =>
				if (SW(0)='0') then
					est_fut <= "010";
					HEX0 <= "1000001";
				else
					est_fut <= "001";
					HEX0 <= "1000001";
				end if;
			
			when "001" => -- se pasa dos veces por el mismo estado
				est_fut <= "010";
				HEX0 <= "1000001";
			
			when "010" =>
				if (SW(0)='0') then
					est_fut <= "100";
					HEX0 <= vp;
				else
					est_fut <= "011";
					HEX0 <= vp;
				end if;
			
			when "011" =>
				est_fut <= "100";
				HEX0 <= vp;
			
			when "100" =>
				if (SW(0)='0') then
					est_fut <= "110";
					HEX0 <= "0001000";
				else
					est_fut <= "101";
					HEX0 <= "0001000";
				end if;
			
			when "101" =>
				est_fut <= "110";
				HEX0 <= "0001000";
			
			when "110" =>
				if (SW(0)='0') then
					est_fut <= "000";
					HEX0 <= "0101111";
				else
					est_fut <= "111";
					HEX0 <= "0101111";
				end if;
			
			when "111" =>
				est_fut <= "000";
				HEX0 <= "0101111";
				
		end case;
	end process;
	
	HEX1 <= "1111111";
	HEX2 <= "1111111";
	HEX3 <= "1111111";

end main;
