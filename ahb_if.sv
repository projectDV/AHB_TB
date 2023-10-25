interface ahb_if;
  logic hclk, hreset_n;//clk_rst
  logic [31:0] hwdata,hrdata;//rd_wr_channels
  //addr_control_signals
  logic [31:0] haddr;
  logic hwrite, hready;
  logic [2:0]hsize,hburst;
  logic [1:0] htrans;
  logic [3:0] hsel;
  logic hresp;

	clocking driver_cb@(posedge hclk);
		output hready, hwdata,haddr,hwrite,hsize,hburst,htrans,hsel;
		input  hready;
	endclocking
	clocking drv2mon_cb@(posedge hclk);
		input hready, hwdata,haddr,hwrite,hsize,hburst,htrans,hsel;
	endclocking
	clocking mon2sb_cb@(posedge hclk);
		input hrdata, hready,hresp;
	endclocking
	
	modport DRV_MP(clocking driver_cb);
	modport DRV2MON_MP(clocking drv2mon_cb);
	modport MON2SB_MP(clocking mon2sb_cb);
endinterface
  
