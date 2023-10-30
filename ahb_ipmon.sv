//this will send pkt to RM
class ahb_ipmon;

	virtual ahb_if if;
	mailbox#(ahb_txn) mon2rm;
	
	ahb_txn txn, txn2rm;
	
	function new(virtual ahb_if if,	mailbox#(ahb_txn) mon2rm);
		txn=new();
		this.if=if;
		this.mon2rm=mon2rm;
	endfunction
	
	task monitor();
		@(if.drv2mon_cb);
			txn.addr=if.addr;
			txn.hsel=if.hsel;
			txn.write=if.write;
			txn.trans=if.trans;
			txn.size=if.size;
			txn.burst=if.burst;
	endtask
	
	task start();
		fork
			forever begin
				monitor();
				txn2rm=new txn;
				mon2rm.put(txn2rm);
				txn=new();
			end
		join_none
	endtask
endclass
