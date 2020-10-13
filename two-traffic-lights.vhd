library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Tarea10280semaforo is
	port( CLOCK_50, stby, test: in std_logic;
			r1, r2, y1, y2, g1, g2: out std_logic);
end Tarea10280semaforo;

architecture comportamiento of Tarea10280semaforo is
	constant timeMax	:	integer:=45; --45 segundos
	constant timeRG	:	integer:=30; --30 segundos
	constant timeRY	:	integer:=5; --5 segundos
	constant timeGR	: 	integer:=5; --5 segundos
	constant timeYR	:	integer:=5; --5 segundos
	constant timeTest	:	integer:=1; --1 segundo
	type estados is (RG, RY, GR, YR, YY); --nombres de los estados
	signal estado_pr, sig_estado: estados;
	signal tempo: integer range 0 to timeMax;
	signal prescaler: integer range 0 to 50000000:= 0;
	signal clk: std_logic:= '1';

begin
	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler < 50000000) then
				prescaler <= prescaler + 1;
				clk <= '1';
			else 
				prescaler <= 0;
				clk <= '0';
			end if;
		end if;	
	end process;

	process (clk, stby)
		variable cont: integer range 0 to timeMax;
	begin
		if (stby = '1') then
			estado_pr <= YY;
			cont:=0;
		elsif (clk 'event and clk = '0') then
			cont:=cont+1;
			if cont=tempo then
				estado_pr <= sig_estado;
				cont:=0;
			end if;
		end if;
	end process;
	
	process (estado_pr,test)
	begin
		case estado_pr is
			when RG =>
				r1<='1'; r2<='0'; y1<='0';
				y2<='0'; g1<='0'; g2<='1';
				sig_estado <= RY;
				if test='0' then tempo <=timeRG;
				else tempo <= timeTest;
				end if;
			when RY =>
				r1<='1'; r2<='0'; y1<='0';
				y2<='1'; g1<='0'; g2<='0';
				sig_estado <= GR;
				if test='0' then tempo <=timeRY;
				else tempo <= timeTest;
				end if;
			when GR =>
				r1<='0'; r2<='1'; y1<='0';
				y2<='0'; g1<='1'; g2<='0';
				sig_estado <= YR;
				if test='0' then tempo <=timeGR;
				else tempo <= timeTest;
				end if;
			when YR =>
				r1<='0'; r2<='1'; y1<='1';
				y2<='0'; g1<='0'; g2<='0';
				sig_estado <= RG;
				if test='0' then tempo <=timeYR;
				else tempo <= timeTest;
				end if;
			when YY =>
				r1<='0'; r2<='0'; y1<='1';
				y2<='1'; g1<='0'; g2<='0';
				sig_estado <= RY;
		end case;
	end process;
	
end comportamiento;
