class ahb_test;

	ahb_env env;
	ahb_txn txn;
	virtual ahb_if.DRV_MP drv_mp;
	virtual ahb_if.DRV2MON_MP drv2mon_mp;
	virtual ahb_if.DRV2SB_MP drv2sb_mp;
	
	function new(virtual ahb_if if);
		this.drv_mp=drv_mp;
		this.drv2mon_mp=drv2mon_mp;
		this.drv2sb_mp=drv2mon_mp;
		env=new(drv_mp,drv2mon_mp,drv2sb_mp);
	endfunction
	
	task build_and_run();
		begin
			env.build();
			env.run();
			$finish();
		end
	endtask
endclass
