----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:46 11/16/2014 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

entity datapath is
    port (
		Clk	: in std_logic;
		Reset	: in std_logic;
		Entrada: in std_logic_vector(15 downto 0);
		Salida : out std_logic_vector(15 downto 0);
		flags	: out  std_logic_vector(2 downto 0);
		mandos	: in std_logic_vector(2 downto 0));
end datapath;
	
architecture Behavioral of datapath is
	TYPE estados IS (idle, 
	estado_0, estado_1, estado_2);
	CONSTANT FIN : integer := 1;
	CONSTANT inverso_a1 : tipo := x;
	CONSTANT neg_a2 : tipo := x;
	CONSTANT neg_a3 : tipo := x;
	CONSTANT neg_a4 : tipo := x;
	CONSTANT neg_a5 : tipo := x;
	CONSTANT b1 : tipo := x;
	CONSTANT b2 : tipo := x;
	CONSTANT b3 : tipo := x;
	CONSTANT b4 : tipo := x;
	CONSTANT b5 : tipo := x;

	SIGNAL estado_siguiente, estado_actual : estados;
	SIGNAL sv1, sv2, sv3, sv4 : std_logic_vector(15 downto 0);
	SIGNAL tmp_1, tmp_2, tmp3, tmp_4 : std_logic_vector(15 downto 0);
	SIGNAL x_1, x_2, x_3, x_4, x_5, y_2, y_3, y_4, y_5 : std_logic_vector(15 downto 0);
	SIGNAL Salida_prev, Salida_tmp : std_logic_vector(15 downto 0);

	PROCESS (estado_actual, mandos)
	BEGIN
		estado_siguiente <= estado_actual;
		-- mando_leido a tipo estados
		CASE mando_leido IS
			WHEN idle =>
				Salida <= (others => '0');
				Salida_prev <= (others => '0');
				flags <= (others => '0');
				Salida_prev <= (others => '0');
				sv1 <= (others => '0');
				sv2 <= (others => '0');
				sv3 <= (others => '0');
				sv4 <= (others => '0');
			WHEN estado_0 =>
				flags <= (others => '0');
				x_1 <= b1 * Entrada;
				x_2 <= b2 * Entrada;
				x_3 <= b3 * Entrada;
				x_4 <= b4 * Entrada;
				x_5 <= b5 * Entrada;
				y_2 <= Salida_prev * neg_a2;
				y_3 <= Salida_prev * neg_a3;
				y_4 <= Salida_prev * neg_a4;
				y_5 <= Salida_prev * neg_a5;
				estado_siguiente <= estado_1;
			WHEN estado_1 =>
				tmp_1 <= x_1 + sv1;
				tmp_2 <= x_2 + sv2;
				tmp_3 <= x_3 + sv3;
				tmp_4 <= x_4 + sv4;
				estado_siguiente <= estado_2;
			WHEN estado_2 =>
				Salida_tmp <= tmp_1 * inverso_a1;
				sv1 <= tmp_2 + y_2;
				sv2 <= tmp_3 + y_3;
				sv3 <= tmp_4 + y_4;
				sv4 <= x_5 + y_5;
				flags <= FIN;
		END CASE;	
		IF (mandos = valida_dato) THEN
			estado_siguiente <= estado_0;
		END IF;		
	END PROCESS;
	
	PROCESS (Clk, Reset) 
	BEGIN
		IF (Reset = '0') THEN
			Salida <= (others => '0');
			flags <= (others => '0');
			estado_actual <= idle;
		ELSIF (Clk'event) and Clk = '1' THEN
			estado_actual <= estado_siguiente;
		END IF;
	END PROCESS;
	
end behavioral
