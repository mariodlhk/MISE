----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:46 11/16/2014 
-- Design Name: 
-- Module Name:    int_salida - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity int_salida is
    port (
		Clk	: in std_logic;
		Reset	: in std_logic;
		Validacion : out std_logic;
		Dato_out   : out std_logic_vector(15 downto 0);
		Salida  : in std_logic_vector(15 downto 0);
		Fin	: in std_logic);
end int_salida;
	
architecture Behavioral of int_salida is
	TYPE estados IS (idle, escritura, escrito);
	SIGNAL estado_actual, estado_siguiente : estados;
	SIGNAL Dato_out_tmp : std_logic_vector(15 downto 0);
	SIGNAL Validacion_tmp : std_logic;

	PROCESS (estado actual)
	BEGIN
		estado_siguiente <= estado_actual;
		CASE estado_actual IS
			WHEN idle =>
				Dato_out_tmp <= (others => '0');
				Validacion_tmp <= '0';
			WHEN escritura =>
				Dato_out_tmp <= Salida;
				estado_siguiente <= escrito;
				Validacion_tmp <= '0';
			WHEN escrito =>
				-- ESPERA
				Validacion_tmp <= '1';
		END CASE;
	END PROCESS;

	PROCESS (Clk, Reset, Fin)
	BEGIN
		IF (Reset = '0') THEN
			estado_actual <= idle;
		ELSIF (Clk'event) and Clk = '1' THEN
			Dato_out <= Dato_out_tmp;
			Validacion <= Validacion_tmp;
			estado_actual <= estado_siguiente;
		END IF;
		IF (Fin = '1') THEN
			estado_actual <= escritura;
	END PROCESS;
end behavioral
