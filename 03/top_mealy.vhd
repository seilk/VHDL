
library ieee;
use ieee.std_logic_1164.all;

entity top_mealy is
port(CLK, RESET: in std_logic;
	A_in: in std_logic_vector(1 downto 0);
	LOST: out std_logic
	);
end top_mealy;

architecture behav of top_mealy is
	-- fill me (mealy machine)
			  
end behav;