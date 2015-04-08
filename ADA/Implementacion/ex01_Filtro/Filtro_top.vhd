---------------------------------------------------------
-- Filtro_top
---------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;
   
entity Filtro_top is

  port (
    -- Señales control
    Reset		: in  std_logic;   -- Reset asincrono por nivel bajo
    Clk			: in  std_logic;   -- Reloj del sistema
	-- Señales interfaz de entrada
    Dato_in		: in  std_logic_vector(15 downto 0);  -- Dato recibido
    Valid_in		: in  std_logic;   -- Validacion del dato de entrada
    Ack_in		: out std_logic;   -- ACK del dato de entrada
	-- Señales interfaz de salida
    Dato_out	: out std_logic_vector(15 downto 0);  -- Dato de salida
    Valid_out   : out  std_logic;   -- Validacion del dato de entrada
    Ack_out		: in std_logic;		-- Ack del dato de salida

end Filtro_top;

architecture RTL of Filtro_top is
	----------------------------
	-- Componentes del sistema 
	----------------------------
	
	component int_entrada
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Validacion : in std_logic;
			Dato_in	: in std_logic_vector(15 downto 0);
			Entrada: out std_logic_vector(15 downto 0));
	end component;
	
	component int_salida
		port (
			Clk	: in std_logic;
			Reset	: in std_logic;
			Validacion	: out std_logic;
			Dato_out	: out std_logic_vector(15 downto 0);
			Salida 	: in std_logic_vector(15 downto 0);
			Fin	: in std_logic);
	end component;
	
	component datapath
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Entrada	: in std_logic_vector(15 downto 0);
			Salida	: out std_logic_vector(15 downto 0);
			flags	: out  std_logic_vector(2 downto 0);
			mandos	: in std_logic_vector(2 downto 0));
	end component;
	
	component control
		port (
			Clk	: in std_logic;
			Reset	: in std_logic;
			Fin	: out std_logic;
			flags	: in  std_logic_vector(2 downto 0);
			mandos	: out std_logic_vector(2 downto 0));
	end component;
	
	---------------------------
	-- SeÃ±ales internas
	---------------------------
	signal RD	: std_logic_vector (15 downto 0);
	signal inicio : std_logic;
	signal fin : std_logic;
	signal entradas	: std_logic_vector (15 downto 0);
	signal salidas	: std_logic_vector (15 downto 0);
	signal flags	: std_logic_vector (2 downto 0);
	signal mandos	: std_logic_vector (2 downto 0);
	
	begin -- RTL
	
		Entrada: int_entrada
			port map (
				Clk   => Clk,
				Reset => Reset,
				Validacion => Valid_in,
				Dato_in	=> Dato_in,
				Entrada => entradas);
				
		Salida: int_salida
			port map (
				Clk   => Clk,
				Reset => Reset,
				Validacion => Valid_out,
				Dato_out => Dato_out,
				Salida => salidas,
				Fin => fin);
				
		Datapath: datapath
			port map (
				Clk   => Clk,
				Reset => Reset,
				Entrada => entradas,
				Salida => salidas,
				flags => flags,
				mandos => mandos);
				
		Control: control
			port map (
				Clk   => Clk,
				Reset => Reset,
				Fin	=> fin,
				flags	=> flags,
				mandos 	=> mandos);
end RTL;
	
	
