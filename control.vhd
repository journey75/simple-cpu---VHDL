--control unit
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity control is

port(

rst: IN std_logic;
clk: IN std_logic;
run: IN std_logic;
 
D: IN std_logic_vector(7 downto 0);

DINout: OUT std_logic;

-----------------------------------------------
done: OUT std_logic;

Rout: OUT std_logic_vector(7 downto 0);
Rin: OUT std_logic_vector(7 downto 0);

Ain: OUT std_logic;

Gin: OUT std_logic;
Gout: OUT std_logic;

IRin: OUT std_logic;

addsub: OUT std_logic);

--RYout : OUT std_logic;
--RYin: OUT std_logic;
--RXout: OUT std_logic;
--RXin: OUT std_logic);

end control;

--Begin the architecture,
architecture controller of control is

	TYPE state is (T0,T1,T2,T3); 
	signal current_state : state;
	
	signal rx: std_logic_vector(7 downto 0);
	signal ry: std_logic_vector(7 downto 0);


	
	--signal A : std_logic_vector(2 downto 0);
	--signal G : std_logic_vector(2 downto 0);
	--signal RX : std_logic_vector(2 downto 0);
	--signal RY : std_logic_vector(2 downto 0);
	--signal IR: std_logic_vector((width-1) downto 0);
	
	--RX <= D(5 downto 3);
	--RY <= D(2 downto 0);
	
begin

	--process to latch IR 
	--process(clk)
	--begin
		--if(rising_edge(clk)) then
			--	IR <= D;
		--end if;
	--end process;
		
		--ONLY transition logic
	process(clk,rst) begin
		if(rst = '0') then
			current_state <= T0;
		elsif(rising_edge(clk)) then
			case current_state is
				when T0 =>
				
					--IR <= '1'; --IR is "asserted", so every input will advance us
					
					if (run = '1') then current_state <= T1;
					
					else current_state <= T0; 
					
					end if;
					
				when T1 =>
				
					if (D(7 downto 6) = "00") then current_state <= T0;
					--MV
					elsif (D(7 downto 6) = "01") then current_state <= T0;
					--MVI
					elsif (D(7 downto 6) = "10") then current_state <= T2;
					--ADD
					elsif (D(7 downto 6) = "11") then current_state <= T2;
					--SUB
					else current_state <= T0; 
					
					end if;
					
				when T2 =>
				
					--MV is done
					--MVI is done
					--ADD
					--SUB
					
					if (D(7 downto 6) = "10") then current_state <= T3;
					--ADD
					elsif (D(7 downto 6) = "11") then current_state <= T3;
					--SUB
					else current_state <= T0; 
					
					end if;
	
				when T3 =>
				
					--MV is done
					--MVI is done
					--ADD
					--SUB
					
					if (D(7 downto 6) = "10") then current_state <= T0;
					--ADD
					elsif (D(7 downto 6) = "11") then current_state <= T0;
					--SUB
					else current_state <= T0; 
					
					end if;
				
				--default case for something unexpected
				when others => 
					current_state <= T0;
					
			end case;
		end if;
	end process;


	--signal rx std_logic_vextor 8 bit
	
	with D(5 downto 3) select
								rx <= "00000001" when "000",
								"00000010" when "001",
								"00000100" when "010",
								"00001000" when "011",
								"00010000" when "100",
								"00100000" when "101",
								"01000000" when "110",
								"10000000" when "111",
								"00000000" when others;
								
	with D(2 downto 0) select
								ry <= "00000001" when "000",
								"00000010" when "001",
								"00000100" when "010",
								"00001000" when "011",
								"00010000" when "100",
								"00100000" when "101",
								"01000000" when "110",
								"10000000" when "111",
								"00000000" when others;

	--set outputs
	process(current_state,D,rx,ry) begin
		case current_state is
				when T0 => 
								IRin <= '1'; -- this is the only thing we are worred about in this step
								---------
								Rout <= "00000000";
								Rin <= "00000000";
								done <= '0';
								DINout <= '0';
								Ain <= '0';
								Gin <= '0';
								Gout <= '0';
								addsub <= '0';
								
				when T1 => 
							if(D(7 downto 6) = "00") then --this is the code for mv
								IRin <= '0';
								Rout <= ry;
								Rin <= rx;
								done <= '1';
								DINout <= '0';
								Ain <= '0';
								Gin <= '0';
								Gout <= '0';
								IRin <= '0';
								addsub <= '0';
								
						elsif(D(7 downto 6) = "01") then --mvi
								IRin <= '0';
								Rout <= "00000000";
								Rin <= rx;
								done <= '1';
								DINout <= '1';
								Ain <= '0';
								Gin <= '0';
								Gout <= '0';
								IRin <= '0';
								addsub <= '0';
								
						elsif(D(7 downto 6) = "10") then --add
								IRin <= '0';
								Rout <= rx;
								Rin <= "00000000";
								done <= '0';
								DINout <= '0';
								Ain <= '1';
								Gin <= '0';
								Gout <= '0';
								IRin <= '0';
								addsub <= '0';
								
						elsif(D(7 downto 6) = "11") then --sub
								IRin <= '0';
								Rout <= rx;
								Rin <= "00000000";
								done <= '0';
								DINout <= '0';
								Ain <= '1';
								Gin <= '0';
								Gout <= '0';
								IRin <= '0';
								addsub <= '0';
						end if;
				
				when T2 =>
				
						if(D(7 downto 6) = "10") then --this is the code for mv
								
								Rout <= ry;
								Rin <= "00000000";
								done <= '0';
								DINout <= '0';
								Ain <= '0';
								Gin <= '1';
								Gout <= '0';
								IRin <= '0';
								addsub <= '0';
								
						elsif(D(7 downto 6) = "11") then --mvi
								
								Rout <= ry;
								Rin <= "00000000";
								done <= '0';
								DINout <= '0';
								Ain <= '0';
								Gin <= '1';
								Gout <= '0';
								IRin <= '0';
								addsub <= '1';
						end if;
				
				when T3 =>
				
						if(D(7 downto 6) = "10") then --this is the code for mv
								
								Rout <= "00000000";
								Rin <= rx;
								done <= '1';
								DINout <= '0';
								Ain <= '0';
								Gin <= '0';
								Gout <= '1';
								IRin <= '0';
								addsub <= '0';
								
						elsif(D(7 downto 6) = "11") then --mvi
								
								Rout <= "00000000";
								Rin <= rx;
								done <= '1';
								DINout <= '0';
								Ain <= '0';
								Gin <= '0';
								Gout <= '1';
								IRin <= '0';
								addsub <= '0';
						end if;
				
				
		end case;
	end process;
	
	--unl <= '1' when (current_state = ulock or current_state  = rstcheck) else '0';				
					
	
end controller;