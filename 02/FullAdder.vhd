LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY FullAdder IS 
	PORT
	(
		A_FA :  IN  STD_LOGIC;
		B_FA :  IN  STD_LOGIC;
		cin :  IN  STD_LOGIC;
		sum :  OUT  STD_LOGIC;
		cout :  OUT  STD_LOGIC
	);
END FullAdder;

ARCHITECTURE FullAdder_arc OF FullAdder IS 

COMPONENT HalfAdder IS 
	PORT
	(
		A_HA :  IN  STD_LOGIC;
		B_HA :  IN  STD_LOGIC;
		cout :  OUT  STD_LOGIC;
		sum :  OUT  STD_LOGIC
	);
END COMPONENT;

SIGNAL	signal0 :  STD_LOGIC;
SIGNAL	signal1 :  STD_LOGIC;
SIGNAL	signal2 :  STD_LOGIC;


BEGIN 



cout <= signal0 OR signal1;


ha0 : HalfAdder
PORT MAP(A_HA => A_FA,
		 B_HA => B_FA,
		 sum => signal2,
		 cout => signal0);


ha1 : HalfAdder
PORT MAP(A_HA => cin,
		 B_HA => signal2,
		 sum => sum,
		 cout => signal1);


END FullAdder_arc;