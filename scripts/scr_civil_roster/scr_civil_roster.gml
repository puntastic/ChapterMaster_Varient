function scr_civil_roster(_unit_location, _target_location, _is_planet) {

	// Determines who all will be present for the battle
	// Only used on the Chaos Space Marines(?) meeting battle (not sure if its implemented)

	// argument 0 : planet or ship name
	// argument 1 : world number (wid)
	// argument 2 : is it a planet?  boolean

	//--------------------------------------------------------------------------------------------------------------------
	// Global objects used.
	//--------------------------------------------------------------------------------------------------------------------
	deploying_unit=obj_ini;
	new_combat=obj_ncombat;
	//???=obj_drop_select;
	//???=obj_controller
	//???=obj_pnunit
	//???=obj_enunit
	//???=obj_centerline
	//--------------------------------------------------------------------------------------------------------------------

	var stop,okay,sofar;
	stop=0;okay=0;sofar=0;

	// Formation here
	
	obj_controller.bat_devastator_column=obj_controller.bat_deva_for[new_combat.formation_set];
	obj_controller.bat_assault_column=obj_controller.bat_assa_for[new_combat.formation_set];
	obj_controller.bat_tactical_column=obj_controller.bat_tact_for[new_combat.formation_set];
	obj_controller.bat_veteran_column=obj_controller.bat_vete_for[new_combat.formation_set];
	obj_controller.bat_hire_column=obj_controller.bat_hire_for[new_combat.formation_set];
	obj_controller.bat_librarian_column=obj_controller.bat_libr_for[new_combat.formation_set];
	obj_controller.bat_command_column=obj_controller.bat_comm_for[new_combat.formation_set];
	obj_controller.bat_techmarine_column=obj_controller.bat_tech_for[new_combat.formation_set];
	obj_controller.bat_terminator_column=obj_controller.bat_term_for[new_combat.formation_set];
	obj_controller.bat_honor_column=obj_controller.bat_hono_for[new_combat.formation_set];
	obj_controller.bat_dreadnought_column=obj_controller.bat_drea_for[new_combat.formation_set];
	obj_controller.bat_rhino_column=obj_controller.bat_rhin_for[new_combat.formation_set];
	obj_controller.bat_predator_column=obj_controller.bat_pred_for[new_combat.formation_set];
	obj_controller.bat_landraider_column=obj_controller.bat_land_for[new_combat.formation_set];
	obj_controller.bat_scout_column=obj_controller.bat_scou_for[new_combat.formation_set];

	var co, v, meeting, he_good;
	co=0;v=0;meeting=true;he_good=false;

	instance_activate_object(obj_pnunit);
	instance_activate_object(obj_enunit);
	instance_activate_object(obj_centerline);

	if (new_combat.enemy=1){
	    var i,u;i=11;
	    repeat(10){i-=1;// This creates the objects to then be filled in
	        u=instance_create(110+(i*10),240,obj_enunit);
	    }
	}

	instance_activate_object(obj_enunit);

	repeat(300){v+=1;he_good=0;

	    if (instance_exists(obj_temp_meeting)){
	        if (v>obj_temp_meeting.dudes) then stop=1;
	    }
    
	    if (stop=0){
	        if (!instance_exists(obj_drop_select)) and (instance_exists(obj_temp_meeting)){meeting=true;
	            if (co=0) and (v<=obj_temp_meeting.dudes){
	                if (obj_temp_meeting.present[v]=1){
	                    okay=1;
	                }
	            }
	            if (co>0) then okay=0;
	            if (v>obj_temp_meeting.dudes) then okay=0;
	        }
        
	        if (okay>=1){
	            var cooh,va;
	            cooh=0;va=0;
            
	            if (meeting=false){cooh=co;va=v;}
	            if (meeting=true){if (v<=obj_temp_meeting.dudes){
	                cooh=obj_temp_meeting.co[v];
	                va=obj_temp_meeting.ide[v];
	            }}
            
            
            
            
	            // Chaos corruption check here
	            if (new_combat.battle_special="cs_meeting_battle1"){
	                if (deploying_unit.chaos[cooh,va]>=30) then new_combat.fighting[cooh,va]=1;
	                if (deploying_unit.chaos[cooh,va]<30) then new_combat.fighting[cooh,va]=-5;
	                if (deploying_unit.role[cooh,va]="Master of Sanctity") then new_combat.fighting[cooh,va]=-5;
	            }
	            if (new_combat.battle_special="cs_meeting_battle2"){
	                if (deploying_unit.chaos[cooh,va]>=3) then new_combat.fighting[cooh,va]=0;
	                if (deploying_unit.chaos[cooh,va]<3) then new_combat.fighting[cooh,va]=-5;
	                if (deploying_unit.role[cooh,va]="Master of Sanctity") then new_combat.fighting[cooh,va]=-5;
	            }
	            if (new_combat.battle_special="cs_meeting_battle5") then new_combat.fighting[cooh,va]=1;
	            if (new_combat.battle_special="cs_meeting_battle6") then new_combat.fighting[cooh,va]=1;
	            if (new_combat.battle_special="cs_meeting_battle7"){
	                if (deploying_unit.role[cooh,va]!="Chapter Master") then new_combat.fighting[cooh,va]=-5;
	            }
            
	            if (deploying_unit.role[cooh,va]="Chapter Master") then new_combat.fighting[cooh,va]=1;
	            if (new_combat.fighting[cooh,va]=1) then he_good=1;
	            if (new_combat.fighting[cooh,va]=-5) then he_good=-1;
            
            
	            if (he_good=-1){
            
	                // show_message("enemy marine found");
            
	                var col,moov,targ;col=0;targ=0;moov=0;
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][12]){col=22-obj_controller.bat_scout_column;new_combat.en_scouts+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][8]){col=22-obj_controller.bat_tactical_column;new_combat.en_tacticals+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][3]){col=22-obj_controller.bat_veteran_column;new_combat.en_veterans+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][9]){col=22-obj_controller.bat_devastator_column;new_combat.en_devastators+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][10]){col=22-obj_controller.bat_assault_column;new_combat.en_assaults+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100,17]){col=22-obj_controller.bat_librarian_column;new_combat.en_librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100,17])+" Aspirant"){col=22-obj_controller.bat_librarian_column;new_combat.en_librarians+=1;moov=1;}
                
	                if (deploying_unit.role[cooh,va]="Codiciery"){col=22-obj_controller.bat_librarian_column;new_combat.en_librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]="Epistolary"){col=22-obj_controller.bat_librarian_column;new_combat.en_librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]="Lexicanum"){col=22-obj_controller.bat_librarian_column;new_combat.en_librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][16]){col=22-obj_controller.bat_techmarine_column;new_combat.en_techmarines+=1;moov=2;}
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][2]){col=22-obj_controller.bat_honor_column;new_combat.en_honors+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][6]){col=22-obj_controller.bat_dreadnought_column;new_combat.en_dreadnoughts+=1;}
	                if (deploying_unit.role[cooh,va]="Venerable "+string(deploying_unit.role[100][6])){col=22-obj_controller.bat_dreadnought_column;new_combat.en_dreadnoughts+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][4]){col=22-obj_controller.bat_terminator_column;new_combat.en_terminators+=1;}
                
	                if (moov>0){
	                    if ((moov=1) and (obj_controller.command_set[8]=1)) or ((moov=2) and (obj_controller.command_set[9]=1)){
	                        if (co>=2) then col=22-obj_controller.bat_tactical_column;
	                        if (co=10) then col=22-obj_controller.bat_scout_column;
	                        if (deploying_unit.mobi[cooh,va]="Jump Pack") then col=22-obj_controller.bat_assault_column;
	                    }
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][15]) or (deploying_unit.role[cooh,va]=deploying_unit.role[100][14]) or (string_count("Aspirant",deploying_unit.role[cooh,va])>0){
	                    if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100][15])+" Aspirant"){col=22-obj_controller.bat_tactical_column;new_combat.en_tacticals+=1;}
	                    if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100][14])+" Aspirant"){col=22-obj_controller.bat_tactical_column;new_combat.en_tacticals+=1;}
                
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][15]) then new_combat.en_apothecaries+=1;
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][14]){new_combat.en_chaplains+=1;if (new_combat.en_big_mofo>5) then new_combat.en_big_mofo=5;}
                    
	                    col=22-obj_controller.bat_tactical_column;

	                    if (obj_ini.armour[cooh,va]="Terminator Armour") then col=22-obj_controller.bat_terminator_column;
	                    if (obj_ini.armour[cooh,va]="Tartaros Armour") then col=22-obj_controller.bat_terminator_column;

	                    if (co=10) then col=22-obj_controller.bat_scout_column;
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][5]) or (deploying_unit.role[cooh,va]="Standard Bearer") or (deploying_unit.role[cooh,va]=deploying_unit.role[100][7]){
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][5]){new_combat.en_captains+=1;if (new_combat.en_big_mofo>5) then new_combat.en_big_mofo=5;}
	                    if (deploying_unit.role[cooh,va]="Standard Bearer") then new_combat.en_standard_bearers+=1;
						if (deploying_unit.role[cooh,va]=deploying_unit.role[100][7]) then new_combat.champions+=1;
                    
	                    if (co=1){
	                        col=22-obj_controller.bat_veteran_column;

	                        if (obj_ini.armour[cooh,va]="Terminator Armour") then col=22-obj_controller.bat_terminator_column;
	                        if (obj_ini.armour[cooh,va]="Tartaros Armour") then col=22-obj_controller.bat_terminator_column;

	                    }
	                    if (co>=2) then col=22-obj_controller.bat_tactical_column;
	                    if (co=10) then col=22-obj_controller.bat_scout_column;
	                    if (deploying_unit.mobi[cooh,va]="Jump Pack") then col=22-obj_controller.bat_assault_column;
	                }
                
	                if (deploying_unit.role[cooh,va]="Forge Master"){col=22-obj_controller.bat_command_column;new_combat.en_important_dudes+=1;}
	                if (deploying_unit.role[cooh,va]="Master of Sanctity"){col=22-obj_controller.bat_command_column;new_combat.en_important_dudes+=1;if (new_combat.en_big_mofo>2) then new_combat.en_big_mofo=2;}
	                if (deploying_unit.role[cooh,va]="Master of the Apothecarion"){col=22-obj_controller.bat_command_column;new_combat.en_important_dudes+=1;}
	                if (deploying_unit.role[cooh,va]="Chief "+string(deploying_unit.role[100,17])){col=22-obj_controller.bat_command_column;new_combat.en_important_dudes+=1;if (new_combat.en_big_mofo>3) then new_combat.en_big_mofo=3;}
                
	                if (col=0) then col=22-obj_controller.bat_hire_column;
                
                
	                // show_message("enemy marine being placed in column "+string(col));
                
	                targ=instance_nearest(col*10,240,obj_enunit);
                
	                var t,first_openz;
	                t=0;first_openz=0;
	                repeat(700){t+=1;
	                    if (first_openz=0){
	                        if (targ.dudes[t]="") and (first_openz=0) then first_openz=t;
	                    }
	                }
                
	                targ.men+=1;
	                targ.dude_co[targ.men]=cooh;
	                targ.dude_id[targ.men]=va;
	                targ.dudes[targ.men]=deploying_unit.role[cooh,va];
	                targ.dudes_num[targ.men]=1;
	                targ.dudes_hp[targ.men]=deploying_unit.hp[cooh,va];
	                targ.dudes_exp[targ.men]=deploying_unit.experience[cooh,va];
	                targ.dudes_powers[targ.men]=deploying_unit.spe[cooh,va];
	                targ.dudes_wep1[targ.men]=deploying_unit.wep1[cooh,va];
	                targ.dudes_wep2[targ.men]=deploying_unit.wep2[cooh,va];
	                targ.dudes_gear[targ.men]=deploying_unit.gear[cooh,va];
	                targ.dudes_mobi[targ.men]=deploying_unit.mobi[cooh,va];
                
	                new_combat.enemy_forces+=1;
	                new_combat.enemy_max+=1;
                
	                var dr;dr=0;
	                dr=0.7-((targ.dudes_exp[targ.men]*targ.dudes_exp[targ.men])/40000);
	                if (targ.dudes_gear[targ.men]="Rosarius") then dr-=0.33;
	                if (targ.dudes_gear[targ.men]="Iron Halo") then dr-=0.33;
	                if (targ.dudes_mobi[targ.men]="Jump Pack") then dr-=0.1;
	                if (dr<0.25) then dr=0.25;
	                targ.dudes_dr[targ.men]=dr;
                
	                if (deploying_unit.role[cooh,va]="Death Company"){// Ahahahahah
	                    var really;really=false;

	                    if (string_count("Dreadnought",obj_ini.armour[co][v])>0) then really=true;
	                    col=min(22-obj_controller.bat_assault_column,22-obj_controller.bat_command_column,22-obj_controller.bat_honor_column,22-obj_controller.bat_dreadnought_column,22-obj_controller.bat_veteran_column);
	                }
                
					// todo find out what more targ.dudes does, relevant to targ.men?
	                if (deploying_unit.armour[co][v]="Scout Armour") then targ.dudes_ac[targ.men]=8;
	                if (deploying_unit.armour[co][v]="MK3 Iron Armour"){targ.dudes_ac[targ.men]=20;targ.dudes_ranged[targ.men]-=0.1;}
	                if (deploying_unit.armour[co][v]="MK4 Maximus"){targ.dudes_ac[targ.men]=19;targ.dudes_ranged[targ.men]+=0.05;targ.dudes_attack[targ.men]+=0.05;}
                  if (deploying_unit.armour[co][v]="MK5 Heresy"){targ.dudes_ac[targ.men]=17;targ.dudes_attack[targ.men]+=0.1;targ.marine_ranged[targ.men]-=0.05;}
	                if (deploying_unit.armour[co][v]="MK6 Corvus"){targ.dudes_ac[targ.men]=18;targ.dudes_ranged[targ.men]+=0.1;}
	                if (deploying_unit.armour[co][v]="MK7 Aquila") then targ.dudes_ac[targ.men]=18;
	                if (deploying_unit.armour[co][v]="MK8 Errant") then targ.dudes_ac[targ.men]=19;
	                if (deploying_unit.armour[co][v]="Power Armour") then targ.dudes_ac[targ.men]=19;
	                if (deploying_unit.armour[co][v]="Artificer Armour"){targ.dudes_ac[targ.men]=35;targ.dudes_attack[targ.men]+=0.1;}
	                if (deploying_unit.armour[co][v]="Terminator Armour"){targ.dudes_ac[targ.men]=40;targ.dudes_ranged[targ.men]-=0.1;targ.dudes_attack[targ.men]+=0.2;}
	                if (deploying_unit.armour[co][v]="Tartaros"){targ.dudes_ac[targ.men]=44;targ.dudes_ranged[targ.men]-=0.05;targ.dudes_attack[targ.men]+=0.2;}
	                if (deploying_unit.armour[co][v]="Dreadnought") then targ.dudes_ac[targ.men]=40;
	                if (deploying_unit.armour[co][v]="Ork Armour") then targ.dudes_ac[targ.men]=15;
                
	                if (deploying_unit.wep1[co][v]="Boarding Shield") then targ.dudes_ac[targ.men]+=4;
	                if (deploying_unit.wep2[co][v]="Boarding Shield") then targ.dudes_ac[targ.men]+=4;
	                if (deploying_unit.wep1[co][v]="Storm Shield") then targ.dudes_ac[targ.men]+=8;
	                if (deploying_unit.wep2[co][v]="Storm Shield") then targ.dudes_ac[targ.men]+=8;
                
	                if (string_count("&",deploying_unit.armour[co][v])>0){
	                    // Artifact armour
	                    if (string_count("Power",deploying_unit.armour[co][v])>0) then targ.dudes_ac[targ.men]=30;
	                    if (string_count("Artificer",deploying_unit.armour[co][v])>0){targ.dudes_ac[targ.men]=37;targ.dudes_attack[targ.men]+=0.1;}
	                    if (string_count("Terminator",deploying_unit.armour[co][v])>0){targ.dudes_ac[targ.men]=46;targ.dudes_ranged[targ.men]-=0.1;targ.dudes_attack[targ.men]+=0.2;}
	                    if (string_count("Dreadnought",deploying_unit.armour[co][v])>0) then targ.dudes_ac[targ.men]=44;
	                }
	                if (obj_ini.armour[co][v]!=""){// STC Bonuses

	                    if (obj_controller.stc_bonus[1]=5){if (targ.dudes_ac[targ.men]>=40) then targ.dudes_ac[targ.men]+=2;if (targ.dudes_ac[targ.men]<40) then targ.dudes_ac[targ.men]+=1;}
	                    if (obj_controller.stc_bonus[2]=3){if (targ.dudes_ac[targ.men]>=40) then targ.dudes_ac[targ.men]+=2;if (targ.dudes_ac[targ.men]<40) then targ.dudes_ac[targ.men]+=1;}
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][6]) or (deploying_unit.role[cooh,va]="Venerable "+string(deploying_unit.role[100][6])){
	                    targ.dudes_hp[targ.men]=targ.dudes_hp[targ.men]*2;targ.dreads+=1;
	                }
	                if (deploying_unit.mobi[cooh,va]="Bike") then targ.dudes_hp[targ.men]+=25;
	                if (deploying_unit.wep1[cooh,va]="Boarding Shield") then targ.dudes_hp[targ.men]+=20;
	                if (deploying_unit.wep2[cooh,va]="Boarding Shield") then targ.dudes_hp[targ.men]+=20;
	                if (deploying_unit.wep1[cooh,va]="Storm Shield") then targ.dudes_hp[targ.men]+=30;
	                if (deploying_unit.wep2[cooh,va]="Storm Shield") then targ.dudes_hp[targ.men]+=30;
	                if (deploying_unit.wep2[cooh,va]="Iron Halo") then targ.dudes_hp[targ.men]+=20;
                
                
	                // show_message("target block now has "+string(targ.men)+" men, dudes1:"+string(targ.dudes[1]));
	            }
            
	            if (he_good=1){sofar+=1;
	                var col,moov,targ;col=0;targ=0;moov=0;
                
	                if (new_combat.battle_special="space_hulk") then new_combat.player_starting_dudes+=1;
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][12]){col=obj_controller.bat_scout_column;new_combat.scouts+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][8]){col=obj_controller.bat_tactical_column;new_combat.tacticals+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][3]){col=obj_controller.bat_veteran_column;new_combat.veterans+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][9]){col=obj_controller.bat_devastator_column;new_combat.devastators+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][10]){col=obj_controller.bat_assault_column;new_combat.assaults+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100,17]){col=obj_controller.bat_librarian_column;new_combat.librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100,17])+" Aspirant"){col=obj_controller.bat_librarian_column;new_combat.librarians+=1;moov=1;}
                
	                if (deploying_unit.role[cooh,va]="Codiciery"){col=obj_controller.bat_librarian_column;new_combat.librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]="Epistolary"){col=obj_controller.bat_librarian_column;new_combat.librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]="Lexicanum"){col=obj_controller.bat_librarian_column;new_combat.librarians+=1;moov=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][16]){col=obj_controller.bat_techmarine_column;new_combat.techmarines+=1;moov=2;}
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][2]){col=obj_controller.bat_honor_column;new_combat.honors+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][6]){col=obj_controller.bat_dreadnought_column;new_combat.dreadnoughts+=1;}
	                if (deploying_unit.role[cooh,va]="Venerable "+string(deploying_unit.role[100][6])){col=obj_controller.bat_dreadnought_column;new_combat.dreadnoughts+=1;}
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][4]){col=obj_controller.bat_terminator_column;new_combat.terminators+=1;}
                
	                if (moov>0){
	                    if ((moov=1) and (obj_controller.command_set[8]=1)) or ((moov=2) and (obj_controller.command_set[9]=1)){
	                        if (co>=2) then col=obj_controller.bat_tactical_column;
	                        if (co=10) then col=obj_controller.bat_scout_column;
	                        if (deploying_unit.mobi[cooh,va]="Jump Pack") then col=obj_controller.bat_assault_column;
	                    }
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][15]) or (deploying_unit.role[cooh,va]=deploying_unit.role[100][14]) or (string_count("Aspirant",deploying_unit.role[cooh,va])>0){
	                    if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100][15])+" Aspirant"){col=obj_controller.bat_tactical_column;new_combat.tacticals+=1;}
	                    if (deploying_unit.role[cooh,va]=string(deploying_unit.role[100][14])+" Aspirant"){col=obj_controller.bat_tactical_column;new_combat.tacticals+=1;}
                
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][15]) then new_combat.apothecaries+=1;
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][14]){new_combat.chaplains+=1;if (new_combat.big_mofo>5) then new_combat.big_mofo=5;}
                    
	                    col=obj_controller.bat_tactical_column;

	                    if (obj_ini.armour[cooh,va]="Terminator Armour") then col=obj_controller.bat_terminator_column;
	                    if (obj_ini.armour[cooh,va]="Tartaros Armour") then col=obj_controller.bat_terminator_column;

	                    if (co=10) then col=obj_controller.bat_scout_column;
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][5]) or (deploying_unit.role[cooh,va]="Standard Bearer") or (deploying_unit.role[cooh,va]=deploying_unit.role[100][7]){
	                    if (deploying_unit.role[cooh,va]=deploying_unit.role[100][5]){new_combat.captains+=1;if (new_combat.big_mofo>5) then new_combat.big_mofo=5;}
	                    if (deploying_unit.role[cooh,va]="Standard Bearer") then new_combat.standard_bearers+=1;
						if (deploying_unit.role[cooh,va]=deploying_unit.role[100][7]) then new_combat.champions+=1;
                    
	                    if (co=1){
	                        col=obj_controller.bat_veteran_column;

	                        if (obj_ini.armour[cooh,va]="Terminator Armour") then col=obj_controller.bat_terminator_column;
	                        if (obj_ini.armour[cooh,va]="Tartaros Armour") then col=obj_controller.bat_terminator_column;

	                    }
	                    if (co>=2) then col=obj_controller.bat_tactical_column;
	                    if (co=10) then col=obj_controller.bat_scout_column;
	                    if (deploying_unit.mobi[cooh,va]="Jump Pack") then col=obj_controller.bat_assault_column;
	                }
                
	                if (deploying_unit.role[cooh,va]="Chapter Master"){
	                    col=obj_controller.bat_command_column;new_combat.important_dudes+=1;new_combat.big_mofo=1;
	                    if (string_count("0",deploying_unit.spe[cooh,va])>0) then new_combat.chapter_master_psyker=1;
	                    else{new_combat.chapter_master_psyker=0;}
	                }
	                if (deploying_unit.role[cooh,va]="Forge Master"){col=obj_controller.bat_command_column;new_combat.important_dudes+=1;}
	                if (deploying_unit.role[cooh,va]="Master of Sanctity"){col=obj_controller.bat_command_column;new_combat.important_dudes+=1;if (new_combat.big_mofo>2) then new_combat.big_mofo=2;}
	                if (deploying_unit.role[cooh,va]="Master of the Apothecarion"){col=obj_controller.bat_command_column;new_combat.important_dudes+=1;}
	                if (deploying_unit.role[cooh,va]="Chief "+string(deploying_unit.role[100,17])){col=obj_controller.bat_command_column;new_combat.important_dudes+=1;if (new_combat.big_mofo>3) then new_combat.big_mofo=3;}
                
	                if (col=0) then col=obj_controller.bat_hire_column;
                
	                targ=instance_nearest(col*10,240,obj_pnunit);
	                targ.men+=1;
	                targ.marine_co[targ.men]=co;
	                targ.marine_id[targ.men]=v;

	                targ.marine_type[targ.men]=obj_ini.role[cooh,va];
	                targ.marine_wep1[targ.men]=obj_ini.wep1[cooh,va];
	                targ.marine_wep2[targ.men]=obj_ini.wep2[cooh,va];
	                targ.marine_armour[targ.men]=obj_ini.armour[cooh,va];
	                targ.marine_gear[targ.men]=obj_ini.gear[cooh,va];
	                targ.marine_mobi[targ.men]=obj_ini.mobi[cooh,va];
	                targ.marine_hp[targ.men]=obj_ini.hp[cooh,va];
	                targ.marine_exp[targ.men]=obj_ini.experience[cooh,va];
	                targ.marine_powers[targ.men]=obj_ini.spe[cooh,va];

	                if (okay=2) then targ.marine_local[targ.men]=1;
                
                
	                if (deploying_unit.role[cooh,va]="Death Company"){// Ahahahahah
	                    var really;really=false;

	                    if (string_count("Dreadnought",targ.marine_armour[targ.men])>0) then really=true;
	                    if (really=false) then obj_ncombat.thirsty+=1;if (really=true) then obj_ncombat.really_thirsty+=1;

	                    col=max(obj_controller.bat_assault_column,obj_controller.bat_command_column,obj_controller.bat_honor_column,obj_controller.bat_dreadnought_column,obj_controller.bat_veteran_column);
	                }
                

	                if (targ.marine_armour[targ.men]="Scout Armour") then targ.marine_ac[targ.men]=8;
	                if (targ.marine_armour[targ.men]="MK3 Iron Armour"){targ.marine_ac[targ.men]=20;targ.marine_ranged[targ.men]-=0.1;}
	                if (targ.marine_armour[targ.men]="MK4 Maximus"){targ.marine_ac[targ.men]=19;targ.marine_ranged[targ.men]+=0.05;targ.marine_attack[targ.men]+=0.05;}
                        if (targ.marine_armour[targ.men]="MK5 Heresy"){targ.marine_ac[targ.men]=17;targ.marine_attack[targ.men]+=0.1;targ.marine_ranged[targ.men]-=0.05;}
	                if (targ.marine_armour[targ.men]="MK6 Corvus"){targ.marine_ac[targ.men]=18;targ.marine_ranged[targ.men]+=0.1;}
	                if (targ.marine_armour[targ.men]="MK7 Aquila") then targ.marine_ac[targ.men]=18;
	                if (targ.marine_armour[targ.men]="MK8 Errant") then targ.marine_ac[targ.men]=19;
	                if (targ.marine_armour[targ.men]="Power Armour") then targ.marine_ac[targ.men]=19;
	                if (targ.marine_armour[targ.men]="Artificer Armour"){targ.marine_ac[targ.men]=35;targ.marine_attack[targ.men]+=0.1;}
	                if (targ.marine_armour[targ.men]="Terminator Armour"){targ.marine_ac[targ.men]=40;targ.marine_ranged[targ.men]-=0.1;targ.marine_attack[targ.men]+=0.2;}
	                if (targ.marine_armour[targ.men]="Tartaros"){targ.marine_ac[targ.men]=44;targ.marine_ranged[targ.men]-=0.05;targ.marine_attack[targ.men]+=0.2;}
	                if (targ.marine_armour[targ.men]="Dreadnought") then targ.marine_ac[targ.men]=40;
	                if (targ.marine_armour[targ.men]="Ork Armour") then targ.marine_ac[targ.men]=15;
                
	                if (deploying_unit.role[cooh,va]="Chapter Master"){
	                    if (deploying_unit.adv[1]="Paragon") or (deploying_unit.adv[2]="Paragon") or (deploying_unit.adv[3]="Paragon") or (deploying_unit.adv[4]="Paragon"){
	                        targ.marine_attack[targ.men]+=0.2;targ.marine_ranged[targ.men]+=0.2;
	                    }
	                }
                
                
	                // marine_attack[i]=1;
	                // marine_ranged[i]=1;
	                // marine_defense[i]=1;
                
	                if (targ.marine_wep1[targ.men]="Boarding Shield") then targ.marine_ac[targ.men]+=4;
	                if (targ.marine_wep2[targ.men]="Boarding Shield") then targ.marine_ac[targ.men]+=4;
	                if (targ.marine_wep1[targ.men]="Storm Shield") then targ.marine_ac[targ.men]+=8;
	                if (targ.marine_wep2[targ.men]="Storm Shield") then targ.marine_ac[targ.men]+=8;
                
                
	                if (string_count("&",targ.marine_armour[targ.men])>0){
	                    // Artifact armour
	                    if (string_count("Power",targ.marine_armour[targ.men])>0) then targ.marine_ac[targ.men]=30;
	                    if (string_count("Artificer",targ.marine_armour[targ.men])>0){targ.marine_ac[targ.men]=37;targ.marine_attack[targ.men]+=0.1;}
	                    if (string_count("Terminator",targ.marine_armour[targ.men])>0){targ.marine_ac[targ.men]=46;targ.marine_ranged[targ.men]-=0.1;targ.marine_attack[targ.men]+=0.2;}
	                    if (string_count("Dreadnought",targ.marine_armour[targ.men])>0) then targ.marine_ac[targ.men]=44;
	                }
	                if (targ.marine_armour[targ.men]!=""){// STC Bonuses
	                    if (obj_controller.stc_bonus[1]=5){if (targ.marine_ac[targ.men]>=40) then targ.marine_ac[targ.men]+=2;if (targ.marine_ac[targ.men]<40) then targ.marine_ac[targ.men]+=1;}
	                    if (obj_controller.stc_bonus[2]=3){if (targ.marine_ac[targ.men]>=40) then targ.marine_ac[targ.men]+=2;if (targ.marine_ac[targ.men]<40) then targ.marine_ac[targ.men]+=1;}
	                }
                
	                if (deploying_unit.role[cooh,va]=deploying_unit.role[100][6]) or (deploying_unit.role[cooh,va]="Venerable "+string(deploying_unit.role[100][6])){
	                    targ.marine_hp[targ.men]=targ.marine_hp[targ.men]*2;targ.dreads+=1;
	                }
	                if (deploying_unit.mobi[cooh,va]="Bike") then targ.marine_hp[targ.men]+=25;
	                if (deploying_unit.wep1[cooh,va]="Boarding Shield") then targ.marine_hp[targ.men]+=20;
	                if (deploying_unit.wep2[cooh,va]="Boarding Shield") then targ.marine_hp[targ.men]+=20;
	                if (deploying_unit.wep1[cooh,va]="Storm Shield") then targ.marine_hp[targ.men]+=30;
	                if (deploying_unit.wep2[cooh,va]="Storm Shield") then targ.marine_hp[targ.men]+=30;
	                if (deploying_unit.wep2[cooh,va]="Iron Halo") then targ.marine_hp[targ.men]+=20;
	            }
	        }
	    }
	}



	instance_activate_object(obj_enunit);
	if (instance_exists(obj_enunit)) and (instance_exists(obj_pnunit)){
	    var leftest_en,rightest_pla;
	    leftest_en=instance_nearest(0,240,obj_enunit);
	    rightest_pla=instance_nearest(5000,240,obj_pnunit);
	    repeat(30){
	        if (leftest_en.x>rightest_pla.x+10){
	            with(obj_enunit){x-=10;}
	        }
	    }
	}
	if (_is_planet=1){
	    // Small chance of ship going critical if loyalists are loosing
	    // Boosted chance if shitty luck
	}
}
