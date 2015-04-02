---------------------------------------------------------
-- Filtrotop
---------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;
   
entity Filtrotop is

  port (
    -- Señales control
	Reset		: in  std_logic;   -- Reset asincrono por nivel bajo
    Clk			: in  std_logic;   -- Reloj del sistema
	-- Señales interfaz de entrada
    Dato_in		: in  std_logic_vector(15 downto 0);  -- Dato recibido
    Valid_in	: in  std_logic;   -- Validacion del dato de entrada
    Ack_in		: out std_logic;   -- ACK del dato de entrada
	-- Señales interfaz de salida
    Dato_out	: out std_logic_vector(15 downto 0);  -- Dato de salida
    Valid_out   : out  std_logic;   -- Validacion del dato de entrada
    Ack_out		: in std_logic;		-- Ack del dato de salida

end Filtrotop;

architecture RTL of Filtrotop is
	----------------------------
	-- Componentes del sistema 
	----------------------------
	
	component int_entrada
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Validacion : in std_logic;
			Dato_in	: in std_logic_vector(15 downto 0);
			Entradas: out std_logic_vector(15 downto 0));
	end component;
	
	component int_salida
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Validacion : out std_logic;
			TD : out std_logic_vector(15 downto 0);
			Salidas : in std_logic_vector(15 downto 0);
			Fin		: in std_logic);
	end component;
	
	component datapath
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Entradas: in std_logic_vector(15 downto 0);
			Salidas: out std_logic_vector(15 downto 0);
			flags	: in  std_logic_vector(2 downto 0);
			mandos	: out std_logic_vector(2 downto 0));
	end component;
	
	component control
		port (
			Clk		: in std_logic;
			Reset	: in std_logic;
			Validacion : in std_logic;
			Fin		: out std_logic;
			flags	: in  std_logic_vector(2 downto 0);
			mandos	: out std_logic_vector(2 downto 0));
	end component;
	
	---------------------------
	-- Señales internas
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
				Validacion => inicio,
				Dato_in	=> RD,
				Entradas => entradas);
				
		Salida: int_salida
			port map (
				Clk   => Clk,
				Reset => Reset,
				Validacion => fin,
				TD => Dato_out,
				Salidas => salidas,
				Fin => fin);
				
		Datapath: datapath
			port map (
				Clk   => Clk,
				Reset => Reset,
				Entradas => entradas,
				Salidas => salidas,
				flags => flags,
				mandos => mandos);
				
		Control: control
			port map (
				Clk   => Clk,
				Reset => Reset,
				Validacion => inicio,
				Fin		=> fin,
				flags	=> flags,
				mandos 	=> mandos);
				
		Clocking : process (Clk, Reset)
		begin
			if Reset = '0' then
				entradas <= (others => '0');
				salidas <= (others => '0');
				fin <= '1';
			elsif Clk'event and Clk = '1' then
				RD <= Dato_in;
				Validacion <= inicio;
				
end RTL;
	
	
