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
		Clk		: in std_logic;
		Reset	: in std_logic;
		Entradas_ent: in std_logic_vector(7 downto 0);
		Entradas_frc: in std_logic_vector(7 downto 0);
		Salidas_ent : out std_logic_vector(7 downto 0);
		Salidas_frc : out std_logic_vector(7 downto 0);
		flags	: out  std_logic_vector(2 downto 0);
		mandos	: in std_logic_vector(2 downto 0));
	end datapath;
	
architecture Behavioral of datapath is
	TYPE estados IS (idle, filtrar);
	SIGNAL next_state, current_state : estados;

	PROCESS (Clk, Reset)
	BEGIN
		IF (Reset = '0') THEN
			Salidas_ent <= (others => '0');
			Salidas_frc <= (others => '0');
			flags <= (others => '0');
			next_state <= idle;
		ELSE
			CASE current_state IS
				WHEN idle =>
					Salidas_ent <= (others => '0');
					Salidas_frc <= (others => '0');
					flags <= (others => '0');
					next_state <= idle;
				WHEN filtrar =>
				
		END IF;
	END PROCESS;
	
end behavioral