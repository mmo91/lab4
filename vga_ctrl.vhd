----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2021 05:12:00 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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

entity vga_ctrl is
  Port ( 
        clk, en : in std_logic;
        hcount, vcount : out std_logic_vector(9 downto 0);
        vid, hs,vs : out std_logic
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is
signal hc : std_logic_vector(9 downto 0) :=(others => '0');
signal h_on : std_logic;
signal vc : std_logic_vector(9 downto 0) := (others => '0');
signal v_on : std_logic;

begin
process(clk) begin
    if (rising_edge(clk)) then
        if (en = '1') then
        
           -- horizontal counter --
           if (unsigned(hc) < 799) then
            hc <= std_logic_vector(unsigned(hc) + 1);
            hcount <= hc;
           else
            hc <= (others => '0');
            hcount <= hc;
           end if;
           
           -- vertical counter --
           if (unsigned(hc) = 0) then
            if (unsigned(vc) < 524) then
                vc <= std_logic_vector(unsigned(vc) + 1);
                vcount <= vc;
            else
                vc <= (others => '0');
                vcount <= vc;
            end if;
           end if;
           
           -- set display ON or OFF --
           if (unsigned(hc) <= 639 and unsigned(vc) <= 479) then
            vid <= '1';
           else
            vid <= '0';
           end if;
           
           -- horizontal sync --
           if (unsigned(hc) >= 656 and unsigned(hc) <= 751) then
            hs <= '0';
           else
            hs <= '1';
           end if;
           
           -- vertical sync --
           if (unsigned(vc) >= 490 and unsigned(vc) <= 491) then
            vs <= '0';
           else
            vs <= '1';
           end if;
            
        end if;
    end if;
end process;


end Behavioral;
