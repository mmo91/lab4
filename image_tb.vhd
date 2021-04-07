----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 11:24:24 PM
-- Design Name: 
-- Module Name: image_tb - Behavioral
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

entity image_tb is
--  Port ( );
end image_tb;

architecture Behavioral of image_tb is

component image_top is 
    Port ( clk : in STD_LOGIC;
       clka, clkb : out std_logic;
       hdmi_en : out std_logic;
       douta, doutb: out std_logic_vector(2 downto 0));
end component;

signal tb_clk : std_logic;
signal tb_clka : std_logic;
signal tb_clkb : std_logic;
signal tb_da : std_logic_vector(2 downto 0);
signal tb_db : std_logic_vector(2 downto 0);


begin

clk_gen: process begin
    tb_clk <= '0';
    wait for 4 ns;
    tb_clk <= '1';
    wait for 4 ns;
end process clk_gen;

dut: image_top port map (
    clk => tb_clk,
    clka => tb_clka,
    clkb => tb_clkb,
    douta => tb_da,
    doutb => tb_db

);


end Behavioral;
