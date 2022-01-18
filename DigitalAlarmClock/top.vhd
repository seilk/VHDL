library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity top is
	port(
	-- total 8 input singals
		Reset: in std_logic := '0'; -- reset
		CLK:   in std_logic; -- clk
		Mode:  in std_logic := '0'; -- mode
		Up:    in std_logic := '0'; -- up
		Down:  in std_logic := '0'; -- down
		A:     in std_logic := '0'; -- additional (Alarm off)
		B:     in std_logic := '0'; -- additional (SET_SELECT)
		C:     in std_logic := '0'; -- additional (Time_format) ;change hour format

		-- output sevenseg
		out_0: out std_logic_vector(6 downto 0); -- 0th digit (D)
		out_1: out std_logic_vector(6 downto 0); -- 1th digit (C)
		out_2: out std_logic_vector(6 downto 0); -- 2nd digit (B)
		out_3: out std_logic_vector(6 downto 0) -- 3rd digit (A)
	);
end top;

architecture Behavioral of top is
	
		SIGNAL h1 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		SIGNAL h0 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		SIGNAL m1 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		SIGNAL m0 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		SIGNAL s1 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		SIGNAL s0 : STD_LOGIC_VECTOR(3 downto 0):= "0000";
		
		--display
		SIGNAL r_m0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL r_m1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL r_h0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL r_h1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		
		--alarm
		SIGNAL a_h0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL a_h1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL a_m0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL a_m1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL alarmOn : STD_LOGIC := '0';
		SIGNAL alarmOut : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
		
		---change time
		SIGNAL t_h0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL t_h1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL t_m0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		SIGNAL t_m1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		
		SIGNAL Q : STD_LOGIC_VECTOR(3 downto 0) := "0001";
		SIGNAL SET_SELECT : STD_LOGIC_VECTOR(1 downto 0) := "01";
		SIGNAL SET : STD_LOGIC := '0';		--set alarm and time based on mode and activate up/down.
		SIGNAL T_Format : STD_LOGIC := '0'; --default clock time format 12h
