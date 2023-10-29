class ahb_sb;
	mailbox#(ahb_txn)rm2sb;
	mailbox#(ahb_txn)mon2sb;

	ahb_txn txn2rm, txn2sb;
	static int no_of_testcases;
	event DONE;

	function new(mailbox#(ahb_txn)rm2sb;
		     mailbox#(ahb_txn)mon2sb, int no_of_testcases);
	
		txn2rm=new();
		txn2sb=new();
		this.rm2sb=rm2sb;
		this.mon2sb=mon2sb;
		this.no_of_testcases=no_of_testcases;
	endfunction

	
	function void compare();
		if(txn2sb.compare(txn2rm))begin
			$display("Packet ID: %0d PASSED",txn.txn_id);
		end
		else begin
			$display("Packet ID: %0d FAILED",txn.txn_id);
		end
	endfunction

	function start();
		fork
			forever begin
			rm2sb.get(txn2rm);
			mon2sb.get(txn2sb);
			compare();
			int i++;
			if(i>=no_of_testcases)
			-> DONE;
			end
		join_none;
	endfunction
endclass

	
