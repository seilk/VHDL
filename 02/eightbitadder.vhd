LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY eightbitadder IS 
	PORT
	(
		Cin :  IN  STD_LOGIC;
		A_EBA :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		B_EBA :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		Cout :  OUT  STD_LOGIC;
		sum0 :  OUT  STD_LOGIC;
		sum1 :  OUT  STD_LOGIC;
		sum2 :  OUT  STD_LOGIC;
		sum3 :  OUT  STD_LOGIC;
		sum4 :  OUT  STD_LOGIC;
		sum5 :  OUT  STD_LOGIC;
		sum6 :  OUT  STD_LOGIC;
		sum7 :  OUT  STD_LOGIC
	);
END eightbitadder;

ARCHITECTURE eightbitadder_arc OF eightbitadder IS 

COMPONENT FullAdder
	PORT(cin : IN STD_LOGIC;
		 A_FA : IN STD_LOGIC;
		 B_FA : IN STD_LOGIC;
		 sum : OUT STD_LOGIC;
		 cout : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	signal0 :  STD_LOGIC;
SIGNAL	signal1 :  STD_LOGIC;
SIGNAL	signal2 :  STD_LOGIC;
SIGNAL	signal3 :  STD_LOGIC;
SIGNAL	signal4 :  STD_LOGIC;
SIGNAL	signal5 :  STD_LOGIC;
SIGNAL	signal6 :  STD_LOGIC;


BEGIN 



fa1 : FullAdder
PORT MAP(cin => Cin,
		 A_FA => A_EBA(0),
		 B_FA => B_EBA(0),
		 sum => sum0,
		 cout => signal0);


fa2 : FullAdder
PORT MAP(cin => signal0,
		 A_FA => A_EBA(1),
		 B_FA => B_EBA(1),
		 sum => sum1,
		 cout => signal1);


fa3 : FullAdder
PORT MAP(cin => signal1,
		 A_FA => A_EBA(2),
		 B_FA => B_EBA(2),
		 sum => sum2,
		 cout => signal2);


fa4 : FullAdder
PORT MAP(cin => signal2,
		 A_FA => A_EBA(3),
		 B_FA => B_EBA(3),
		 sum => sum3,
		 cout => signal3);


fa5 : FullAdder
PORT MAP(cin => signal3,
		 A_FA => A_EBA(4),
		 B_FA => B_EBA(4),
		 sum => sum4,
		 cout => signal4);


fa6 : FullAdder
PORT MAP(cin => signal4,
		 A_FA => A_EBA(5),
		 B_FA => B_EBA(5),
		 sum => sum5,
		 cout => signal5);


fa7 : FullAdder
PORT MAP(cin => signal5,
		 A_FA => A_EBA(6),
		 B_FA => B_EBA(6),
		 sum => sum6,
		 cout => signal6);


fa8 : FullAdder
PORT MAP(cin => signal6,
		 A_FA => A_EBA(7),
		 B_FA => B_EBA(7),
		 sum => sum7,
		 cout => Cout);


END eightbitadder_arc;