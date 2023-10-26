`include ahb_txn;
class ahb_gen;
	
	mailbox #(ahb_txn)gen2drv;
	event GEN2DRV_DONE;
	apb_txn txn,txn2drv;
	
	function new(mailbox #(ahb_txn)gen2drv);
		
			txn=new();
			this.gen2drv=gen2drv;
	endfunction
	
	task run();
		txn.randomize();
	endtask
	
	task start();
		fork
			begin
			txn.haddr=0;
			txn.hwdata=0;
			txn.hsize=0;
			txn.hburst=0;
			txn.htrans=0;
			txn.hsel=0;
			run();
			txn2drv=new.txn;
			gen2drv.put(txn2drv);
			->GEN2DRV_DONE;
		join_none
	endtask
	
endclass
		
		
