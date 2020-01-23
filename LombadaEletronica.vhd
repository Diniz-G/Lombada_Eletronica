-- Projeto Lombada Eletrônica
-- Prof. Marcos Meira
-- Autores:	Édio Pedro
--				Fabrício Leitão
--				Gabriel Diniz
--				Matheus Melo

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity LombadaEletronica is
port(	s1, s2, clk									:	in std_logic;
		led_r, led_g								:	out std_logic;
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5	:	out std_logic_vector(0 to 6));
end LombadaEletronica;
--------------------------------------------------------------------------------------
architecture arquitetura of LombadaEletronica is

component divisor_clk_ms
port (clk_in: in std_logic;
       q_div: out std_logic);
end component;

component contador
port (clk, reset	:	in	std_logic;
		carry_out	: out std_logic;
		q				:	out std_logic_vector(3 downto 0));
end component;

component display_vetores
port(bcd: in std_logic_vector (3 downto 0);
     HEX: out std_logic_vector (0 to 6));
end component;
--------------------------------------------------------------------------------------
signal clk_1Hz: std_logic;
signal clk_1kHz: std_logic;
signal bcd0_s, bcd1_s, bcd2_s, bcd3_s, bcd4_s, bcd5_s: std_logic_vector(3 downto 0);
signal carry_out_s_ms: std_logic;
signal carry_out_s_cs: std_logic;
signal carry_out_s_ds: std_logic;
--------------------------------------------------------------------------------------
begin
divisor_ms: divisor_clk_ms port map (clk, clk_1kHz);

contador0: contador port map(clk_1kHz, s1, carry_out_s_ms, bcd0_s);

contador1: contador port map(carry_out_s_ms, s1, carry_out_s_cs, bcd1_s);

contador2: contador port map(carry_out_s_cs, s1, carry_out_s_ds, bcd2_s);

contador3: contador port map(carry_out_s_ds, s1, open, bcd3_s);

decod0: display_vetores port map(bcd0_s, HEX0);

decod1: display_vetores port map(bcd1_s, HEX1);

decod2: display_vetores port map(bcd2_s, HEX2);

decod3: display_vetores port map(bcd3_s, HEX3);

decod4: display_vetores port map(bcd4_s, HEX4);

decod5: display_vetores port map(bcd5_s, HEX5);
--------------------------------------------------------------------------------------
process (s1, s2)
variable velocidade: integer;
variable tempo_int: integer;
variable ms_int: integer;
variable cs_int: integer;
variable ds_int: integer;
variable seg_int: integer;
variable digit_dezena: std_logic_vector(3 downto 0);
variable digit_unidade: std_logic_vector(3 downto 0);
variable verif1: boolean;
variable verif2: boolean;
--------------------------------------------------------------------------------------
	begin
	
	if(s2 = '1') then
		verif1 := true;
	end if;
	
	if(s2 = '0' and verif1 = true) then
		verif2 := true;
	end if;
	
	if(verif1 = true and verif2 = true) then
			
		ms_int:= to_integer(unsigned(bcd0_s));
		cs_int:= to_integer(unsigned(bcd1_s));
		ds_int:= to_integer(unsigned(bcd2_s));
		seg_int:= to_integer(unsigned(bcd3_s));

		tempo_int := (seg_int*(10**3)) + (ds_int*(10**2)) + (cs_int*10) + ms_int;
		velocidade := ((20*(10**3)) / tempo_int);
			
		digit_dezena := std_logic_vector(to_unsigned(velocidade / 10, digit_dezena'length));
		digit_unidade := std_logic_vector(to_unsigned(velocidade rem 10, digit_unidade'length));
		bcd4_s <= digit_unidade;
		bcd5_s <= digit_dezena;
		
		if(velocidade > 12) then
			led_r <= '1';
			led_g <= '0';	
		else
			led_r <= '0';
			led_g <= '1';
		end if;
		verif1 := false;
		verif2 := false;
	
	end if;
	
end process;

end arquitetura;
