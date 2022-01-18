library ieee;
use ieee.std_logic_1164.all;

-- 4 digit 7 segment entity. Do not modify
entity four_digit_sevenseg is
	port(
		in_num: in std_logic_vector(15 downto 0); -- input value (8 digit value / 8 digit value)
		out_0:  out std_logic_vector(6 downto 0); -- 0th digit (D)
		out_1:  out std_logic_vector(6 downto 0); -- 1th digit (C)
		out_2:  out std_logic_vector(6 downto 0); -- 2nd digit (B)
		out_3:  out std_logic_vector(6 downto 0) -- 3rd digit (A)
	);
end four_digit_sevenseg;

architecture fdss of four_digit_sevenseg is
	-- Declare your components and signals
	COMPONENT eightbitmult IS 
		PORT
		(
			A :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
			B :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
			output_mult :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT hexsevenseg is
		PORT 
		( 
			input_sevenseg : in  STD_LOGIC_VECTOR (3 downto 0);
         output_sevenseg : out  STD_LOGIC_VECTOR (6 downto 0)
		);
	END COMPONENT;
	
	
SIGNAL signal0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL signal1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL signal2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL signal3 : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL outputsig0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL outputsig1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL outputsig2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL outputsig3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
   --Define the architecture body
	X0 : eightbitmult
			PORT MAP(
				A(0) => in_num(0),
				A(1) => in_num(1),
				A(2) => in_num(2),
				A(3) => in_num(3),
				A(4) => in_num(4),
				A(5) => in_num(5),
				A(6) => in_num(6),
				A(7) => in_num(7),
				
				B(0) => in_num(8),
				B(1) => in_num(9),
				B(2) => in_num(10),
				B(3) => in_num(11),
				B(4) => in_num(12),
				B(5) => in_num(13),
				B(6) => in_num(14),
				B(7) => in_num(15),
				
				output_mult(0) => signal0(0),
				output_mult(1) => signal0(1),
				output_mult(2) => signal0(2),
				output_mult(3) => signal0(3),
				
				output_mult(4) => signal1(0),
				output_mult(5) => signal1(1),
				output_mult(6) => signal1(2),
				output_mult(7) => signal1(3),
				
				output_mult(8) => signal2(0),
				output_mult(9) => signal2(1),
				output_mult(10) => signal2(2),
				output_mult(11) => signal2(3),
				
				output_mult(12) => signal3(0),
				output_mult(13) => signal3(1),
				output_mult(14) => signal3(2),
				output_mult(15) => signal3(3)
				);
	
	Y0 : hexsevenseg
	PORT MAP(
				input_sevenseg(0) => signal0(0),
				input_sevenseg(1) => signal0(1),
				input_sevenseg(2) => signal0(2),
				input_sevenseg(3) => signal0(3),
				
				output_sevenseg(0) => outputsig0(0),
				output_sevenseg(1) => outputsig0(1),
				output_sevenseg(2) => outputsig0(2),
				output_sevenseg(3) => outputsig0(3),
				output_sevenseg(4) => outputsig0(4),
				output_sevenseg(5) => outputsig0(5),
				output_sevenseg(6) => outputsig0(6)
				);
	
	Y1 : hexsevenseg
	PORT MAP(
				input_sevenseg(0) => signal1(0),
				input_sevenseg(1) => signal1(1),
				input_sevenseg(2) => signal1(2),
				input_sevenseg(3) => signal1(3),
				
								
				output_sevenseg(0) => outputsig1(0),
				output_sevenseg(1) => outputsig1(1),
				output_sevenseg(2) => outputsig1(2),
				output_sevenseg(3) => outputsig1(3),
				output_sevenseg(4) => outputsig1(4),
				output_sevenseg(5) => outputsig1(5),
				output_sevenseg(6) => outputsig1(6)
				);
	
	Y2 : hexsevenseg
	PORT MAP(
				input_sevenseg(0) => signal2(0),
				input_sevenseg(1) => signal2(1),
				input_sevenseg(2) => signal2(2),
				input_sevenseg(3) => signal2(3),
				
				output_sevenseg(0) => outputsig2(0),
				output_sevenseg(1) => outputsig2(1),
				output_sevenseg(2) => outputsig2(2),
				output_sevenseg(3) => outputsig2(3),
				output_sevenseg(4) => outputsig2(4),
				output_sevenseg(5) => outputsig2(5),
				output_sevenseg(6) => outputsig2(6)
				);
				
	Y3 : hexsevenseg
	PORT MAP(
				input_sevenseg(0) => signal3(0),
				input_sevenseg(1) => signal3(1),
				input_sevenseg(2) => signal3(2),
				input_sevenseg(3) => signal3(3),
				
				output_sevenseg(0) => outputsig3(0),
				output_sevenseg(1) => outputsig3(1),
				output_sevenseg(2) => outputsig3(2),
				output_sevenseg(3) => outputsig3(3),
				output_sevenseg(4) => outputsig3(4),
				output_sevenseg(5) => outputsig3(5),
				output_sevenseg(6) => outputsig3(6)
				);

	out_0(0) <= outputsig0(0);
	out_0(1) <= outputsig0(1);
	out_0(2) <= outputsig0(2);
	out_0(3) <= outputsig0(3);
	out_0(4) <= outputsig0(4);
	out_0(5) <= outputsig0(5);
	out_0(6) <= outputsig0(6);
	
	out_1(0) <= outputsig1(0);
	out_1(1) <= outputsig1(1);
	out_1(2) <= outputsig1(2);
	out_1(3) <= outputsig1(3);
	out_1(4) <= outputsig1(4);
	out_1(5) <= outputsig1(5);
	out_1(6) <= outputsig1(6);
	
	out_2(0) <= outputsig2(0);
	out_2(1) <= outputsig2(1);
	out_2(2) <= outputsig2(2);
	out_2(3) <= outputsig2(3);
	out_2(4) <= outputsig2(4);
	out_2(5) <= outputsig2(5);
	out_2(6) <= outputsig2(6);
	
	out_3(0) <= outputsig3(0);
	out_3(1) <= outputsig3(1);
	out_3(2) <= outputsig3(2);
	out_3(3) <= outputsig3(3);
	out_3(4) <= outputsig3(4);
	out_3(5) <= outputsig3(5);
	out_3(6) <= outputsig3(6);
	
END fdss;