function scr_weapon(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	// argument0: name
	// argument1: weapon2 name
	// argument2: man?
	// argument3: ID number
	// argument4: dreaded
	// argument5: nuum
	// argument6: description?

	// More spaghetti code.  This either calculates damage for battle blocks or generates a tooltip for the shop/management.
	// it also gets informatino abou marine equipment for the chapter managment screens

	var i,wip,wip1,wip2,atta,arp,acr,att1,apa1,att2,apa2,acr1,acr2,melee_hands,ranged_hands,rang1,rang2,rang,ammo1,ammo2,amm,spli1,spli2,spli,rending,thawep,descr,descr2,spe_descr,statt;
	var disk1,rending1,spe_descr1;
	i=0;wip1="";wip2="";wip="";thawep="";descr="";descr2="";spe_descr="";spe_descr1="";statt=0;rending=0;disk1="";rending1=0;
	melee_hands=0;ranged_hands=0;
	rang=0;atta=0;arp=0;acr=0;
	att1=0;apa1=0;att2=0;
	apa2=0;acr1=0;acr2=0;
	rang1=0;rang2=0;
	spli=0;spli1=0;spli2=0;
	ammo1=-1;ammo2=-1;amm=-1;


	thawep=argument0;

	obj_controller.temp[9000]="";
	
	//pulling from globals to reduce refactoring needed atm.
	var item = global
		.GetItemTable()
		.TryGetItem(argument0, global.GetItemModifierTable());
	var itemWrapped = item != false ? new ItemWrapper(item) : undefined;
	
	repeat(2){
	    i+=1;amm=-1;spli=0;
	    var emor;emor=0;

	    if (argument6="description") or (argument6="description_long"){
	        if (i=1) then thawep=argument1;
	        if (i=2) then thawep=argument0;
	        if (i=2){wip1=thawep;}
	        if (i=1){wip2=argument1;}
	    }
	    if (argument6!="description") and (argument6!="description_long"){
	        if (i=1) then thawep=argument0;
	        if (i=2) then thawep=argument1;
	        if (i=1){wip1=thawep;}
	        if (i=2){wip2=argument1;}
	    }

	 /*   if (string_count("&",thawep)>0) or (string_count("|",thawep)>0){
	        // Artifact Armour
	        var arti_armour;
	        arti_armour=false;
	        if (string_count("Power Armour",thawep)>0){statt=30;emor=1;arti_armour=true;}
	        if (string_count("Artificer",thawep)>0){statt=35;emor=1;arti_armour=true;spe_descr="+10% Melee";}
	        if (string_count("Terminator",thawep)>0){statt=45;emor=1;arti_armour=true;spe_descr="+20% Melee, -10% Ranged, Strength";}
	        if (string_count("Dreadnought",thawep)>0){statt=50;emor=1;arti_armour=true;}

	        // Artifact weapons
	        if (arti_armour=false){
	            if (string_count("Bolter",thawep)>0){
	                atta=65;arp=0;rang=12;ranged_hands+=2;amm=15;spli=1;
	                if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	            }
	            if (string_count("Plasma Pistol",thawep)>0){atta=115;arp=1;rang=3.1;melee_hands+=1;}
	            if (string_count("Plasma Gun",thawep)>0){atta=250;arp=1;rang=10;ranged_hands+=2;spli=1;}
	            if (string_count("Power Sword",thawep)>0){atta=180;arp=1;rang=1;melee_hands+=1;spli=1;spe_descr="Parry";}
	            if (string_count("Power Spear",thawep)>0){atta=200;arp=1;rang=1;melee_hands+=2;spli=1;}
	            if (string_count("Power Axe",thawep)>0){atta=190;arp=1;rang=1.2;melee_hands+=1;spli=1;}
	            if (string_count("Power Fist",thawep)>0){atta=450;arp=1;rang=1;melee_hands+=1;ranged_hands+=1;spli=1;}
	            if (string_count("Lightning Claw",thawep)>0){atta=400;arp=1;rang=1;melee_hands+=1;ranged_hands+=1;spli=1;}
                    if (string_count("Thunder Hammer",thawep)>0){atta=650;arp=1;rang=1;melee_hands+=2;spli=1;}
	            if (string_count("Relic Blade",thawep)>0){atta=700;arp=1;rang=1;melee_hands+=1;spli=1;}

	            if (string_count("Relic Blade",thawep)=0) and (atta>0){atta=atta*1;}

	            if (string_count("Tome",thawep)>0){atta=0;arp=0;rang=1;melee_hands+=1;ranged_hands+=1;}

	            if (string_count("DUB",thawep)>0){atta=floor(atta*1.5);melee_hands+=1;ranged_hands+=1;spli=1;}
	            if (string_count("Dae",thawep)>0){atta=floor(atta*1.5);amm=-1;}
	            if (string_count("VOI",thawep)>0){atta=floor(atta*1.2);}
	            if (string_count("ADA",thawep)>0){atta=floor(atta*1.1);}

	            if (string_count("mnr",thawep)>0){atta=floor(atta*0.85);}
	            if (string_count("MNR",thawep)>0){atta=floor(atta*0.85);}
	        }

	    }*/


	    if (i=1)
		{
			if(scr_is_for_first_loop(itemWrapped))
			{
				atta = itemWrapped.attack;
				arp = itemWrapped.penetration;
				rang = itemWrapped.range;
				ranged_hands += itemWrapped.rangedHands;
				melee_hands += itemWrapped.meleeHands;
				spli = itemWrapped.split;
				amm = itemWrapped.ammo;
				statt = itemWrapped.armour;
				emor = itemWrapped.isarmour;
				descr = itemWrapped.description;
			}
		}

		//ITEM_TYPE_HELD
		//force weapon logic not implented in the new item code
		switch(thawep)
		{
			case "Force Weapon":
				atta=400;arp=1;rang=1;melee_hands+=1;spli=1;
		        descr="An advanced, psychically-attuned close combat weapon that is only fully effective in the hands of a psyker.";
		        if (argument6!="description") and (argument6!="description_long"){
		        if (string_count("0",marine_powers[argument3])>0){atta=400;arp=0;rang=1;melee_hands+=1;spli=1;}
		        if (string_count("0",marine_powers[argument3])=0){thawep="Inactive Force Weapon";atta=30;arp=0;rang=1;melee_hands+=1;}}
				
				break;
				
			case "Master Crafted Force Weapon":
				atta=500;arp=1;rang=1;melee_hands+=1;spli=1;
		        descr="A more expertly crafted Force Weapon, the fine craftsmanship confers greater ease and control with disrupting matter.";
		        if (argument6!="description") and (argument6!="description_long"){
		        if (string_count("0",marine_powers[argument3])>0){atta=480;arp=0;rang=1;melee_hands+=1;spli=1;}
		        if (string_count("0",marine_powers[argument3])=0){thawep="Inactive Master Crafted Force Weapon";atta=30;arp=0;rang=1;melee_hands+=1;}}
				
				break;
				
			default:
				if(is_undefined(itemWrapped)) { break; }
				if(!itemWrapped.IsType(ITEM_TYPE_HELD)) { break; }
				
				atta = itemWrapped.attack;
				arp = itemWrapped.penetration;
				rang = itemWrapped.range;
				ranged_hands += itemWrapped.rangedHands;
				melee_hands += itemWrapped.meleeHands;
				spli = itemWrapped.split;
				amm = itemWrapped.ammo;
				//statt = itemWrapped.armour;
				//emor = itemWrapped.isarmour;
				descr = itemWrapped.description;
				
				if (argument6 == "description") { break; } 
				if (argument6 == "description_long") { break; }
				if (string_count("Terminator", marine_armour[argument3]) + string_count("Tartaros", marine_armour[argument3]) == 0)
					{ break;}
					
				if(itemWrapped.rangedHands > 0) { ranged_hands--; }
				if(itemWrapped.meleeHands > 0) { melee_hands--; }
		}
		
		
		#region termie modified
		/* if (thawep="Storm Bolter"){atta=80;arp=0;rang=10;ranged_hands+=2;amm=10;spli=1;
	        if (argument6!="description") and (argument6!="description_long"){
	        if (string_count("Terminator",marine_armour[argument3])>0) then melee_hands-=1;
	        if (marine_armour[argument3]="Tartaros") then melee_hands-=1;}
	        if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	        descr="Compact, and double barreled, this bolt weapon is inaccurate but grants an enormous amount of firepower.";}
	    if (thawep="Flamer"){atta=350;arp=-1;rang=2.1;ranged_hands+=2;amm=4;spli=1;
	        if (argument6!="description") and (argument6!="description_long"){
	        if (string_count("Terminator",marine_armour[argument3])>0) then melee_hands-=1;
	        if (marine_armour[argument3]="Tartaros") then melee_hands-=1;
	        // if (obj_ncombat.enemy=3) or (obj_ncombat.enemy=13) then atta=40;
	        }
	        if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	        descr="Blackened at the tip, this weapon unleashes a torrent of burning promethium- all the better to cleanse sin and impurity with.";}
	    if (thawep="Incinerator"){atta=200;arp=-1;rang=2.1;ranged_hands+=2;amm=4;spli=1;
	        if (argument6!="description") and (argument6!="description_long"){
	        if (string_count("Terminator",marine_armour[argument3])>0) then melee_hands-=1;
	        if (marine_armour[argument3]="Tartaros") then melee_hands-=1;
	        if (obj_ncombat.enemy=10) and (obj_ncombat.threat=7) then atta=300;
	        }
	        if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	        descr="This flamer weapon includes special promethium and sacred oils.  It is particularly effective against Daemons and their ilk.";}

		if (thawep="Assault Cannon"){atta=240;arp=0;rang=12;ranged_hands+=2;amm=5;spli=1;
	        descr="A heavy, rotary auto-cannon frequently used by Dreadnoughts and Terminators.  Has an incredible rate of fire.";
	        if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	    }
	    if (thawep="Autocannon"){atta=180;arp=0;rang=18;ranged_hands+=2;amm=25;spli=1;
	        descr="A rapid-firing weapon able to use a wide variety of ammunition, from mass-reactive explosive to solid shells.";
	        if (obj_controller.menu=1) and ((string_count("Terminator",marine_armour[0])>0) or (marine_armour[0]="Tartaros")) then ranged_hands-=1;
	    }*/
		#endregion
		
	   if (thawep="Twin Linked Bolters"){atta=70;arp=0;rang=12;ranged_hands+=2;amm=30;spli=1;
	        descr="A Twin-linked Bolter consists of two Bolter weapons mounted side by side, typically on a vehicle or a special weapon platform.";}// Bursts
	    if (thawep="Twin Linked Heavy Bolter"){atta=240;arp=1;rang=16;amm=20;spli=1;
	        descr="Twin-linked Heavy Bolters are an upgraded version of the standard Heavy Bolter weapon, which is known for its high rate of fire and effectiveness against infantry and light vehicles. ";}
	    if (thawep="Twin Linked Lascannon"){atta=250;arp=1;rang=20;amm=10;
	        descr="Lascannons are powerful anti-armour weapons that fire highly focused and devastating energy beams capable of penetrating even the toughest armour. ";}
	    if (thawep="Lascannons"){atta=300;arp=1;rang=20;amm=5;
	        descr="Lascannons are powerful anti-armour weapons that fire highly focused and devastating energy beams capable of penetrating even the toughest armour. ";}
	    if (thawep="Heavy Bolters"){atta=320;arp=1;rang=16;amm=10;spli=1;
	        descr="The Heavy Bolter is a heavy weapon that fires larger and more powerful bolt shells compared to the standard Bolter.";}
	    if (thawep="Whirlwind Missiles"){atta=400;arp=1;rang=20;amm=6;spli=1;
	        descr="The Whirlwind Missile Launcher is a vehicle-mounted artillery weapon that launches a barrage of powerful missiles at the enemy.";}

					// Vehicle Upgrades
			if (argument0="Armoured Ceramite"){statt=20;spe_descr="";emor=1;
	        descr="Supplemental ceramite armour packages provide protection far beyond stock configurations.";}
			if (argument0="Artificer Hull"){statt=20;spe_descr="";emor=1;
	        descr="Replacing numerous structural members and armour plates with thrice-blessed replacements, the vehicle’s hull is upgraded to be a rare work of mechanical art.";}
			if (argument0="Heavy Armour"){statt=10;spe_descr="";emor=1;
	       	descr="Simple but effective, extra armour plates can be attached to most vehicles to provide extra protection.";}
			if (argument0="Lucifer Pattern Engine"){statt=5;spe_descr="";emor=1;
		    	descr="A significant upgrade over the more common patterns of Rhino-chassis engines, these engines provide greater output.";}

					// Vehicle Accessories
			if (thawep="Dozer Blades"){atta=60;arp=0;rang=1;melee_hands+=1;spli=1
			   	descr="An attachment for the front of vehicles, useful for clearing difficult terrain and can be used as an improvised weapon. ";}
			if (thawep="Searchlight"){
					descr="A simple solution for fighting in dark environments, searchlights serve to illuminate enemies for easier targeting. ";}
			if (thawep="Smoke Launchers"){
					descr="Useful for providing concealment in open terrain, these launchers project wide-spectrum concealing smoke to prevent accurate targeting of the vehicle. ";}

					// Vehicle Utility Weapons
			if (thawep="HK Missile"){atta=350;arp=1;rang=50;ranged_hands+=1;amm=1;spli=1;
			    descr="A single-use long-range anti-tank missile, this weapon can surgically destroy armoured targets in the opening stages of a battle.";}

					// Land Raider Front Mounts
			if (thawep="Twin Linked Heavy Bolter Mount"){atta=240;arp=0;rang=16;amm=20;spli=1;
			    descr="Twin-linked Heavy Bolters are an upgraded version of the standard Heavy Bolter weapon, which is known for its high rate of fire and effectiveness against infantry and light vehicles. ";}
			if (thawep="Twin Linked Lascannon Mount"){atta=250;arp=1;rang=20;amm=10;
			    descr="Lascannons are powerful anti-armour weapons that fire highly focused and devastating energy beams capable of penetrating even the toughest armour. ";}
			if (thawep="Twin Linked Assault Cannon Mount"){atta=360;arp=0;rang=12;amm=5;spli=1;
			    descr="A twin mount of rotary autocannons, boasting an incredible rate of fire.";}
			if (thawep="Reaper Autocannon Mount"){atta=250;arp=0;rang=15;amm=25;spli=1;
			   descr="An archaic twin-linked autocannon design dating back to the Great Crusade. Effective against a variety of targets. ";}

					// Land Raider Sponsons
			if (thawep="Quad Linked Heavy Bolter Sponsons"){atta=480;arp=1;rang=16;amm=10;spli=1;
					descr="Quad-linked Heavy Bolters are a significantly upgraded version of the standard Heavy Bolter mount; already punishing in a single mount, this quad mount is devastating against a variety of targets. ";}
			if (thawep="Twin Linked Lascannon Sponsons"){atta=375;arp=1;rang=20;amm=5;
			    descr="Lascannons are powerful anti-armour weapons that fire highly focused and devastating energy beams capable of penetrating even the toughest armour. ";}
			if (thawep="Hurricane Bolter Sponsons"){atta=405;arp=0;rang=12;amm=20;spli=1;
			    descr="Hurricane Bolters are large hex-mount bolter arrays that are able to deliver a withering hail of anti-infantry fire at short ranges. ";}
			if (thawep="Flamestorm Cannon Sponsons"){atta=600;arp=1;rang=3;amm=6;spli=1;
			    descr="A huge vehicle-mounted flamethrower, the heat produced by this terrifying weapon can crack even armoured ceramite. ";}
			if (thawep="Twin Linked Heavy Flamer Sponsons"){atta=550;arp=-1;rang=2.1;amm=12;spli=1;
			    descr="A much larger and bulkier flamer.  Few armies carry them on hand, instead choosing to mount them to vehicles.";}
			if (thawep="Twin Linked Multi-Melta Sponsons"){atta=450;arp=1;rang=4.1;amm=6;
			    descr="Though bearing longer range than the Meltagun, this weapon's great size usually restricts it to vehicles.";}
			if (thawep="Twin Linked Volkite Culverin Sponsons"){atta=480;arp=0;rang=18;amm=25;spli=1;
					descr="An advanced thermal weapon from a bygone era, Volkite Culverins are able to ignite entire formations of enemy forces. ";}


				// Predator Turrets
				if (thawep="Twin Linked Lascannon Turret"){atta=250;arp=1;rang=20;amm=10;
						descr="A Predator-compatible turret mounting a pair of anti-armour lascannons. ";}
				if (thawep="Autocannon Turret"){atta=130;arp=0;rang=18;amm=50;spli=1;
				    descr="A Predator-compatible turret mounting a reliable all-purpose autocannon. ";}
				if (thawep="Twin Linked Assault Cannon Turret"){atta=360;arp=0;rang=12;amm=10;spli=1;
				   	descr="A Predator-compatible turret mounting a pair of short range anti-infantry assault cannons. ";}
				if (thawep="Flamestorm Cannon Turret"){atta=400;arp=1;rang=2.1;amm=12;spli=1;
					  descr="A Predator-compatible turret housing a huge flamethrower, the heat produced by this terrifying weapon can crack even armoured ceramite. ";}
				if (thawep="Magna-Melta Turret"){atta=400;arp=1;rang=6;amm=12;
					  descr="A Predator-compatible turret housing a magna-melta, a devastating short-range anti-tank weapon. ";}
				if (thawep="Plasma Destroyer Turret"){atta=350;arp=1;rang=15;spli=1;
					  descr="A Predator-compatible turret housing a plasma destroyer, sometimes called the plasma executioner after the vehicle variants that mount this terrifying anti-armour weapon. ";}
				if (thawep="Heavy Conversion Beamer Turret"){atta=750;arp=1;rang=25;amm=3;spli=1;
				   	descr="A Predator-compatible turret housing a Heavy Conversion Beam Projector, a heavy energy weapon that turns a target's own matter against it by converting it into destructive energy.";}
				if (thawep="Neutron Blaster Turret"){atta=400;arp=1;rang=15;amm=10
					  descr="A Predator-compatible turret housing a neutron blaster; a weapon from the Dark Age of Technology, this weapon is capable of destroying enemy armour with impunity. ";}
				if (thawep="Volkite Saker Turret"){atta=400;arp=0;rang=18;amm=50;spli=1;
						descr="A Predator-compatible turret housing a Volkite Saker, capable of igniting entire formations of enemy forces with a single sweep. ";}

				// Predator Sponsons
				if (thawep="Lascannon Sponsons"){atta=250;arp=1;rang=20;amm=5;
		        descr="Lascannons are powerful anti-armour weapons that fire highly focused and devastating energy beams capable of penetrating even the toughest armour. ";}
				if (thawep="Heavy Bolter Sponsons"){atta=240;arp=0;rang=16;amm=20;spli=1;
				    descr="The Heavy Bolter is a heavy weapon that fires larger and more powerful bolt shells compared to the standard Bolter.";}
				if (thawep="Heavy Flamer Sponsons"){atta=375;arp=-1;rang=2.1;amm=6;spli=1;
				   	descr="A much larger and bulkier flamer. Few armies carry them on hand, instead choosing to mount them to vehicles. ";}
				if (thawep="Volkite Culverin Sponsons"){atta=320;arp=0;rang=18;amm=25;spli=1;
						descr="An advanced thermal weapon from a bygone era, Volkite Culverins are able to ignite entire formations of enemy forces. ";}


	    // STC Bonuses
	    if (obj_controller.stc_bonus[1]>0){
	        if (obj_controller.stc_bonus[1]=1){if (string_count("Bolt",thawep)>0){atta=round(atta*1.07);}}
	        if (obj_controller.stc_bonus[1]=2){if (string_count("Chain",thawep)>0){atta=round(atta*1.07);}}
	        if (obj_controller.stc_bonus[1]=3) and ((thawep="Flamer") or (thawep="Heavy Flamer")
	         or (thawep="Inferno Cannon") or (thawep="CCW Heavy Flamer")){atta=round(atta*1.1);}
	        if (obj_controller.stc_bonus[1]=4){if (thawep="Missile Launcher") or (thawep="Whirlwind Missiles"){atta=round(atta*1.1);}}
	        if (obj_controller.stc_bonus[1]=5) and (emor>0) and (statt>0){if (statt>=40) then statt+=2;if (statt<40) then statt+=1;}
	    }
	    if (obj_controller.stc_bonus[2]>0){
	        if (obj_controller.stc_bonus[2]=1){if (string_count("ist",thawep)>0){atta=round(atta*1.1);}}
	        if (obj_controller.stc_bonus[2]=2){if (string_count("Plasma",thawep)>0){atta=round(atta*1.1);}}
	        if (obj_controller.stc_bonus[2]=3) and (emor>0) and (statt>0){if (statt>=40) then statt+=2;if (statt<40) then statt+=1;}
	    }

	    if (argument2=false) and (obj_controller.stc_bonus[3]=2){
	        if (atta>0) then atta=round(atta*1.05);
	        // if (arp>0) then arp=round(arp*1.05);
	    }








	    if (argument6="description") or (argument6="description_long"){// was i=2
	        /*if (i=1){
	            disk1=descr;
	            atta1=atta;
	            arp1=arp;
	            rang1=rang;
	            ammo1=amm;
	            spli1=spli;
	            rending1=rending;
	            spe_descr1=spe_descr;
	        }

	        descr=disk1;
	        atta=att1;
	        arp=apa1;
	        rang=rang1;
	        amm=ammo1;
	        spli=spli1;
	        rending=rending1;
	        spe_descr=spe_descr1;*/



	        if (string_count("Bolter",thawep)>0) and (string_count("Drilling",obj_ini.strin)>0){
	            if (atta>0) then atta=round(atta*1.15);
	            // if (arp>0) then arp=round(arp*1.15);
	        }

	        if (instance_exists(obj_shop)){ scr_weapon_populate_shop(atta, arp, spli, ranged_hands, melee_hands, amm, rang, statt, spe_descr); }
			
	        if (!instance_exists(obj_shop)) and (!instance_exists(obj_ncombat)) and (((obj_controller.menu=1) and (obj_controller.managing>0)) or (obj_controller.menu=13)){
	            // 0.6
	            menu_artifact_type=4;

	            if (atta>0){
	                obj_controller.tooltip_stat1=atta;
	                obj_controller.tooltip_stat2=arp;
	                obj_controller.tooltip_stat3=max(ranged_hands,melee_hands);
	                obj_controller.tooltip_stat4=amm;

	                if (rang<=1.1){menu_artifact_type=1;
	                    obj_controller.tooltip_other="Melee";
	                    if (spli=1) then obj_controller.tooltip_other+=", Splash";
	                }
	                if (rang>1.1){menu_artifact_type=1;
	                    obj_controller.tooltip_other=string(round(rang))+" Range";
	                    if (spli=1) then obj_controller.tooltip_other+=", Rapid Fire";
	                }

	                if (arp=-1) then obj_controller.tooltip_other+=", Low Penetration";
	                if (arp=1) then obj_controller.tooltip_other+=", Armour Piercing";
	            }
	            if (atta=0) and (statt=0){// Held something
	                obj_controller.tooltip_other=spe_descr;
	                menu_artifact_type=3;
	                obj_controller.tooltip_stat1=0;
	                obj_controller.tooltip_stat2=0;
	                obj_controller.tooltip_stat3=max(ranged_hands,melee_hands);
	                obj_controller.tooltip_stat4=0;
	            }
	            if (atta=0) and (statt>0){// Armour
	                obj_controller.tooltip_stat1=statt;
	                obj_controller.tooltip_other=spe_descr;
	                menu_artifact_type=2;
	            }
	        }

	        // exit;exit;
	    }





	    if (argument6!="description") and (argument6!="description_long"){
	        if (argument2!=false){if (string_count("Dreadnought",marine_armour[argument3])>0) and (marine_mobi[argument3]="") then amm=-1;}
	        if (thawep="Whirlwind Missiles") then amm=6;

	        if (rending1=1){
	            var rend;rend=choose(1,2,3,4,5,6);
	            if (rend=6){
	                if (atta>0) then atta=atta*2;
	                // if (arm>0) then arp=arp*2;
	            }
	        }
	        if (rang1=1){
	            atta=atta*marine_attack[argument3];// arp=arp*marine_attack[argument3];
	            if (marine_might[argument3]>0){
	                atta=atta*2;// arp=arp*2;
	            }
	            if (marine_spatial[argument3]>0){
	                atta=atta*1.75;// arp=arp*1.75;
	            }
	            if (marine_fiery[argument3]>0){
	                atta=atta*1.3;// arp=arp*1.3;
	            }
	        }
	        if (rang1>1){
	            atta=atta*marine_ranged[argument3];
	            // arp=arp*marine_ranged[argument3];
	        }

	        if (obj_ncombat.bolter_drilling=1) and ((string_count("Bolt",thawep)>0) or (string_count("ombi",thawep)>0)){
	            atta=round(atta*1.15);// arp=round(arp*1.15)
	        }
	        if (obj_ncombat.melee=1) and (rang=1){
	            atta=round(atta*1.1);// arp=round(arp*1.1);
	        }
	        if (rang=1){
	            atta=round(atta*obj_ncombat.global_melee);
	            // arp=round(arp*obj_ncombat.global_melee);
	        }


	        if (argument2=true){
	            if (marine_exp[argument3]>30){
	                var ttt;ttt=marine_exp[argument3]-30;
	                ttt=(ttt*0.0014)+1;ttt=max(1,(min(ttt,1.5)));// was 1.25
	                if (ttt>=1) then atta=floor(atta*ttt);
	                // if (ttt>=1) then arp=floor(arp*ttt);
	                atta=atta*obj_ncombat.global_attack;
	                // arp=arp*obj_ncombat.global_attack;
	            }
	        }
	        if (argument2=false){
	            atta=atta*obj_ncombat.global_attack;
	            // arp=arp*obj_ncombat.global_attack;
	        }


	        if (ranged_hands>2) and (rang>1) and (argument2=true) and (argument4=false){
	            atta=atta*0.6;// arp=arp*0.6;
	        }
	        if (melee_hands>2) and (rang<=1) and (argument2=true) and (argument4=false){
	            atta=atta*0.6;// arp=arp*0.6;
	        }

	        if (i=1){att1=atta;apa1=arp;rang1=rang;ammo1=amm;spli1=spli;}
	        if (i=2){att2=atta;apa2=arp;rang2=rang;ammo2=amm;spli2=spli;}


	        // This is giving problems
	        if (melee_hands=0) and (argument2=true) and (argument4=false) and (i=2){
	            var atta;
	            atta=obj_ncombat.global_attack*10;
	            var b,goody,opn;b=0;goody=0;opn=0;
	            repeat(30){b+=1;
	                if (wep[b]="melee"){
	                    goody=b;att[b]+=atta;range[b]=1;wep_num[b]+=1;splash[b]=0;ammo[b]=-1;
	                }
	                if (wep[b]="") and (opn=0) then opn=b;
	                if (goody=0){
	                    wep[opn]="melee";att[opn]+=atta;range[opn]=1;wep_num[opn]=1;splash[opn]=0;ammo[opn]=-1;
	                }
	            }
	        }





	    }


	    obj_controller.temp[9000]+=string(thawep)+": "+string(melee_hands)+","+string(ranged_hands)+"|";
	}


	if(item != false && item.IsModified()) { item.Destroy(); }


	// End repeat(2)

	if (argument6="description") or (argument6="description_long"){
	    if ((!instance_exists(obj_shop)) and (!instance_exists(obj_ncombat)) and (obj_controller.menu=1) and (obj_controller.managing>0)) or (obj_controller.squads == true){
	        // obj_controller.temp[9000]="Melee Hands: "+string(melee_hands)+", Ranged Hands: "+string(ranged_hands);
	        var melee_limit = 2
	        var ranged_limit = 2
	        if(array_contains(["Terminator Armour", "Tartaros"], marine_armour[argument3])){
	        	melee_limit+=2;
	        	ranged_limit++;
	        } else if(obj_controller.squads == true){
	        	if(array_contains(["Terminator Armour", "Tartaros"], obj_controller.marine_armour[0])){
	        		melee_limit+=2;
	        		ranged_limit++;
	        	}	
	        }        
	        if (melee_hands<=2) or (argument4=true) then obj_controller.ui_melee_penalty=0;
	        if (ranged_hands<=2) or (argument4=true) then obj_controller.ui_ranged_penalty=0;
	        if (melee_hands>melee_limit) and (argument4=false) then obj_controller.ui_melee_penalty=1;
	        if (ranged_hands>ranged_limit) and (argument4=false) then obj_controller.ui_ranged_penalty=1;
	    }

	    if (argument6="description") then return(descr);
	    if (argument6="description_long") then return(descr2);
	}


	if (argument6!="description") and (argument6!="description_long"){
	    var b,goody,found,stack;b=0;goody=0;found=0;stack=1;

	    thawep=argument0;// 137 135 136 flip fix?


	    if (argument5!="") then stack=0;


	    repeat(60){b+=1;

	        // show_message(string(goody));

	        var canc;canc=false;
	        if (rang1>1) and (marine_ranged[argument3]=0){
	             canc=true;if (floor(rang1)==rang1) then canc=false
	        }if (canc=true) then goody=1;

	        if (goody=0){
	            if (stack=1) and (wep[b]=thawep) and (goody=0){
	                // if (thawep=wip1){
	                    att[b]+=att1;apa[b]=apa1;range[b]=rang1;wep_num[b]+=1;splash[b]=spli1;wep[b]=thawep;goody=1;
	                    // if (marine_type[argument3]="Death Company") and (range[b]=1){att[b]+=att1;wep_num[b]+=1;wep_rnum[b]+=1;}
	                    if (obj_ncombat.started=0) then ammo[b]=ammo1;
	                // }
	            }
	            if (stack=0) and (obj_ncombat.started=0) and (wep[b]="") and (goody=0) and (wep_solo[b]=""){
	                if (goody=0){
	                    att[b]+=att1;apa[b]=apa1;range[b]=rang1;wep_num[b]+=1;splash[b]=spli1;wep[b]=thawep;goody=1;
	                    // if (marine_type[argument3]="Death Company") and (range[b]=1){att[b]+=att1;wep_num[b]+=1;wep_rnum[b]+=1;}
	                    ammo[b]=ammo1;

	                    var title;title=true;
	                    if (marine_type[argument3]="Chapter Master") then title=false;
	                    if (marine_type[argument3]="Master of Sanctity") then title=false;
	                    if (marine_type[argument3]="Chief "+string(obj_ini.role[100,17])) then title=false;
	                    if (marine_type[argument3]="Forge Master") then title=false;
	                    if (marine_type[argument3]="Master of the Apothecarion") then title=false;
	                    if (title=true) then wep_title[b]=string(marine_type[argument3]);
	                    wep_solo[b]=string(obj_ini.name[marine_co[argument3],marine_id[argument3]]);
	                }
	            }

	            if (stack=0) and (obj_ncombat.started=1) and (wep[b]=thawep) and (wep_solo[b]=argument5) and (goody=0){
	                att[b]+=att1;apa[b]=apa1;range[b]=rang1;wep_num[b]+=1;splash[b]=spli1;wep[b]=thawep;goody=1;
	                // if (marine_type[argument3]="Death Company") and (range[b]=1){att[b]+=att1;wep_num[b]+=1;wep_rnum[b]+=1;}

	                var title;title=true;
	                if (marine_type[argument3]="Chapter Master") then title=false;
	                if (marine_type[argument3]="Master of Sanctity") then title=false;
	                if (marine_type[argument3]="Chief "+string(obj_ini.role[100,17])) then title=false;
	                if (marine_type[argument3]="Forge Master") then title=false;
	                if (marine_type[argument3]="Master of the Apothecarion") then title=false;
	                if (title=true) then wep_title[b]=string(marine_type[argument3]);
	                wep_solo[b]=string(obj_ini.name[marine_co[argument3],marine_id[argument3]]);
	            }
	        }
	    }

	    b=0;
	    if (stack=1) and (goody=0){
	        repeat(60){b+=1;
	            var canc;canc=false;
	            if (rang1>1) and (marine_ranged[argument3]=0){
	                 canc=true;if (floor(rang1)==rang1) then canc=false
	            }

	            if (wep[b]="") and (goody=0) and (canc=false){
	                // if (thawep=wip1){
	                    att[b]+=att1;apa[b]=apa1;range[b]=rang1;wep_num[b]+=1;splash[b]=spli1;wep[b]=thawep;goody=1;
	                    // if (marine_type[argument3]="Death Company") and (range[b]=1){att[b]+=att1;wep_num[b]+=1;wep_rnum[b]+=1;}
	                    if (obj_ncombat.started=0) then ammo[b]=ammo1;
	                // }
	            }
	        }
	    }


	}


}

