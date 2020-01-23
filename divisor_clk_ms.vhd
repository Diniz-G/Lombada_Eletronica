-- DIVISOR DE CLOCK
-- 50MHz -> 1ms
 
library IEEE;
use IEEE.std_logic_1164.all;

entity divisor_clk_ms is
port (clk_in: in std_logic;
       q_div: out std_logic);
end divisor_clk_ms;
------------------------------------------------------
architecture behavioral of divisor_clk_ms is
signal clk_div: std_logic;
begin
process(clk_in)
    variable count: integer:= 1;                                              
begin                                                      
    if(clk_in'event and clk_in='0') then
        count:= count+1;
        if(count = 25000) then
            clk_div <= not clk_div;
            count:= 1;
        end if;
    end if;
end process;
 
q_div <= clk_div;
 
end behavioral;