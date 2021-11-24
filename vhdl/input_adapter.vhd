----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2021 07:05:36 AM
-- Design Name: 
-- Module Name: input_adapter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input_adapter is
    Port ( input_bus : in STD_LOGIC_VECTOR (31 downto 0);
           byte_0 : out STD_LOGIC_VECTOR (15 downto 0);
           byte_1 : out STD_LOGIC_VECTOR (15 downto 0);
           byte_2 : out STD_LOGIC_VECTOR (15 downto 0);
           byte_3 : out STD_LOGIC_VECTOR (15 downto 0));
end input_adapter;

architecture Behavioral of input_adapter is

begin

byte_0(15 downto 8) <= input_bus(7 downto 0);
byte_0(7 downto 0) <= "00000000";

byte_1(15 downto 8) <= input_bus(15 downto 8);
byte_1(7 downto 0) <= "00000000";

byte_2(15 downto 8) <= input_bus(23 downto 16);
byte_2(7 downto 0) <= "00000000";

byte_3(15 downto 8) <= input_bus(31 downto 24);
byte_3(7 downto 0) <= "00000000";

end Behavioral;
