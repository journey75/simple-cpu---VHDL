LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux is

generic(width:integer:=16);

port( 

--R is a 10 bit input made of up R0...R7out -,din,    and G will need to port map accordingly
R: IN std_logic_vector(9 downto 0);

R0: IN std_logic_vector((width-1) downto 0);
R1: IN std_logic_vector((width-1) downto 0);
R2: IN std_logic_vector((width-1) downto 0);
R3: IN std_logic_vector((width-1) downto 0);
R4: IN std_logic_vector((width-1) downto 0);
R5: IN std_logic_vector((width-1) downto 0);
R6: IN std_logic_vector((width-1) downto 0);
R7: IN std_logic_vector((width-1) downto 0);
Din: IN std_logic_vector((width-1) downto 0);
G: IN std_logic_vector((width-1) downto 0);

bus_out: OUT std_logic_vector((width-1) downto 0));

end mux;

--Begin the architecture, why is it called mixed?
architecture mixed of mux is
begin
		
	with R select
		bus_out <= G when "0000000001",
			Din when "0000000010",
			R0 when "0000000100",
			R1 when "0000001000",
			R2 when "0000010000",
			R3 when "0000100000",
			R4 when "0001000000",
			R5 when "0010000000",
			R6 when "0100000000",
			R7 when "1000000000",
			Din when others;
	
end mixed;