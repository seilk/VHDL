LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY HalfAdder IS 
	PORT
	(
		A_HA :  IN  STD_LOGIC;
		B_HA :  IN  STD_LOGIC;
		cout :  OUT  STD_LOGIC;
		sum :  OUT  STD_LOGIC
	);
END HalfAdder;

ARCHITECTURE HalfAdder_arc OF HalfAdder IS 



BEGIN 



sum <= A_HA XOR B_HA;


cout <= A_HA AND B_HA;


END HalfAdder_arc;