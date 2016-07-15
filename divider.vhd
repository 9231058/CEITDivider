library IEEE;
use IEEE.std_logic_1164.all;

entity divider is
	generic (N : natural := 8;
		M : natural := 4);
	port(a : in std_logic_vector(N - 1 downto 0);
		b : in std_logic_vector(M - 1 downto 0);
		q : out std_logic_vector(N - M downto 0);
		r : out std_logic_vector(N - M - 1 downto 0);
		ovf : out std_logic);
end divider;

architecture rtl of divider is
	component select_subtractor is
		generic (N : natural := 8);
		port(a : in std_logic_vector(N - 1 downto 0);
			b : in std_logic_vector(N - 1 downto 0);
			res : out std_logic_vector(N - 1 downto 0);
			bout : out std_logic);
	end component;
	for all:select_subtractor use entity work.select_subtractor generic map (N);
	
	type collection is array (N - M + 1 downto 0) of std_logic_vector(N - 1 downto 0);

	signal bout : std_logic_vector(N - M downto 0);
	signal res : collection := (others => (others => '0'));
	signal inp : collection := (others => (others => '0'));
begin
	res(N - M + 1) <= a;
	sss: for I in N - 1 downto M - 1 generate
		inp(I - M + 1)(I downto I - M + 1) <= b;
		ss:select_subtractor port map(res(I - M + 2) , inp(I - M + 1), res(I - M + 1), bout(I - M + 1));
	end generate;

	r <= res(0)(N - M - 1 downto 0);
	q <= not bout;
end rtl;
