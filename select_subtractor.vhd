library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity select_subtractor is
	port(
		    a : in std_logic_vector(7 downto 0);
		    b : in std_logic_vector(7 downto 0);
		    res : out std_logic_vector(7 downto 0);
		    bout : out std_logic
        );
end select_subtractor;

architecture rtl of select_subtractor is
	signal subtract : std_logic_vector (8 downto 0);
begin
	subtract <= ('0' & a) - ('0' & b);
    	res <= a when subtract(8) = '1' else
	       subtract(7 downto 0) when subtract(8) = '0';
	bout <= subtract(8);
end rtl;
