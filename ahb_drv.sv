`include ahb_txn;
class ahb_drv;
	ahb_txn txn,txn2dut;
	virtual ahb_if if;
	mailbox#(ahb_txn) gen2drv;
	
	function new(	virtual ahb_if if,
					mailbox#(ahb_txn) gen2drv);
					
			txn=new();
			this.if=if;
			this.gen2drv=gen2drv;
	endfunction 
	
	task addr_phase();
		if.haddr<=txn.haddr;
		if.hwrite<=txn.hwrite;
		if.hsel<=txn.hsel;
		if.htrans<=txn.htrans;
		if.hsize<=txn.hsize;
		if.hburst<=txn.hburst;
	endtask
	
	task data_phase();
		if.hwdata<=txn.hwdata;
	endtask
	
	task drive();
			if(!txn.hreset_n)begin
				@(if.driver_cb)
				txn.hreset_n<=1;
				@(if.driver_cb)
				addr_phase();
				@(if.driver_cb)
				data_phase;
			end
			txn.htrans<=2'b00 //idle
	endtask
	
	task start();
		fork
			forever begin
				gen2drv(txn);
				drive();
			end
		join_none
	endtask
endclass
