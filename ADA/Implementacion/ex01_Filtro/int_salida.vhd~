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
		Clk		: in std_logic;
		Reset	: in std_logic;
		Validacion : out std_logic;
		TD 		: out std_logic_vector(15 downto 0);
		Salidas_ent : in std_logic_vector(7 downto 0);
		Salidas_frc : in std_logic_vector(7 downto 0);
		Fin		: in std_logic);
	end int_salida;
	
architecture Behavioral of int_salida is

	PROCESS (Clk, Reset)
	BEGIN
		IF (Reset = '0') THEN
			Salidas <= (others => '0');
			Validacion <= '0';
		ELSIF (Clk'event) and Clk = '1' and Fin = '1' THEN
			TD <= Salidas_ent & Salidas_frc;
			Validacion <= '1';
		END IF;
	END PROCESS;
	
end behavioral
