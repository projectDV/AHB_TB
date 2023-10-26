class ahb_opmon;
  ahb_txn txn, txn2sb;
  virtual ahb_if if;
  mailbox#(ahb_txn)mon2sb;

  	function new(  virtual ahb_if if,
    		mailbox#(ahb_txn)mon2sb);

    		txn= new();
    		this.if=if;
    		this.mon2sb=mon2sb;
  	endfunction

	task monitor();
		@(mon2sb_cb)
		txn.hrdata=if.hrdata;
		txn.hready=if.hready;
		txn.hresp=if.hresp;
	endtask

	task start();
		fork
		forever begin
		monitor();
		txn2sb=new txn;
		mon2sb.put(txn2sb);
    txn=new();
		end
		join_none
	endtask
endclass

	