begin

	
	PROCESS_MODE : PROCESS(Mode, Q, Reset) --change Mode
		begin
			if (Reset = '1') then
				Q <= "0001";
			elsif(rising_edge(MODE))then
					Q(1) <= Q(0);
					Q(2) <= Q(1);
					Q(3) <= Q(2);
					Q(0) <= Q(3);
			end if;
			if(Q = "0100" or Q = "1000")then
				SET <= '1';
			else
				SET <= '0';
			end if;
		end PROCESS PROCESS_MODE;
					
	PROCESS_FORMAT : PROCESS(T_Format, Reset) --change Format on Mode1
		begin
			if (Reset = '1') then
				T_Format <= '0';
			elsif (Q = "0010") then
				T_Format <= C;
			end if;
		end PROCESS PROCESS_FORMAT;

	PROCESS_CLK : PROCESS(CLK, Reset, T_Format) --Master Time Flow Logic
		begin
			if(rising_edge(CLK))then
				if (Reset = '1')then
					h1 <= "0000";
					h0 <= "0000";
					m1 <= "0000";
					m0 <= "0000";
					s1 <= "0000";
					s0 <= "0000";
				elsif(Q = "1000") then -- when MODE_3(change current time)
					m0 <= t_m0 ;
					m1 <= t_m1 ;
					h0 <= t_h0 ;
					h1 <= t_h1 ;
				end if; 
				if (s0 < "1010") then
					s0 <= s0 + "0001";
					if(s0 = "1001") then
						s0<="0000";
						s1 <= s1 + "0001";
						if(s1 = "0101") then
							m0 <= m0 + "0001";
							s1 <= "0000";
							if(m0 = "1001") then
								m0 <= "0000";
								m1 <= m1 + "0001";
								if(m1 =  "0101") then
									m1 <= "0000";
									h0 <= h0 + "0001" ;
									if(h0 = "1001" ) then
										h0 <= "0000";
										h1 <= h1 + "0001";
									elsif(h1 = "0010" and h0 = "0011" and T_Format = '1') then --23:59
										h1 <= "0000";
										h0 <= "0000";
									elsif(h1 = "0001" and h0 = "0001" and T_Format = '0') then --11:59
										h1 <= "0000";
										h0 <= "0000";
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
				if(Q = "0001")then --MODE_0(Q = 0001) : disp current time
						if(T_Format = '0')then -- when 12h format (default)
							if(h1 = "0001" and h0 > "0001")then	-- 13->1, 14->2, 15->3, ...
								h1 <= "0000";
								h0 <= h0 - "0010";
							elsif(h1 = "0001" and h0 = "1001")then -- 20 -> 8
								h1 <= "0000";
								h0 <= "1000";
							elsif(h1 = "0010" and h0 = "0000")then -- 21 -> 9
								h1 <= "0000";
								h0 <= "1001";
							elsif(h1 = "0010" and h0 = "0001")then -- 22 -> 10
								h1 <= "0001";
								h0 <= "0000";
							elsif(h1 = "0010" and h0 = "0010")then -- 23 -> 11
								h1 <= "0001";
								h0 <= "0001";
							end if;
						end if;
					end if;
				end if;
		end PROCESS PROCESS_CLK;

	PROCESS_SELECT : PROCESS(B, Reset) is --set changing target (hour or minute)
		begin
			if (SET = '1') then
				if(rising_edge(B))then
					if(Reset ='1')then
						SET_SELECT <= "01";
					else
						SET_SELECT(1) <= SET_SELECT(0);
						SET_SELECT(0) <= SET_SELECT(1);
					end if;
				end if;
			end if;
		end PROCESS PROCESS_SELECT;

	PROCESS_CHANGETIME : PROCESS(UP, DOWN)is --Mode3 : Chage Current Time
		begin
			if (Q = "1000") then -- Only When Mode3
				if(SET_SELECT = "01")then -- changing target is min
					if(UP = '1')then --UP
						if (t_m0 = "1001") then
							if (t_m1 = "0101") then
								t_m0 <= "0000";
								t_m1 <= "0000";
							else
								t_m0 <= "0000";
								t_m1 <= t_m1 + "0001";
							end if;
						else
							t_m0 <= t_m0 + "0001";
						end if;

					elsif(DOWN = '1')then --DOWN
						if (t_m0 = "0000") then
							if (t_m1 = "0000") then
								t_m1 <= "0101";
								t_m0 <= "1001";
							else
								t_m1 <= t_m1 - "0001";
								t_m0 <= "1001";
							end if;
						else
							t_m0 <= t_m0 - "0001";
						end if;
					end if;

				elsif((SET_SELECT = "10") and (T_Format = '0'))then -- changing target is hr(12hr)
					if(UP = '1')then --UP
						if (t_h0 = "0010") then
							if (t_h1 = "0001") then
								t_h0 <= "0000";
								t_h1 <= "0000";
							else
								t_h1 <= t_h1 + "0001";
							end if;
						else
							t_h0 <= t_h0 + "0001";
						end if;

					elsif(DOWN = '1')then --DOWN
						if (t_h0 = "0000") then
							if (t_h1 = "0000") then
								t_h0 <= "0010";
								t_h1 <= "0001";
							else
								t_h1 <= t_h1 - "0001";
							end if;
						else
							t_h0 <= t_h0 - "0001";
						end if;
					end if;

				elsif((SET_SELECT = "10") and (T_Format = '1'))then -- changing target is hr(24hr)	
					if(UP = '1')then --UP
						if (t_h1 = "0010") then
							if (t_h0 = "0101") then
								t_h1 <= "0000";
								t_h0 <= "0000";
							else 
								t_h0 <= t_h0 + "0001";
							end if;
						elsif (t_h1 = "0001") then
							if (t_h0 = "1001") then
								t_h1 <= "0010";
								t_h0 <= "0000";
							else
								t_h0 <= t_h0 + "0001";
							end if;
						end if;
					elsif(DOWN = '1')then --DOWN
						if (t_h1 = "0000") then
							if (t_h0 = "0000") then
								t_h1 <= "0010";
								t_h0 <= "0101";
							else 
								t_h0 <= t_h0 - "0001";
							end if;

						elsif (t_h1 = "0001") then
							if (t_h0 = "0000") then
								t_h1 <= "0000";
								t_h0 <= "1001";
							else
								t_h0 <= t_h0 - "0001";
							end if;

						elsif (t_h1 = "0010") then
							if (t_h0 = "0000") then
								t_h1 <= "0001";
								t_h0 <= "1001";
							else
								t_h0 <= t_h0 - "0001";
							end if;
						end if;
					end if;
				end if;
			end if;
		end PROCESS PROCESS_CHANGETIME;

	PROCESS_ALARMONOFF : PROCESS(alarmOn, Reset, A) is --Alarm of Process
		begin
			if (Reset = '1') then
				alarmOn <= '1';
			elsif (rising_edge(A)) then
				if (alarmOn = '0') then
					alarmOn <= '1';
				else 
					alarmOn <= '0';
				end if;
			end if;
		end PROCESS PROCESS_ALARMONOFF;
	
	PROCESS_ALARMCOMPARE : PROCESS(clk, Reset, m0, m1, h0, h1, alarmOn, Q, a_h1, a_h0, a_m1, a_m0) --Time Compare Process
		begin
			if (rising_edge(clk)) then
				if (h1 = a_h1) then
					if (h0 = a_h0) then
						if (m1 = a_m1) then
							if (m0 = a_m0) then
								if (Q /= "0100" and alarmOn = '1') then
									alarmOut <= "1111111";
								else
									alarmOut <= "0000000";
								end if;
							else
								alarmOut <= "0000000";
							end if;
						else
							alarmOut <= "0000000";
						end if;
					else
						alarmOut <= "0000000";
					end if;
				else
					alarmOut <= "0000000";
				end if;
			end if;
		end PROCESS PROCESS_ALARMCOMPARE;

	PROCESS_ALARMSETTING : PROCESS(Reset, UP, DOWN, SET_SELECT, T_Format) --Alarm Setting Process
		begin
			if (Reset = '1') then
				a_h0 <= "0001";
				a_h1 <= "0001";
				a_m0 <= "0001";
				a_m1 <= "0001";
			elsif (Q = "0010") then
				if(SET_SELECT = "01")then --min set
					if(UP = '1')then --UP
						if (a_m0 = "1001") then
							if (a_m1 = "0101") then
								a_m0 <= "0000";
								a_m1 <= "0000";
							else
								a_m0 <= "0000";
								a_m1 <= a_m1 + "0001";
							end if;
						else
							a_m0 <= a_m0 + "0001";
						end if;

					elsif(DOWN = '1')then --DOWN
						if (a_m0 = "0000") then
							if (a_m1 = "0000") then
								a_m1 <= "0101";
								a_m0 <= "1001";
							else
								a_m1 <= a_m1 - "0001";
								a_m0 <= "1001";
							end if;
						else
							a_m0 <= a_m0 - "0001";
						end if;
					end if;

				elsif((SET_SELECT = "10") and (T_Format = '0'))then --12hr
					if(UP = '1')then --UP
						if (a_h0 = "0010") then
							if (a_h1 = "0001") then
								a_h0 <= "0000";
								a_h1 <= "0000";
							else
								a_h1 <= a_h1 + "0001";
							end if;
						else
							a_h0 <= a_h0 + "0001";
						end if;

					elsif(DOWN = '1')then --DOWN
						if (a_h0 = "0000") then
							if (a_h1 = "0000") then
								a_h0 <= "0010";
								a_h1 <= "0001";
							else
								a_h1 <= a_h1 - "0001";
							end if;
						else
							a_h0 <= a_h0 - "0001";
						end if;
					end if;

				elsif((SET_SELECT = "10") and (T_Format = '1'))then --24hr	
					if(UP = '1')then --UP
						if (a_h1 = "0010") then
							if (a_h0 = "0101") then
								a_h1 <= "0000";
								a_h0 <= "0000";
							else 
								a_h0 <= a_h0 + "0001";
							end if;
						elsif (a_h1 = "0001") then
							if (a_h0 = "1001") then
								a_h1 <= "0010";
								a_h0 <= "0000";
							else
								a_h0 <= a_h0 + "0001";
							end if;
						end if;
					elsif(DOWN = '1')then --DOWN
						if (a_h1 = "0000") then
							if (a_h0 = "0000") then
								a_h1 <= "0010";
								a_h0 <= "0101";
							else 
								a_h0 <= a_h0 - "0001";
							end if;

						elsif (a_h1 = "0001") then
							if (a_h0 = "0000") then
								a_h1 <= "0000";
								a_h0 <= "1001";
							else
								a_h0 <= a_h0 - "0001";
							end if;

						elsif (a_h1 = "0010") then
							if (a_h0 = "0000") then
								a_h1 <= "0001";
								a_h0 <= "1001";
							else
								a_h0 <= a_h0 - "0001";
							end if;
						end if;
					end if;
				end if;
			end if;
		end PROCESS PROCESS_ALARMSETTING;
		
