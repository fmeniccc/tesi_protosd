
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_misc.all;
--use IEEE.std_logic_unsigned.all;
use work.FRONTPANEL.all;


entity one_fifo is
	Port (
				clk1		:	in STD_LOGIC;
				hi_in		:	in    STD_LOGIC_VECTOR(7 downto 0);
				hi_out   :	out   STD_LOGIC_VECTOR(1 downto 0);
				hi_inout :	inout STD_LOGIC_VECTOR(15 downto 0);
				hi_aa    :	inout STD_LOGIC				
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

signal ti_clk	:	STD_LOGIC;
signal ok1		:	STD_LOGIC_VECTOR(30 downto 0);
signal ok2		:	STD_LOGIC_VECTOR(16 downto 0);
signal ok2s		:	STD_LOGIC_VECTOR(16 downto 0);

signal w_reset			:	STD_LOGIC_VECTOR(15 downto 0);
signal w_dataout		:	STD_LOGIC_VECTOR(15 downto 0);
signal w_datain		:	STD_LOGIC_VECTOR(15 downto 0);
signal w_readEnable	:	STD_LOGIC;
signal w_writeEnable	:	STD_LOGIC;
signal w_epRead		:	STD_LOGIC;
signal w_epWrite		:	STD_LOGIC;
signal w_full			:	STD_LOGIC;
signal w_empty			:	STD_LOGIC;
	
begin

ep00res : okWireIn	port map(	ok1=>ok1,
											ep_addr=>x"00",
											ep_dataout=>w_reset
										);

okHI	:	okHost		port map	(	hi_in=>hi_in,
											hi_out=>hi_out,
											hi_inout=>hi_inout,
											hi_aa=>hi_aa,
											ti_clk=>ti_clk,
											ok1=>ok1,
											ok2=>ok2
										);		
cmpt1	:	myfifo		port map	(	clk =>	clk1,
											rst =>	not w_reset(0),
											din =>	w_dataout,
											wr_en =>	w_writeEnable,
											rd_en =>	w_readEnable,
											dout =>	w_datain,
											full =>	w_full,
											empty =>	w_empty
										);
pipe1	:	okPipeIn		port map	(	ok1 => ok1,
											ok2 => ok2,
											ep_addr => x"9c",
											ep_dataout => w_dataout,
											ep_write => w_epWrite
										);
pipe2	:	okPipeOut	port map	(	ok1 => ok1,
											ok2 => ok2s,
											ep_addr => x"a3",
											ep_datain => w_datain,
											ep_read => w_epRead
										);

w_writeEnable <= '1' when (w_full ='0' and w_epWrite='1') else '0';
w_readEnable  <= '1'	when (w_empty='0' and w_epRead ='1') else '0';


end Behavioral;

