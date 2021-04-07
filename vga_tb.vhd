----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2021 05:37:49 PM
-- Design Name: 
-- Module Name: vga_tb - Behavioral
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

entity vga_tb is
end vga_tb;

architecture Behavioral of vga_tb is

signal tb_clk : std_logic;
signal tb_en : std_logic;
signal tb_vid : std_logic;
signal tb_hs : std_logic;
signal tb_vs : std_logic;
signal tb_hcount : std_logic_vector(9 downto 0);
signal tb_vcount : std_logic_vector(9 downto 0);

component vga_ctrl is 
  Port ( 
      clk, en : in std_logic;
      hcount, vcount : out std_logic_vector(9 downto 0);
      vid, hs,vs : out std_logic
);
end component;

begin

clk_gen : process begin
    tb_clk <= '0';
    wait for 4 ns;
    tb_clk <= '1';
    wait for 4 ns;
end process clk_gen;

en_gen : process begin
    tb_en <= '0';
    wait for 40 ns;
    tb_en <= '1';
    wait for 1 ns;
    
end process en_gen;

dut: vga_ctrl port map (
    clk => tb_clk,
    en => tb_en,
    vid => tb_vid,
    hcount => tb_hcount,
    vcount => tb_vcount,
    hs => tb_hs,
    vs => tb_vs
    
);

end Behavioral;
