library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Tarea09100 is
port (
	SW: in std_logic_vector (9 downto 0);
	HEX0: out std_logic_vector (6 downto 0);
	HEX1: out std_logic_vector (6 downto 0);
	HEX2: out std_logic_vector (6 downto 0);
	HEX3: out std_logic_vector (6 downto 0)
);
END Tarea09100;

architecture comportamiento of Tarea09100 is

	signal A: std_logic_vector (4 downto 0);
	signal B: std_logic_vector (4 downto 0);

begin

	A <= SW(9)&SW(8)&SW(7)&SW(6)&SW(5);
	B <= SW(4)&SW(3)&SW(2)&SW(1)&SW(0);
					
	HEX3 <= 	"1111111";
	HEX2 <= 	"0001000";
	HEX0 <= 	"0000011";

	--comparacion
	HEX1 <= 	"0110011" when A > B else 
			"0100111" when A < B else
			"0110111";
	
end comportamiento;
