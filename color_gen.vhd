----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2021 08:30:35 PM
-- Design Name: 
-- Module Name: color_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity color_gen is
Port ( 
        red, green : in std_logic_vector(2 downto 0);
        blue : in std_logic_vector(1 downto 0);
        clk, en : in std_logic;
        rd : out std_logic_vector(7 downto 0);
        gn: out std_logic_vector(7 downto 0);
        be : out std_logic_vector(7 downto 0)
);
end color_gen;

architecture Behavioral of color_gen is

signal r_hold : unsigned(7 downto 0);
signal g_hold : unsigned(7 downto 0);
signal b_hold : unsigned(7 downto 0);
--signal r_hold : std_logic_vector(7 downto 0);
--signal g_hold : std_logic_vector(7 downto 0);
--signal b_hold : std_logic_vector(7 downto 0);

begin
process(clk) begin
    if (rising_edge(clk)) then
        if(en = '1') then
            -- convert 3:3:2 rgb to 8:8:8 rgb --
            --r_hold <= red & "00000";
            --g_hold <= green & "00000";
            --b_hold <= blue & "000000";
            r_hold <= to_unsigned(to_integer(255 * unsigned(red)/7), 8);
            g_hold <= to_unsigned(to_integer(255 * unsigned(green)/7), 8); 
            b_hold <= to_unsigned(to_integer(255 * unsigned(blue)/3) , 8); 
            
           
            -- assign to signals --
            rd <= std_logic_vector(r_hold);
            gn <= std_logic_vector(g_hold);
            be <= std_logic_vector(b_hold);
   --         rd <= r_hold;
   --         gn <= g_hold;
    --        be <= b_hold;
        end if;
    end if;
            
end process;


end Behavioral;
