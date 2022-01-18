library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY hexsevenseg IS
    PORT ( input_sevenseg : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
          output_sevenseg : OUT  STD_LOGIC_VECTOR (6 DOWNTO 0)
             );
END hexsevenseg;

ARCHITECTURE Behavioral OF hexsevenseg IS

BEGIN
PROCESS (input_sevenseg)
BEGIN
    case input_sevenseg is
        when "0000"=> output_sevenseg <="0111111";  -- '0'
        when "0001"=> output_sevenseg <="0000110";  -- '1'
        when "0010"=> output_sevenseg <="1011011";  -- '2'
        when "0011"=> output_sevenseg <="1001111";  -- '3'
        when "0100"=> output_sevenseg <="1100110";  -- '4' 
        when "0101"=> output_sevenseg <="1101101";  -- '5'
        when "0110"=> output_sevenseg <="1111101";  -- '6'
        when "0111"=> output_sevenseg <="0000111";  -- '7'
        when "1000"=> output_sevenseg <="1111111";  -- '8'
        when "1001"=> output_sevenseg <="1101111";  -- '9'
        when "1010"=> output_sevenseg <="1110111";  -- 'A'
        when "1011"=> output_sevenseg <="1111100";  -- 'b'
        when "1100"=> output_sevenseg <="1111001";  -- 'C'
        when "1101"=> output_sevenseg <="1011110";  -- 'd'
        when "1110"=> output_sevenseg <="1111001";  -- 'E'
        when "1111"=> output_sevenseg <="1110001";  -- 'F'
        when others =>  NULL;
    end case;
END PROCESS;

END Behavioral;
