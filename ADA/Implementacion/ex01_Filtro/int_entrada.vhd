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
		Clk		: in std_logic;
		Reset	: in std_logic;
		Validacion : in std_logic;
		Dato_in	: in std_logic_vector(15 downto 0);
		Entradas_ent: out std_logic_vector(7 downto 0));
		Entradas_frc: out std_logic_vector(7 downto 0));
	end component;
	
architecture Behavioral of int_entrada is

	PROCESS (Clk, Reset)
	BEGIN
		IF (Reset = '0') THEN
			Entradas_ent <= (others => '0');
			Entradas_frc <= (others => '0');
		ELSIF (Clk'event) and Clk = '1' and Validacion = '1' THEN
			Entradas_ent <= Dato_in(15 downto 8);
			Entradas_frc <= Dato_in(7 downto 0);
		END IF;
	END PROCESS;
	
end behavioral
