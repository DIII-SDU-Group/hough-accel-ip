-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
--
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram is 
    generic(
            MEM_TYPE    : string := "block"; 
            DWIDTH     : integer := 1; 
            AWIDTH     : integer := 10; 
            MEM_SIZE    : integer := 801
    ); 
    port (
          addr0     : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          d0        : in std_logic_vector(DWIDTH-1 downto 0); 
          we0       : in std_logic; 
          clk        : in std_logic 
    ); 
end entity; 


architecture rtl of houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram is 

type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
shared variable ram : mem_array;

attribute syn_ramstyle : string; 
attribute syn_ramstyle of ram : variable is "block_ram";
attribute ram_style : string;
attribute ram_style of ram : variable is MEM_TYPE;

begin 



p_memory_access_0: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            if (we0 = '1') then 
                ram(CONV_INTEGER(addr0)) := d0; 
            end if;
        end if;
    end if;
end process;


end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180 is
    generic (
        DataWidth : INTEGER := 1;
        AddressRange : INTEGER := 801;
        AddressWidth : INTEGER := 10);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180 is
    component houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            we0 : IN STD_LOGIC;
            d0 : IN STD_LOGIC_VECTOR);
    end component;



begin
    houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram_U :  component houghlines_accel_xfHoughLines_0_480_640_0_1_1_2u_1u_32_800_0_180_s_accum_V_180_ram
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        we0 => we0,
        d0 => d0);

end architecture;