-----------------------------------------------	
-----------------display 7 SEG-----------------
-----------------------------------------------	
	PROCESS_out0 : PROCESS(r_m0, CLK) is
		begin
			if (rising_edge(clk)) then
				r_m0 <= m0;
				if (Q = "0100") then
					r_m0 <= a_m0;
				elsif(alarmOut = "1111111") then
					OUT_0 <= transport alarmOut after 60sec;
				end if;
				case r_m0 is
					when "0000"=> OUT_0 <="0111111";  -- '0'    
					when "0001"=> OUT_0 <="0000110";  -- '1' 
					when "0010"=> OUT_0 <="1011011";  -- '2'
					when "0011"=> OUT_0 <="1001111";  -- '3' 
					when "0100"=> OUT_0 <="1100110";  -- '4' 
					when "0101"=> OUT_0 <="1101101";  -- '5'     
					when "0110"=> OUT_0 <="1111101";  -- '6'
					when "0111"=> OUT_0 <="0000111";  -- '7'
					when "1000"=> OUT_0 <="1111111";  -- '8'
					when "1001"=> OUT_0 <="1101111";  -- '9'
					when "1010"=> OUT_0 <="1110111";  -- 'A'
					when "1011"=> OUT_0 <="1111100";  -- 'b'
					when "1100"=> OUT_0 <="1111001";  -- 'C'
					when "1101"=> OUT_0 <="1011110";  -- 'd'
					when "1110"=> OUT_0 <="1111001";  -- 'E'
					when "1111"=> OUT_0 <="1110001";  -- 'F'
					when others => NULL;
				end case;
			end if;
		end PROCESS PROCESS_out0;

	PROCESS_out1 : PROCESS(r_m1, CLK) is
		begin
			if (rising_edge(clk)) then
				r_m1 <= m1;
				if (Q = "0100") then
					r_m1 <= a_m1;
				elsif(alarmOut = "1111111") then
					OUT_1 <= transport alarmOut after 60sec;
				end if;
				case r_m1 is
					when "0000"=> OUT_1 <="0111111";  -- '0'    
					when "0001"=> OUT_1 <="0000110";  -- '1' 
					when "0010"=> OUT_1 <="1011011";  -- '2'
					when "0011"=> OUT_1 <="1001111";  -- '3' 
					when "0100"=> OUT_1 <="1100110";  -- '4' 
					when "0101"=> OUT_1 <="1101101";  -- '5'     
					when "0110"=> OUT_1 <="1111101";  -- '6'
					when "0111"=> OUT_1 <="0000111";  -- '7'
					when "1000"=> OUT_1 <="1111111";  -- '8'
					when "1001"=> OUT_1 <="1101111";  -- '9'
					when "1010"=> OUT_1 <="1110111";  -- 'A'
					when "1011"=> OUT_1 <="1111100";  -- 'b'
					when "1100"=> OUT_1 <="1111001";  -- 'C'
					when "1101"=> OUT_1 <="1011110";  -- 'd'
					when "1110"=> OUT_1 <="1111001";  -- 'E'
					when "1111"=> OUT_1 <="1110001";  -- 'F'
					when others => NULL;
				end case;
			end if;
		end PROCESS PROCESS_out1;

	PROCESS_out2 : PROCESS(r_h0, CLK)is
		begin
			if (rising_edge(clk)) then
				r_h0 <= h0;
				if (Q = "0100") then
					r_h0 <= a_h0;
				elsif(alarmOut = "1111111") then
					OUT_2 <= transport alarmOut after 60sec;
				end if;
				case r_h0 is
					when "0000"=> OUT_2 <="0111111";  -- '0'    
					when "0001"=> OUT_2 <="0000110";  -- '1' 
					when "0010"=> OUT_2 <="1011011";  -- '2'
					when "0011"=> OUT_2 <="1001111";  -- '3' 
					when "0100"=> OUT_2 <="1100110";  -- '4' 
					when "0101"=> OUT_2 <="1101101";  -- '5'     
					when "0110"=> OUT_2 <="1111101";  -- '6'
					when "0111"=> OUT_2 <="0000111";  -- '7'
					when "1000"=> OUT_2 <="1111111";  -- '8'
					when "1001"=> OUT_2 <="1101111";  -- '9'
					when "1010"=> OUT_2 <="1110111";  -- 'A'
					when "1011"=> OUT_2 <="1111100";  -- 'b'
					when "1100"=> OUT_2 <="1111001";  -- 'C'
					when "1101"=> OUT_2 <="1011110";  -- 'd'
					when "1110"=> OUT_2 <="1111001";  -- 'E'
					when "1111"=> OUT_2 <="1110001";  -- 'F'
					when others => NULL;
				end case;
			end if;
		end PROCESS PROCESS_out2;

	PROCESS_out3 : PROCESS(r_h1, CLK)is
		begin
			if (rising_edge(clk)) then
				r_h1 <= h1;
				if (Q = "0100") then
					r_h1 <= a_h1;
				elsif(alarmOut = "1111111") then
					OUT_3 <= transport alarmOut after 60sec;
				end if;
				case r_h1 is
					when "0000"=> OUT_3 <="0111111";  -- '0'    
					when "0001"=> OUT_3 <="0000110";  -- '1' 
					when "0010"=> OUT_3 <="1011011";  -- '2'
					when "0011"=> OUT_3 <="1001111";  -- '3' 
					when "0100"=> OUT_3 <="1100110";  -- '4' 
					when "0101"=> OUT_3 <="1101101";  -- '5'     
					when "0110"=> OUT_3 <="1111101";  -- '6'
					when "0111"=> OUT_3 <="0000111";  -- '7'
					when "1000"=> OUT_3 <="1111111";  -- '8'
					when "1001"=> OUT_3 <="1101111";  -- '9'
					when "1010"=> OUT_3 <="1110111";  -- 'A'
					when "1011"=> OUT_3 <="1111100";  -- 'b'
					when "1100"=> OUT_3 <="1111001";  -- 'C'
					when "1101"=> OUT_3 <="1011110";  -- 'd'
					when "1110"=> OUT_3 <="1111001";  -- 'E'
					when "1111"=> OUT_3 <="1110001";  -- 'F'
					when others => NULL;
				end case;
			end if;
		end PROCESS PROCESS_out3;
END Behavioral;