class ahb_env;
	ahb_gen gen;
	ahb_drv drv;
	ahb_ipmon ipmon;
	ahb_opmon opmon;
	ahb_rm rm;
	ahb_sb sb;
	ahb_txn txn;
	
	virtual ahb_if.DRV_MP drv_mp;
	virtual ahb_if.DRV2MON_MP drv2mon_mp;
	virtual ahb_if.DRV2SB_MP drv2sb_mp;
	
	mailbox #(ahb_txn)gen2drv=new();
	mailbox#(ahb_txn) mon2rm=new();
	mailbox#(ahb_txn)mon2sb=new();
	//mailbox#(ahb_txn)mon2rm=new();
	mailbox#(ahb_txn)rm2sb=new();
	//mailbox#(ahb_txn)rm2sb=new();
	//mailbox#(ahb_txn)mon2sb=new();
	
	function new(	virtual ahb_if.DRV_MP drv_mp,
					virtual ahb_if.DRV2MON_MP drv2mon_mp,
					virtual ahb_if.DRV2SB_MP drv2sb_mp);
					
					this.drv_mp=drv_mp;
					this.drv2mon_mp=drv2mon_mp;
					this.drv2sb_mp=drv2mon_mp;
	endfunction
	
	task build();
		gen=new(gen2drv);
		drv=new(gen2drv, drv_mp);
		ipmon=new(mon2rm, drv2mon_mp);
		opmon=new(mon2sb, drv2sb_mp);
		rm=new(mon2rm,rm2sb);
		sb=new(rm2sb,mon2sb);
	endtask
	
	task start();
		gen.start();
		drv.start();
		ipmon.start();
		opmon.start();
		rm.start();
		sb.start();
	endtask 
	
	task run();
		start();
	endtask
endclass	
		
		
	
	
