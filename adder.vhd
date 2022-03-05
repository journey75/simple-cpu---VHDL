LIBRARY ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--use ieee.numeric_std_unsigned.all;
USE ieee.std_logic_1164.all;

entity adder is

generic(width:integer:=16);

port( asub: IN std_logic;
input1: IN std_logic_vector((width-1) downto 0);
input2: IN std_logic_vector((width-1) downto 0);
result: OUT std_logic_vector((width-1) downto 0));
end adder;
--Begin the architecture,
architecture add of adder is

	--signal result_temp : std_logic_vector((width-1) DOWNTO 0);

begin 

	--when the addsub bit is zero, you add, when its 1, you subtract
	--when asub => '0'
	---	result_temp <= (input1 + input2);
		
	--	result <= result_temp;
	--Else
	--	result_temp <= (input1 - input2);
		
	--	result <= result_temp;
	
    result <= (input1 + input2) WHEN (asub= '0') ELSE (input1 - input2);
   
	
	--s <= a XOR b XOR ci;
	--co <= (a AND b) OR (a and ci) OR (b AND ci);
	--co <= b when ((a XOR b) = '0') else 
				 --ci;
	
end add;