function scr_is_for_first_loop(wrapped)
{
	Validate(1, wrapped, ItemWrapper, true);
	if(is_undefined(wrapped)) { return false; }
	
	if(wrapped.IsType(ITEM_TYPE_ARMOUR)) { return true; }
	if(wrapped.IsType(ITEM_TYPE_MISC)) { return true; }
	if(wrapped.IsType(ITEM_TYPE_NONE)) { return true; }
	if(wrapped.IsType(ITEM_TYPE_BACK)) { return true; }
	
	return false;
}

function scr_weapon_populate_shop(atta, arp, spli, ranged_hands, melee_hands, amm, rang, statt, spe_descr)
{
	if (!instance_exists(obj_shop)) { return; }
	
	if(atta == 0)
	{
		if(statt == 0) // Held something
		{
			obj_shop.tooltip_weapon=2;
			obj_shop.tooltip_other=spe_descr;
			
			return;
		}
		
		if(melee_hands + ranged_hands == 0) //Armour
		{
			obj_shop.tooltip_weapon=3;
			obj_shop.tooltip_stat1=statt;
			obj_shop.tooltip_other=spe_descr;
			
			return;
		}
		
		return;
	}
	
	//if(atta > 0)	//Weapon
	obj_shop.tooltip_weapon=1;
	obj_shop.tooltip_stat1=atta;
	obj_shop.tooltip_stat2=arp;
	obj_shop.tooltip_stat3=max(ranged_hands,melee_hands);
	obj_shop.tooltip_stat4=amm;
	
	if (rang<=1.1)
	{
	    obj_shop.tooltip_other="Melee";
	    if (spli=1) then obj_shop.tooltip_other+=", Splash";
	}
	
	if (rang>1.1)
	{
	    obj_shop.tooltip_other=string(round(rang))+" Range";
	    if (spli=1) then obj_shop.tooltip_other+=", Rapid Fire";
	}
	
	if (arp=-1) then obj_shop.tooltip_other+=", Low Penetration";
	if (arp=1) then obj_shop.tooltip_other+=", Armour Piercing";	        
}
