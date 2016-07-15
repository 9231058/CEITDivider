library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity select_subtractor is
	generic (N : natural := 8);
	port(a : in std_logic_vector(N - 1 downto 0);
		b : in std_logic_vector(N - 1 downto 0);
		res : out std_logic_vector(N - 1 downto 0);
		bout : out std_logic
        );
end select_subtractor;

architecture rtl of select_subtractor is
	signal subtract : std_logic_vector (N downto 0);
begin
	subtract <= ('0' & a) - ('0' & b);
    	res <= a when subtract(N) = '1' else
	       subtract(N - 1 downto 0) when subtract(N) = '0';
	bout <= subtract(N);
end rtl;
