-- Decodificador BCD para 7 segmentos (vetores)
-- Entrada: bcd (vetor de 4 posicoes);
-- Saida: HEX (vetor de 7 posicoes)
-- Autores: Joao Vitor e Marcos Meira
-- 29/07/2017
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity display_vetores is
port(bcd: in std_logic_vector (3 downto 0);
      HEX: out std_logic_vector (0 to 6));
end display_vetores;
 
architecture arquitetura of display_vetores is
begin
    process(bcd)
    begin  
        case bcd is
            when "0000" => HEX <= NOT "1111110";
            when "0001" => HEX <= NOT "0110000";
            when "0010" => HEX <= NOT "1101101";
            when "0011" => HEX <= NOT "1111001";
            when "0100" => HEX <= NOT "0110011";
            when "0101" => HEX <= NOT "1011011";
            when "0110" => HEX <= NOT "1011111";
            when "0111" => HEX <= NOT "1110000";
            when "1000" => HEX <= NOT "1111111";
            when "1001" => HEX <= NOT "1110011";
            when others => HEX <= NOT "0000000";
        end case;
    end process;
end arquitetura;