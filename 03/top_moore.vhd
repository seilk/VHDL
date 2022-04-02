
library ieee;
use ieee.std_logic_1164.all;

entity top_moore is
port(CLK, RESET: in std_logic;
	A_in: in std_logic_vector(1 downto 0);
	LOST: out std_logic
	);
end top_moore;

architecture behav of top_moore is
	-- fill me (moore machine)
			  
end behav;