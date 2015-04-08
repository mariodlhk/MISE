----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:46 11/16/2014 
-- Design Name: 
-- Module Name:    int_entrada - Behavioral 
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

entity int_entrada is
    port (
		Clk	: in std_logic;
		Reset	: in std_logic;
		Validacion : in std_logic;
		Dato_in	: in std_logic_vector(15 downto 0);
		Entrada: out std_logic_vector(15 downto 0);
end int_entrada;
	
architecture Behavioral of int_entrada is
	TYPE estados IS (idle, lectura, leido);
	SIGNAL estado_actual, estado_siguiente : estados;
	SIGNAL Entrada_tmp : std_logic_vector(15 downto 0);

	PROCESS (estado actual)
	BEGIN
		estado_siguiente <= estado_actual;
		CASE estado_actual IS
			WHEN idle =>
				Entrada_tmp <= (others => '0');
			WHEN lectura =>
				Entrada_tmp <= Dato_in;
				estado_siguiente <= leido;
			WHEN leido =>
				-- ESPERA
				;
		END CASE;
	END PROCESS;

	PROCESS (Clk, Reset, Validacion)
	BEGIN
		IF (Reset = '0') THEN
			estado_actual <= idle;
		ELSIF (Clk'event) and Clk = '1' THEN
			Entrada <= Entrada_tmp(15 downto 0);
			estado_actual <= estado_siguiente;
		END IF;
		IF (Validacion = '1') THEN
			estado_actual <= lectura;
	END PROCESS;
	
end behavioral
