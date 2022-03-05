--final file
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity cpu is

generic(width:integer:=8);

port( 
buss: out std_logic_vector((width-1)downto 0);
don: out std_logic;
Din: in std_logic_vector((width-1)downto 0);
rset: in std_logic;
clock: in std_logic;
rn: in std_logic);
end cpu;

--Begin the architecture,
architecture main of cpu is

--put the carry signals here
signal Dconv: std_logic_Vector(7 downto 0);
--
signal carry1: std_logic_vector((width-1)downto 0);
signal carryGin: std_logic;
signal carry3: std_logic_vector((width-1)downto 0);
signal carryAin: std_logic;

--input signals for mux
signal carryreg0: std_logic_vector((width-1) downto 0);
signal carryreg1: std_logic_vector((width-1) downto 0);
signal carryreg2: std_logic_vector((width-1) downto 0);
signal carryreg3: std_logic_vector((width-1) downto 0);
signal carryreg4: std_logic_vector((width-1) downto 0);
signal carryreg5: std_logic_vector((width-1) downto 0);
signal carryreg6: std_logic_vector((width-1) downto 0);
signal carryreg7: std_logic_vector((width-1) downto 0);
------------
signal carryq: std_logic_vector((width-1) downto 0);
--
--for adder
signal carryadd: std_logic_vector((width-1) downto 0);
--
signal carryg: std_logic_vector((width-1) downto 0);

signal carryir: std_logic_vector((width-1) downto 0);

signal busss: std_logic_vector((width-1)downto 0);

signal carry5: std_logic;
signal carryaddsub: std_logic;

signal carryRout: std_logic_vector(9 downto 0);
signal carry14: std_logic_vector(7 downto 0);


-------------------------------------------------
component register_single is
	generic(width:integer);
	port( d: IN std_logic_vector((width-1) downto 0);
	rvalid: IN std_logic;
	clk: IN std_logic;
	q: OUT std_logic_vector((width-1) downto 0));
end component register_single;

component adder
	generic(width:integer);
	port( asub: IN std_logic;
	input1: IN std_logic_vector((width-1) downto 0);
	input2: IN std_logic_vector((width-1) downto 0);
	result: OUT std_logic_vector((width-1) downto 0));
end component adder;

component mux is
	generic(width:integer);
	port( 
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
end component mux;

component control is
	port(
		rst: IN std_logic;
		clk: IN std_logic;
		run: IN std_logic;
		D: IN std_logic_vector(7 downto 0);
		
		DINout: OUT std_logic;
		done: OUT std_logic;
		Rout: OUT std_logic_vector(7 downto 0);
		Rin: OUT std_logic_vector(7 downto 0);
		Ain: OUT std_logic;
		Gin: OUT std_logic;	
		Gout: OUT std_logic;
		IRin: OUT std_logic;
		addsub: OUT std_logic);
end component control;



--------------------------------------------------
begin

	cu: component control
	port map(rst => rset,
	run => rn,
	D=> Dconv,
	Rout => carryRout(9 downto 2),
	Rin => carry14,
	Gout => carryRout(0),
	Gin => carryGin,
	DINout => carryRout(1),
	Ain => carryAin,
	IRin => carry5,
	addsub => carryaddsub,
	done => don,
	clk => clock);
	
	mx: component mux
	generic map (width => width)
	port map(R => carryRout,
	G => carryg,
	Din => Din,
	R0 => carryreg0,
	R1 => carryreg1,
	R2 => carryreg2,
	R3 => carryreg3,
	R4 => carryreg4,
	R5 => carryreg5,
	R6 => carryreg6,
	R7 => carryreg7,
	bus_out => busss);
	
	Areg: component register_single 
	generic map (width => width)
	port map( d => busss,
	rvalid => carryAin,
	clk => clock,
	q => carryq);

	
	addd: component adder--one will be carryq(from A),and the other will be the bus
	generic map (width => width)
	port map(input2 => busss,
	input1 => carryq,
	asub => carryaddsub,
	result => carryadd);
	
	Greg: component register_single
	generic map (width => width)
	port map( d => carryadd,
	rvalid => carryGin,
	clk => clock,
	q => carryg);
	
	IRreg: component register_single
	generic map (width => 8)
	port map( d(7 downto 0) => Din(7 downto 0),
	rvalid => carry5,
	clk => clock,
	q(7 downto 0) => Dconv);
	
	r7: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(7),
	clk => clock,
	q => carryreg7);
	
	r6: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(6),
	clk => clock,
	q => carryreg6);
	
	r5: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(5),
	clk => clock,
	q => carryreg5);
	
	r4: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(4),
	clk => clock,
	q => carryreg4);
	
	r3: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(3),
	clk => clock,
	q => carryreg3);
	
	r2: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(2),
	clk => clock,
	q => carryreg2);
	
	r1: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(1),
	clk => clock,
	q => carryreg1);
	
	r0: component register_single
	generic map (width => width)
	port map(d => busss,
	rvalid => carry14(0),
	clk => clock,
	q => carryreg0);
	
	buss <= busss;

	
end main;