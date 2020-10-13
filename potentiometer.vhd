library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Tarea10240pot is
port(
	CLOCK_50: in std_logic;
	KEY: 	in std_logic_vector (3 downto 0);
	HEX0: out std_logic_vector (6 downto 0);
	HEX1: out std_logic_vector (6 downto 0);
	HEX2: out std_logic_vector (6 downto 0);
	HEX3: out std_logic_vector (6 downto 0);
	LEDR: out std_logic_vector (9 downto 0)
);
end Tarea10240pot;

architecture main of Tarea10240pot is
	signal cuenta: std_logic_vector (9 downto 0);
	signal cuenta09: std_logic_vector (3 downto 0);
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:= '1';
	
begin
	
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
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then
				if (cuenta < "0001100011") then
					cuenta <= cuenta + 1;
				else	
					cuenta <= "0000000000";
				end if;
			else
				if (KEY(1) = '0') then
					if (cuenta > "0000000000") then
						cuenta <= cuenta -1;
					else	
						cuenta <= "0001100011";
					end if;
				end if;
			end if;
		end if;
	end process;
	
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then
				if (cuenta09 < "1001") then
					cuenta09 <= cuenta09 + 1;
				else	
					cuenta09 <= "0000";
				end if;
			else
				if (KEY(1) = '0') then
					if (cuenta09 > "0000") then
						cuenta09 <= cuenta09 -1;
					else	
						cuenta09 <= "1001";
					end if;
				end if;
			end if;
		end if;
	end process;
	
	LEDR <= cuenta;
	
	HEX0 <= 	"1000000" when cuenta09 = "0000" else
				"1111001" when cuenta09 = "0001" else
				"0100100" when cuenta09 = "0010" else 
				"0110000" when cuenta09 = "0011" else 
				"0011001" when cuenta09 = "0100" else
				"0010010" when cuenta09 = "0101" else
				"0000011" when cuenta09 = "0110" else
				"1111000" when cuenta09 = "0111" else
				"0000000" when cuenta09 = "1000" else
				"0011000";
				
	HEX1 <= 	"1111111" when cuenta <= "0000001001" else --9
				"1111001" when cuenta > "0000001001" and cuenta <= "0000010011" else --19
				"0100100" when cuenta > "0000010011" and cuenta <= "0000011101" else --29
				"0110000" when cuenta > "0000011101" and cuenta <= "0000100111" else --39
				"0011001" when cuenta > "0000100111" and cuenta <= "0000110001" else --49
				"0010010" when cuenta > "0000110001" and cuenta <= "0000111011" else --59				
				"0000010" when cuenta > "0000111011" and cuenta <= "0001000101" else --69
				"1111000" when cuenta > "0001000101" and cuenta <= "0001001111" else --79
				"0000000" when cuenta > "0001001111" and cuenta <= "0001011001" else --89
				"0011000"; --99
				
	HEX2 <= 	"1111111";
	HEX3 <= 	"1111111";

end main;
