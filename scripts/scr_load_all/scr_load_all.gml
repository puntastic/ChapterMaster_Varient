function scr_load_all(select_units) {
	var sell="";

	// Load / Select All
	if (select_units){
		man_size=0;
		// This sets the maximum size of marines in a company to 200 size
		for(var i=1; i<=500; i++){
	        if (man[i]=="man") and (ma_loc[i]==selecting_location) and (ma_wid[i]==selecting_planet) and (ma_god[i]<10){
				man_sel[i]=1;
	            man_size+=scr_unit_size(ma_armour[i],ma_role[i],true);
	        }
	        //if (i<=200){
	            if (man[i]=="vehicle") and (ma_loc[i]==selecting_location) and (ma_wid[i]==selecting_planet){
					man_sel[i]=1;
		        	if (selecting_location==""){
	                    selecting_location=ma_loc[i];
	                    selecting_ship=ma_lid[i];
	                    selecting_planet=ma_wid[i];
	                }	            	
	                man_size+=scr_unit_size("",ma_role[i],true);
	            }
	        //}
	    }
	}
	// Unload / Unselect All
	if (!select_units){
	    alll=0;
		man_size=0;
	    for(var i=1; i<=500; i++){
            if (selecting_location!="")
            and ((ma_loc[i]!=selecting_location)
            or (ma_wid[i]!=selecting_planet)) then continue;
            if (selecting_location==""){
	            selecting_location=ma_loc[i];
	            selecting_ship=ma_lid[i];
	            selecting_planet=ma_wid[i];
            }    	
	        man_sel[i]=0;
	    }
	}
}
