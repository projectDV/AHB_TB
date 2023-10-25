class ahb_txn;

	rand bit [31:0]hwdata,haddr;
	rand bit hwrite;
	rand bit [2:0]hsize,hburst;
	rand bit [1:0]htrans;
	rand bit [3:0]hsel;
	
	bit hresp, hready;
	bit [31:0] hrdata;
	static int txn_id;
	function void post_randomize();
		$display("TXN Packet Generated");
		$display("\n hwdata: %0d, haddr: %d, hwrite: %0b, hsize: %0b, hburst: %0b, htrans: %0b, hsel: %0d", hwdata,haddr,hwrite,hsize,hburst,htrans,hsel);
		txn_id++;
	endfunction
	
	function bit compare(ahb_txn txn);
		if(this.hresp==txn.hresp && this.hready==txn.hready)begin
			foreach(txn.hrdata[i])begin
				if(this.hrdata[i]!=txn.hrdata[i])
					return 1;
				else
					return 0;
			end
		else
			return 0;
		end
	endfunction
endclass
			
	
