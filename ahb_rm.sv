class ahb_rm;

	ahb_txn txn, txn2sb;
	mailbox#(ahb_txn)mon2rm;
	mailbox#(ahb_txn)rm2sb;

	int mem [int];

	function new(mailbox#(ahb_txn)mon2rm,
                     mailbox#(ahb_txn)rm2sb);

		txn=new();
		this.mon2rm=mon2rm;
		this.rm2sb=rm2sb;
		mem=new[32];
	endfunction

	task rd_wr();
		if(!txn.hreset_n)	
			foreach(mem[i])begin
				mem[i]=0;
			end
		elseif(txn.htrans==2'b10 && txn.hwrite)begin
			mem[txn.haddr]=txn.hwdata;
			end
		elseif(txn.htrans==2'b01)begin
			txn.hrdata=mem[txn.haddr];
			end
	endtask

	task start();
		fork 
			forever begin
				mon2rm.get(txn);
				rd_wr();
				txn2sb=new txn;
				rm2sb.put(txn2sb);
				end
		join_none
	endtask
endclass
