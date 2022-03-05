LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity cpu_board is
port(SW: in std_logic_vector(9 downto 0); 
KEY: in std_logic_vector(3 downto 0);
LEDR: out std_logic_vector(9 downto 0));
--HEX5: out std_logic_vector(6 downto 0);
--HEX4: out std_logic_vector(6 downto 0);
--HEX3: out std_logic_vector(6 downto 0);
--HEX2: out std_logic_vector(6 downto 0);
--HEX1: out std_logic_vector(6 downto 0);
--HEX0: out std_logic_vector(6 downto 0));
end cpu_board;

--Begin the architecture,
architecture board of cpu_board is
-------------------------------------------------
component cpu is
port( 
buss: out std_logic_vector(7 downto 0);
don: out std_logic;
Din: in std_logic_vector(7 downto 0);
rset: in std_logic;
clock: in std_logic;
rn: in std_logic);
end component cpu;
--------------------------------------------------
begin
	
	board_map: component cpu
	port map(Din => SW(7 downto 0),
	rn => SW(8),
	clock => KEY(3),
	rset => SW(9),
	don => LEDR(9),
	buss => LEDR(7 downto 0));
	--sg2 => HEX5);
	--sg1 => HEX4,
	--sg4 => HEX3,
	--sg3 => HEX2,
	--sg6 => HEX1,
	--sg5 => HEX0);
	
end board;