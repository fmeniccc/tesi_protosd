
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity one_fifo is
	Port (
				reset		:	in  STD_LOGIC;
				datain	:	in  STD_LOGIC_VECTOR (15 downto 0);
				dataout	:	out  STD_LOGIC_VECTOR (15 downto 0)
	);
end one_fifo;

architecture Behavioral of one_fifo is

COMPONENT myfifo IS
	PORT (
		clk		:	IN STD_LOGIC;
		rst		:	IN STD_LOGIC;
		din		:	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_en		:	IN STD_LOGIC;
		rd_en		:	IN STD_LOGIC;
		dout		:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		full		:	OUT STD_LOGIC;
		empty		:	OUT STD_LOGIC
	);
END COMPONENT;

signal _rst			:	STD_LOGIC	:=	reset;						--	
signal _clk			:	STD_LOGIC;										--	okHost -> myfifo
signal _wr_en		:	STD_LOGIC;										--	okPipeIn -> myfifo
signal _rd_en		:	STD_LOGIC;										--	myfifo -> okPipeOut
signal _full		:	STD_LOGIC;										--	myfifo OUT
signal _empty		:	STD_LOGIC;										--	myfifo OUT
signal _datain		:	STD_LOGIC_VECTOR(15 downto 0);			--	okPipeIn -> myfifo
signal _dataout	:	STD_LOGIC_VECTOR(15 downto 0);			--	myfifo -> okPipeOut

begin

okHI	:	okHost		port map	(	hi_in=>hi_in,
											hi_out=>hi_out,
											hi_inout=>hi_inout,
											hi_aa=>hi_aa,
											ti_clk=>_clk,
											ok1=>ok1,
											ok2=>ok2
										);		
cmpt1	:	myfifo		port map	(	clk => _clk,
											rst=>_rst,
											din=>_datain,
											wr_en=>_wr_en,
											rd_en=>_rd_en,
											dout=>_dataout,
											full=>_full,
											empty=>_empty
										);
pipe1	:	okPipeIn		port map	(	ok1 => ok1,
											ok2 => ok2,
											ep_addr => x"9c",
											ep_dataout => _datain,
											ep_write => _wr_en
										);
pipe2	:	okPipeOut	port map	(	ok1 => ok1,
											ok2 => ok2,
											ep_addr => x"a3",
											ep_datain => _dataout,
											ep_read => _rd_en
										);


										
end Behavioral;

