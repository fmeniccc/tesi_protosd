
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myfifos is
port(
	reset		:	in	STD_LOGIC;
	datain	:	in	STD_LOGIC_VECTOR(15 downto 0);
	dataout	:	out	STD_LOGIC_VECTOR(15 downto 0)
);
end myfifos;

architecture Behavioral of myfifos is

COMPONENT fifo1
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT fifo2
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

signal	_clk			:	STD_LOGIC;
signal	_clk1			:	STD_LOGIC;
signal	_datain		:	STD_LOGIC_VECTOR(15 downto 0);
signal	_datamiddle	:	STD_LOGIC_VECTOR(15 downto 0);
signal	_dataout		:	STD_LOGIC_VECTOR(15 downto 0);
signal	_full0		:	STD_LOGIC;
signal	_empty0		:	STD_LOGIC;
signal	_full2		:	STD_LOGIC;
signal	_empty2		:	STD_LOGIC;
signal	_rst			:	STD_LOGIC;

begin

okHI	:	okHost		port map	(
											hi_in=>hi_in,
											hi_out=>hi_out,
											hi_inout=>hi_inout,
											hi_aa=>hi_aa,
											ti_clk=>_clk,
											ok1=>ok1,
											ok2=>ok2
										);	
cmpt1	:	fifo1			port map (
											rst => _rst,
											wr_clk => _clk,
											rd_clk => _clk1,
											din => _datain,
											wr_en => (not _full0) and ep_write, --NON SI FA COSì!
											rd_en => not _empty0,
											dout => _datamiddle,
											full => _full0,
											empty => _empty0
										);
cmpt2	:	fifo2			port map (
											rst => _rst,
											wr_clk => not _clk1,
											rd_clk => _clk1,
											din => _datamiddle,
											wr_en => not _full2,
											rd_en => _empty2,
											dout => _dataout,
											full => _full2,
											empty => (not empty) and ep_read --NON SI FA COSì!
										);
pipe1	:	okPipeIn		port map	(
											ok1 => ok1,
											ok2 => ok2,
											ep_addr => x"9c",
											ep_dataout => _datain,
											ep_write => _wr_en --DA RIVEDERE
										);
pipe2	:	okPipeOut	port map	(
											ok1 => ok1,
											ok2 => ok2,
											ep_addr => x"a3",
											ep_datain => _dataout,
											ep_read => _rd_en --DA RIVEDERE
										);

end Behavioral;

