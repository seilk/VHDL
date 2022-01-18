
LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY eightbitmult IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		output_mult :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END eightbitmult;

ARCHITECTURE eightbitmult_arc OF eightbitmult IS 

COMPONENT eightbitadder
	PORT(Cin : IN STD_LOGIC;
		 A_EBA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B_EBA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Cout : OUT STD_LOGIC;
		 sum4 : OUT STD_LOGIC;
		 sum5 : OUT STD_LOGIC;
		 sum6 : OUT STD_LOGIC;
		 sum7 : OUT STD_LOGIC;
		 sum0 : OUT STD_LOGIC;
		 sum1 : OUT STD_LOGIC;
		 sum2 : OUT STD_LOGIC;
		 sum3 : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	signal0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal6 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal7 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal8 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal9 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal10 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal11 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal12 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal13 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	signal14 :  STD_LOGIC;
SIGNAL	signal15 :  STD_LOGIC;
SIGNAL	signal16 :  STD_LOGIC;
SIGNAL	signal17 :  STD_LOGIC;
SIGNAL	signal18 :  STD_LOGIC;
SIGNAL	signal19 :  STD_LOGIC;
SIGNAL	signal20 :  STD_LOGIC;


BEGIN 
signal14 <= '0';
signal15 <= '0';
signal16 <= '0';
signal17 <= '0';
signal18 <= '0';
signal19 <= '0';
signal20 <= '0';



signal10(7) <= A(7) AND B(1);


signal10(2) <= A(2) AND B(1);


signal10(1) <= A(1) AND B(1);


signal9(3) <= A(4) AND B(0);




adder0 : eightbitadder
PORT MAP(Cin => signal14,
		 A_EBA => signal8,
		 B_EBA => signal11,
		 Cout => signal7(7),
		 sum4 => signal7(3),
		 sum5 => signal7(4),
		 sum6 => signal7(5),
		 sum7 => signal7(6),
		 sum0 => output_mult(2),
		 sum1 => signal7(0),
		 sum2 => signal7(1),
		 sum3 => signal7(2));


signal9(2) <= A(3) AND B(0);


signal11(0) <= A(0) AND B(2);


signal11(1) <= A(1) AND B(2);


signal11(2) <= A(2) AND B(2);


signal11(3) <= A(3) AND B(2);


signal11(4) <= A(4) AND B(2);


signal11(5) <= A(5) AND B(2);


signal11(6) <= A(6) AND B(2);


signal11(7) <= A(7) AND B(2);



adder1 : eightbitadder
PORT MAP(Cin => signal15,
		 A_EBA => signal7,
		 B_EBA => signal12,
		 Cout => signal6(7),
		 sum4 => signal6(3),
		 sum5 => signal6(4),
		 sum6 => signal6(5),
		 sum7 => signal6(6),
		 sum0 => output_mult(3),
		 sum1 => signal6(0),
		 sum2 => signal6(1),
		 sum3 => signal6(2));


signal9(4) <= A(5) AND B(0);


signal12(0) <= A(0) AND B(3);


signal12(1) <= A(1) AND B(3);


signal12(2) <= A(2) AND B(3);


signal12(3) <= A(3) AND B(3);


signal12(4) <= A(4) AND B(3);


signal12(5) <= A(5) AND B(3);


signal12(6) <= A(6) AND B(3);


signal12(7) <= A(7) AND B(3);



adder2 : eightbitadder
PORT MAP(Cin => signal16,
		 A_EBA => signal6,
		 B_EBA => signal13,
		 Cout => signal1(7),
		 sum4 => signal1(3),
		 sum5 => signal1(4),
		 sum6 => signal1(5),
		 sum7 => signal1(6),
		 sum0 => output_mult(4),
		 sum1 => signal1(0),
		 sum2 => signal1(1),
		 sum3 => signal1(2));


signal9(5) <= A(6) AND B(0);


signal13(0) <= A(0) AND B(4);


signal13(1) <= A(1) AND B(4);


signal13(2) <= A(2) AND B(4);


signal13(3) <= A(3) AND B(4);


signal13(4) <= A(4) AND B(4);


signal13(5) <= A(5) AND B(4);


signal13(6) <= A(6) AND B(4);


signal13(7) <= A(7) AND B(4);



adder3 : eightbitadder
PORT MAP(Cin => signal17,
		 A_EBA => signal1,
       B_EBA => signal2,
		 Cout => signal0(7),
		 sum4 => signal0(3),
		 sum5 => signal0(4),
		 sum6 => signal0(5),
		 sum7 => signal0(6),
		 sum0 => output_mult(5),
		 sum1 => signal0(0),
		 sum2 => signal0(1),
		 sum3 => signal0(2));


signal9(6) <= A(7) AND B(0);


signal2(0) <= A(0) AND B(5);


signal2(1) <= A(1) AND B(5);


signal2(2) <= A(2) AND B(5);


signal2(3) <= A(3) AND B(5);


signal2(4) <= A(4) AND B(5);


signal2(5) <= A(5) AND B(5);


signal2(6) <= A(6) AND B(5);


signal2(7) <= A(7) AND B(5);



adder4 : eightbitadder
PORT MAP(Cin => signal18,
		 A_EBA => signal0,
		 B_EBA => signal3,
		 Cout => signal4(7),
		 sum4 => signal4(3),
		 sum5 => signal4(4),
		 sum6 => signal4(5),
		 sum7 => signal4(6),
		 sum0 => output_mult(6),
		 sum1 => signal4(0),
		 sum2 => signal4(1),
		 sum3 => signal4(2));


signal3(0) <= A(0) AND B(6);


signal3(1) <= A(1) AND B(6);


signal3(2) <= A(2) AND B(6);


signal3(3) <= A(3) AND B(6);


signal3(4) <= A(4) AND B(6);


signal3(5) <= A(5) AND B(6);


signal3(6) <= A(6) AND B(6);


signal3(7) <= A(7) AND B(6);



adder5 : eightbitadder
PORT MAP(Cin => signal19,
		 A_EBA => signal4,
		 B_EBA => signal5,
		 Cout => output_mult(15),
		 sum4 => output_mult(11),
		 sum5 => output_mult(12),
		 sum6 => output_mult(13),
		 sum7 => output_mult(14),
		 sum0 => output_mult(7),
		 sum1 => output_mult(8),
		 sum2 => output_mult(9),
		 sum3 => output_mult(10));


signal10(0) <= A(0) AND B(1);


signal5(0) <= A(0) AND B(7);


signal5(1) <= A(1) AND B(7);


signal5(2) <= A(2) AND B(7);


signal5(3) <= A(3) AND B(7);


signal5(4) <= A(4) AND B(7);


signal5(5) <= A(5) AND B(7);


signal5(6) <= A(6) AND B(7);


signal5(7) <= A(7) AND B(7);



signal10(4) <= A(4) AND B(1);


signal10(3) <= A(3) AND B(1);


signal9(1) <= A(2) AND B(0);


signal9(0) <= A(1) AND B(0);


signal10(6) <= A(6) AND B(1);


signal10(5) <= A(5) AND B(1);


output_mult(0) <= A(0) AND B(0);


adder6 : eightbitadder
PORT MAP(Cin => signal20,
		 A_EBA => signal9,
		 B_EBA => signal10,
		 Cout => signal8(7),
		 sum4 => signal8(3),
		 sum5 => signal8(4),
		 sum6 => signal8(5),
		 sum7 => signal8(6),
		 sum0 => output_mult(1),
		 sum1 => signal8(0),
		 sum2 => signal8(1),
		 sum3 => signal8(2));


signal9(7) <= '0';
END eightbitmult_arc;