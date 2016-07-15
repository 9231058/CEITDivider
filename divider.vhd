library IEEE;
use IEEE.std_logic_1164.all;

entity divider_eight is
	generic (N : natural := 8;
		M : natural := 4);
	port(a : in std_logic_vector(N - 1 downto 0);
		b : in std_logic_vector(M - 1 downto 0);
		q : out std_logic_vector(N - M downto 0);
		r : out std_logic_vector(N - M - 1 downto 0);
		ovf : out std_logic);
end divider_eight;

architecture gate_level of divider_eight is
	component select_subtractor is
		generic (N : natural := 8);
		port(a : in std_logic_vector(N - 1 downto 0);
			b : in std_logic_vector(N - 1 downto 0);
			res : out std_logic_vector(N - 1 downto 0);
			bout : out std_logic);
	end component;
	for all:select_subtractor use entity work.select_subtractor;

	signal bout : std_logic_vector(N - M downto 0);
	signal res : std_logic_vector(N - 1 downto 0);
begin
	res <= a;
	sss: for I in N - 1 downto M - 1 generate
		ss:select_subtractor port map(res , (I downto I - M + 1 => b, others => '0'), res, bout(I - M + 1));
	end generate;

	r <= res(N - M - 1 downto 0);
	q <= not bout;
end gate_level;
