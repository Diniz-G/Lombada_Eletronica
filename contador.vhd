-- Contador elaborado para o projeto de Circuitos Lógicos
-- Prof. Marcos Meira
-- Autores:	Édio Pedro
--				Fabrício Leitão
--				Gabriel Diniz
--				Matheus Melo
--	Data:		12/01/2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador is
port	(
		clk, reset	:	in	std_logic;
		carry_out	: 	out std_logic;
		q				:	out std_logic_vector(3 downto 0));

end contador;
------------------------------------------------------------
architecture main of contador is

begin
	process (clk, reset)
	variable qtemp: std_logic_vector(3 downto 0);
	begin
		if reset = '1' then
			qtemp:="0000";  
		else
			if clk'event and clk='0' then
				if qtemp<9 then
					qtemp:=qtemp+1;
               carry_out <= '0';
            else
               qtemp:="0000";
               carry_out <= '1';
				end if;
			end if;
			q <= qtemp;
		end if;
		end process;
end main;
	