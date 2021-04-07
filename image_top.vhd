library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
    Port ( clk : in STD_LOGIC;
       clka, clkb : out std_logic;
       hdmi_en : out std_logic;
       douta, doutb: out std_logic_vector(2 downto 0));
end image_top;

architecture Behavioral of image_top is

component clock_div is 
Port (
    clk : in std_logic;
    div : out std_logic
 );
end component;

component vga_ctrl is 
  Port ( 
      clk, en : in std_logic;
      hcount, vcount : out std_logic_vector(9 downto 0);
      vid, hs,vs : out std_logic
);
end component;

component picture is 
  PORT (
  clka : IN STD_LOGIC;
  addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
  douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;

component pixel_pusher is 
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
end component;


component color_gen is
Port ( 
        red, green : in std_logic_vector(2 downto 0);
        blue : in std_logic_vector(1 downto 0);
        clk, en : in std_logic;
        rd, gn, be : out std_logic_vector(7 downto 0)
);
end component;

component rgb2dvi_0 IS
  PORT (
    TMDS_Clk_p : OUT STD_LOGIC;
    TMDS_Clk_n : OUT STD_LOGIC;
    TMDS_Data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    TMDS_Data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    aRst : IN STD_LOGIC;
    vid_pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    vid_pVDE : IN STD_LOGIC;
    vid_pHSync : IN STD_LOGIC;
    vid_pVSync : IN STD_LOGIC;
    PixelClk : IN STD_LOGIC
  );
END component;

signal en : std_logic;
signal addra : std_logic_vector(17 downto 0);
signal addr : std_logic_vector(7 downto 0);
signal hcount: std_logic_vector(9 downto 0);
signal vcount: std_logic_vector(9 downto 0);
signal vid : std_logic;
signal vs : std_logic;
signal hs : std_logic;
signal hdmi_r : std_logic_vector(2 downto 0);
signal hdmi_g : std_logic_vector(2 downto 0);
signal hdmi_b : std_logic_vector(1 downto 0);
signal r : std_logic_vector(7 downto 0);
signal g : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal data : std_logic_vector(23 downto 0);
signal rst : std_logic := '0';
begin

u1: clock_div Port map( clk => clk, div => en);
u2: picture Port map (clka => en, addra => addra, douta => addr);
u3: pixel_pusher Port map (clk => clk, en => en, VS => vs, pixel => addr, hcount => hcount, vid => vid,
                            R => hdmi_r, B => hdmi_b, G => hdmi_g, addr => addra);
u4: vga_ctrl Port map (clk => clk, en => en, hcount => hcount, vcount => vcount,
                        vid => vid, vs => vs, hs => hs);
u5: color_gen Port map (clk => clk, en => en, red => hdmi_r, blue => hdmi_b, green => hdmi_g,
                        rd => r, gn => g, be => b);
data <= r & g & b;

u6: rgb2dvi_0 Port map (
    TMDS_Clk_p => clka,
    TMDS_Clk_n => clkb,
    TMDS_Data_p => douta,
    TMDS_Data_n => doutb,
    aRst => rst,
    vid_pData => data,
    vid_pVDE => vid,
    vid_pHsync => hs,
    vid_pVsync => vs,
    PixelClk => en);
                           
                        
                             

end Behavioral;