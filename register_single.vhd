--This is example.vhd, used for Lab0.
--Read over this code and determine the purpose.
--Further, what hardware does this represent?
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity register_single is

generic(width:integer:=16);

port( d: IN std_logic_vector((width-1) downto 0);
rvalid: IN std_logic;
clk: IN std_logic;
q: OUT std_logic_vector((width-1) downto 0));
end register_single;

--Begin the architecture, why is it called mixed?
architecture behavior of register_single  is

begin

	process(clk)
	begin
		if(rising_edge(clk) and rvalid = '1') then
				q <= d;
		end if;
	end process;
	
end behavior;