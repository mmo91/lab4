----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2021 11:48:20 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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

entity pixel_pusher is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           VS : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           vid : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (2 downto 0);
           B : out STD_LOGIC_VECTOR (1 downto 0);
           G : out STD_LOGIC_VECTOR (2 downto 0);
           addr : out STD_LOGIC_VECTOR (17 downto 0));
end pixel_pusher;

architecture Behavioral of pixel_pusher is

signal counter : std_logic_vector(17 downto 0) := (others => '0');

begin
process(clk) begin
    if(rising_edge(clk)) then
        if (en = '1') then
            -- reset--
            if (VS = '0') then
                counter <= (others=> '0');
                addr <= counter;
            end if;
            
            if (vid = '1' and unsigned(hcount) < 480) then
                -- increment addr counter--
                counter <= std_logic_vector(unsigned(counter) + 1);
                addr <= counter;
                
                --set R G B --
                R <= pixel(7 downto 5);
                G <= pixel(4 downto 2);
                B <= pixel(1 downto 0);
            else
                R <= (others => '0');
                G <= (others => '0');
                B <= (others => '0');
                
            end if;
        end if;
    end if;
end process;


end Behavioral;