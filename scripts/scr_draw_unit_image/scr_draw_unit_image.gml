
function scr_draw_unit_image(x_draw, y_draw,unit){
	var xx=__view_get( e__VW.XView, 0 )+0, yy=__view_get( e__VW.YView, 0 )+0, bb="", img=0;
    if (unit.name_role()!="") and (unit.race()=="1"){
		var ui_left_Arm=true;
		var ui_right_arm=true;
		
        var x_pos_mod=0;
		var x_pos_mod_2=0;
		
        var y_pos_mod=0;
		var y_pos_mod_@=0;
		
        var ui_weapon_1=spr_weapon_blank;
		var ui_weapon_2=spr_weapon_blank;
		
        var draw_back_pack=true;
		var force_both_weapons=false;
		
		var specialist_colours=obj_ini.col_special;
    
        var terg=0,armour_sprite=spr_weapon_blank,show1,show2;
        var jump=0,dev=0,hood=0,skull=0,arm=0,halo=0,braz=0,slow=0,brothers=-5,body_part;
    
        var show_wep1,show_wep2,show_arm,show_gear,show_mobi;
        /*show_wep1=string_pos("&",unit.weapon_one());
        show_wep2=string_pos("&",unit.weapon_two());
        show_arm=string_pos("&",unit.armour());
        show_gear=string_pos("&",unit.gear());
        show_mobi=string_pos("&",unit.mobility_item());*/
		
        show_wep1=string_replace(unit.weapon_one(),"Arti. ","");
        show_wep2=string_replace(unit.weapon_two(),"Arti. ","");
        show_arm=string_replace(unit.armour(),"Arti. ","");
        show_gear=string_replace(unit.gear(),"Arti. ","");
        show_mobi=string_replace(unit.mobility_item(),"Arti. ","");
    
        if (ui_specialist=7) or (ui_specialist=1) or (ui_specialist=111){
			for(var o=1; o<=4; o++){if (obj_ini.adv[o]="Reverent Guardians") then braz=1;}}
        if (show_gear="Psychic Hood") then hood=-50;
    
        if (show_gear="Iron Halo") then halo=1;
    
        if (ui_specialist=1) and (global.chapter_name!="Iron Hands") then skull=-50;
    
        if (show_gear="Servo Arms") or (show_gear="Master Servo Arms"){
            var mas;
            // mas=string_count("Master",unit.gear());
            if (show_gear="Servo Arms") then mas=0;
            if (show_gear="Master Servo Arms") then mas=1;
        
            if (mas=0){
                if (specialist_colours=0) or (specialist_colours>1) then arm=1;
                if (specialist_colours=1) then arm=0;
            }
            if (mas>0){
            	switch(specialist_colours){
            		case 0:
            			arm=10;
            			break;
            		case 1:
            			arm=11;
            			break;
            		case 2:
            			arm=12;
            			break;	                				                			
            	}
            }
        }
    
        // if (terg>0) then draw_back_pack=false;
    
        if (show_mobi="Jump Pack"){
			draw_back_pack=false;
			jump=1;
		}
		
        if (unit.role()==obj_ini.role[100,9]){
			draw_back_pack=false;
			dev=1;
		}
		
        if (show_arm="Terminator Armour"){
			draw_back_pack=false;
			terg=1;
		}else if (show_arm="Tartaros"){
			draw_back_pack=false;
			terg=2;
		}else if (show_arm="Dreadnought"){
			draw_back_pack=false;
			terg=5;
		}
		
        if (terg>0) then draw_back_pack=false;
    
        if (unit.weapon_one()!="") and (terg<5){
            scr_ui_display_weapons(1,terg,unit.weapon_one());
        }
		
        if (unit.weapon_two()!="") and (terg<5) and (force_both_weapons=false){
            scr_ui_display_weapons(2,terg,unit.weapon_two());
        }
    
        if (ui_twoh[1]=true) and (ui_left_Arm=false) then ui_right_arm=false;
        if (ui_twoh[2]=true) and (ui_right_arm=false) then ui_left_Arm=false;
    
        draw_set_color(38144);
        draw_rectangle(xx+x_draw,yy+y_draw,xx+x_draw+166,yy+y_draw+231,0);    
        if( shader_is_compiled(sReplaceColor)){
            shader_set(sReplaceColor);
        
            shader_set_uniform_f(colour_to_find1, sourceR1,sourceG1,sourceB1 );       
            shader_set_uniform_f(colour_to_set1, targetR1,targetG1,targetB1 );
            shader_set_uniform_f(colour_to_find2, sourceR2,sourceG2,sourceB2 );       
            shader_set_uniform_f(colour_to_set2, targetR2,targetG2,targetB2 );
            shader_set_uniform_f(colour_to_find3, sourceR3,sourceG3,sourceB3 );       
            shader_set_uniform_f(colour_to_set3, targetR3,targetG3,targetB3 );
            shader_set_uniform_f(colour_to_find4, sourceR4,sourceG4,sourceB4 );       
            shader_set_uniform_f(colour_to_set4, targetR4,targetG4,targetB4 );
            shader_set_uniform_f(colour_to_find5, sourceR5,sourceG5,sourceB5 );
            shader_set_uniform_f(colour_to_set5, targetR5,targetG5,targetB5 );
            shader_set_uniform_f(colour_to_find6, sourceR6,sourceG6,sourceB6 );
            shader_set_uniform_f(colour_to_set6, targetR6,targetG6,targetB6 );
            shader_set_uniform_f(colour_to_find7, sourceR7,sourceG7,sourceB7 );
            shader_set_uniform_f(colour_to_set7, targetR7,targetG7,targetB7 );
        
            // Special specialist stuff here
            /*
            ui_specialist=0;
            if (ma_role[sel]=obj_ini.role[100,14]) then ui_specialist=1;// Chaplain
            if (ma_role[sel]=obj_ini.role[100,15]) then ui_specialist=3;// Apothecary
            if (ma_role[sel]=obj_ini.role[100,15]) and ((global.chapter_name="Blood Angels") or (obj_ini.progenitor==5)) then ui_specialist=4;// Sanguinary
            if (ma_role[sel]=obj_ini.role[100,16]) then ui_specialist=5;// Techmarine
            if (ma_role[sel]=obj_ini.role[100,17]) then ui_specialist=7;// Librarian
            */
        
            ttrim=trim;
			specialist_colours=obj_ini.col_special;
			
			// Chaplain
            if (ui_specialist=1) or ((ui_specialist=3) and (global.chapter_name="Space Wolves")){
                shader_set_uniform_f(colour_to_set1, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set2, 30/255,30/255,30/255);
                // ttrim=0;
                specialist_colours=0;
            }
			
			// Apothecary
            else if (ui_specialist=3) and (global.chapter_name!="Space Wolves"){
                shader_set_uniform_f(colour_to_set1, 255/255,255/255,255/255);
                shader_set_uniform_f(colour_to_set2, 255/255,255/255,255/255);
                ttrim=0;specialist_colours=0;
            }
			
			// Techmarine
            else if (ui_specialist=5){
                shader_set_uniform_f(colour_to_set1, 150/255,0/255,0/255);
                shader_set_uniform_f(colour_to_set2, 150/255,0/255,0/255);
                // pauldron
                shader_set_uniform_f(colour_to_set4, 0/255,70/255,0/255);
                shader_set_uniform_f(colour_to_set5, 200/255,200/255,200/255);
                ttrim=1;specialist_colours=0;
            }
			
			// Death Company
            else if (ui_specialist=15){
                shader_set_uniform_f(colour_to_set1, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set2, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set3, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set4, 124/255,0/255,0/255);// Lens
                shader_set_uniform_f(colour_to_set5, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set6, 30/255,30/255,30/255);
                shader_set_uniform_f(colour_to_set7, 124/255,0/255,0/255);// Weapon
                ttrim=0;specialist_colours=0;
            }
			
			// Deathwing
            if (ui_coloring="bone"){
                shader_set_uniform_f(colour_to_set1, 255/255,217/255,193/255);
                shader_set_uniform_f(colour_to_set2, 255/255,217/255,193/255);
                shader_set_uniform_f(colour_to_set3, 255/255,217/255,193/255);
                shader_set_uniform_f(colour_to_set5, 255/255,217/255,193/255);
                shader_set_uniform_f(colour_to_set6, 255/255,217/255,193/255);
                ttrim=0;specialist_colours=0;
            }
			
			// Blood Angels
            else if (ui_coloring="gold"){
                shader_set_uniform_f(colour_to_set1, 166/255,129/255,0/255);
                shader_set_uniform_f(colour_to_set2, 166/255,129/255,0/255);
                shader_set_uniform_f(colour_to_set3, 166/255,129/255,0/255);
                shader_set_uniform_f(colour_to_set5, 166/255,129/255,0/255);
                shader_set_uniform_f(colour_to_set6, 166/255,129/255,0/255);
                ttrim=0;specialist_colours=0;
            }
        
			// Marine draw sequence
            /*
            main
            secondary
            pauldron
            lens
            trim
            pauldron2
            weapon
            */
        
            //Rejoice!
            // draw_sprite(spr_marine_base,img,xx+x_draw,yy+y_draw);
        
            var clothing_style=3;
            if (global.chapter_name=="Dark Angels") or (obj_ini.progenitor==1)  {clothing_style=0;}
            else if (global.chapter_name=="White Scars") or (obj_ini.progenitor==2)  {clothing_style=1; }
            else if (global.chapter_name=="Space Wolves") or (obj_ini.progenitor==3)  {clothing_style=2;}
            else if (global.chapter_name=="Imperial Fists") or (obj_ini.progenitor==4)  {clothing_style=0;}
            else if (global.chapter_name=="Iron Hands") or (obj_ini.progenitor==6) { clothing_style=0;}
            else if (global.chapter_name=="Salamanders") or (obj_ini.progenitor==8)  {clothing_style=4;}
            else if (global.chapter_name=="Raven Guard") or (obj_ini.progenitor==9)  {clothing_style=0;}
            else if (global.chapter_name=="Doom Benefactors")  {clothing_style=4;}
        
            // Determine Sprite
            if (skull=-50) then skull=1;
        
            if (unit.armour()!=""){
                var yep=0;
				for(var o=1;o<=4;o++){if (obj_ini.adv[o]="Slow and Purposeful") then slow=1;}
                if (ui_specialist=5){
					yep=0;
					for(var o=1;o<=4;o++){if (obj_ini.adv[o]="Tech-Brothers") then brothers=0;}
				}
            }else{armour_sprite=spr_weapon_blank;}// Define armour
        
			
			
            if (unit.armour()=="Scout Armour"){
				if (slow>0) then slow=10;
				armour_sprite=spr_scout_colors;
				if (hood=-50) then hood=0;
			}else if (unit.armour()=="MK3 Iron Armour"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=3;
				armour_sprite=spr_iron2_colors;
				if (hood=-50) then hood=5;
			}else if (unit.armour()=="MK4 Maximus"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=3;
				armour_sprite=spr_maximus_colors;
				if (hood=-50) then hood=6;
			}else if (unit.armour()=="MK5 Heresy"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=3;
				armour_sprite=spr_heresy_colors;
				if (hood=-50) then hood=6;
			}else if (unit.armour()=="MK6 Corvus"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=2;
				armour_sprite=spr_beakie_colors;
				if (hood=-50) then hood=3;
			}else if (unit.armour()=="MK7 Aquila") or (unit.armour()=="Power Armour"){
				if (brothers>-5) then brothers=0;
				if (slow>0) then slow=13;
				armour_sprite=spr_aquila_colors;
				if (hood=-50) then hood=1;
			}else if (unit.armour()=="MK8 Errant"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=0;
				armour_sprite=spr_errant_colors;
				if (hood=-50) then hood=4;
			}else if (unit.armour()=="Tartaros"){
				armour_sprite=spr_tartaros2_colors;
				if (brothers>-5) then brothers=4;
				if (hood=-50) then hood=8;
				if (skull==1) then skull=3;
			}
            if (show_arm=="Terminator Armour"){
				armour_sprite=spr_terminator2_colors;
				if (brothers>-5) then brothers=5;
				if (hood=-50) then hood=9;
				if (skull==1) then skull=2;
			}else if (show_arm=="Artificer Armour"){
				if (slow>0) then slow=13;
				if (brothers>-5) then brothers=1;
				armour_sprite=spr_artificer_colors;
				if (hood=-50) then hood=2;
			}else if (show_arm=="Dreadnought") then armour_sprite=spr_dread_colors;
        
            if (armour_sprite=spr_weapon_blank) and (unit.armour()!=""){
                if (string_count("Power Armour",unit.armour())>0){
					if (slow>0) then slow=13;
					if (brothers>-5) then brothers=0;
					armour_sprite=spr_aquila_colors;
					if (hood=-50) then hood=1;
				}
                if (string_count("Artifi",unit.armour())>0){
					if (slow>0) then slow=13;
					if (brothers>-5) then brothers=1;
					armour_sprite=spr_artificer_colors;
					if (hood=-50) then hood=2;
				}
                if (string_count("Termi",unit.armour())>0){
					if (brothers>-5) then brothers=5;
					armour_sprite=spr_terminator2_colors;
					if (hood=-50) then hood=9;
					if (skull==1) then skull=2;
				}
                if (string_count("Dread",unit.armour())>0) then armour_sprite=spr_dread_colors;
            }
            /*if (show_arm!=0){
                if (string_count("Power Armour",unit.armour())>0){if (slow>0) then slow=13;if (brothers>-5) then brothers=0;armour_sprite=spr_aquila_colors;if (hood=-50) then hood=1;}
                if (string_count("Artifi",unit.armour())>0){if (slow>0) then slow=13;if (brothers>-5) then brothers=1;armour_sprite=spr_artificer_colors;if (hood=-50) then hood=2;}
                if (string_count("Termi",unit.armour())>0){if (brothers>-5) then brothers=5;armour_sprite=spr_terminator2_colors;if (hood=-50) then hood=9;if (skull=1) then skull=2;}
                if (string_count("Dread",unit.armour())>0) then armour_sprite=spr_dread_colors;
            }*/
        
            // Draw servo arms
            if (arm>0) and (unit.armour()!=""){
                if (arm<10) then draw_sprite(spr_pack_arm,arm,xx+x_draw,yy+y_draw);
                if (arm>=10) then draw_sprite(spr_pack_arms,arm-10,xx+x_draw,yy+y_draw);
            }
        
            // Draw the fixed upper arms for Terminators and Tartaros
            if (terg=1){
                if (fix_left>0) then draw_sprite(spr_termi_wep_fix,0,xx+x_draw,yy+y_draw);
                if (fix_right>0){
                    if (specialist_colours<=1) then draw_sprite(spr_termi_wep_fix,2,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_termi_wep_fix,3,xx+x_draw,yy+y_draw);
                }
            }
            if (terg=2){
                if (fix_left>0) then draw_sprite(spr_tartaros_wep_fix,0,xx+x_draw,yy+y_draw);
                if (fix_right>0){
                    if (specialist_colours<=1) then draw_sprite(spr_tartaros_wep_fix,2,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_tartaros_wep_fix,3,xx+x_draw,yy+y_draw);
                }
            }
        
            // Draw the lights
            if (ui_specialist=3) and (unit.armour()!=""){
                draw_sprite(spr_gear_apoth,0,xx+x_draw,yy+y_draw);
            }
        
            // Draw the backpack
            if (draw_back_pack=true) and (terg<5) and (unit.armour()!=""){
                if (specialist_colours==0) then draw_sprite(armour_sprite,10,xx+x_draw,yy+y_draw);
                if (specialist_colours==1) then draw_sprite(armour_sprite,11,xx+x_draw,yy+y_draw);
                if (specialist_colours>=2) then draw_sprite(armour_sprite,12,xx+x_draw,yy+y_draw);
            }
            if (draw_back_pack=false) and (terg<5) and (unit.armour()!=""){
                if (jump==1){
                    if (specialist_colours==0) then draw_sprite(spr_pack_jump,0,xx+x_draw,yy+y_draw);
                    if (specialist_colours==1) then draw_sprite(spr_pack_jump,1,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_pack_jump,2,xx+x_draw,yy+y_draw);
                }
                if (dev==1){
                    if (specialist_colours==0) then draw_sprite(spr_pack_devastator,0,xx+x_draw,yy+y_draw);
                    if (specialist_colours==1) then draw_sprite(spr_pack_devastator,1,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_pack_devastator,2,xx+x_draw,yy+y_draw);
                }
            }
        
            if (braz=1) and (unit.armour()!="") and (blandify=0){
                if (terg==0) then draw_sprite(spr_pack_brazier,0,xx+x_draw,yy+y_draw);
                if (terg>0) then draw_sprite(spr_pack_brazier,1,xx+x_draw-2,yy+y_draw);
            }
        
            // Draw the Iron Halo
            if (halo=1) and (unit.armour()!=""){var st;st=false;
                if (hood==0) and (terg<1) and (unit.armour()!="") and (ui_specialist=14) and ((obj_ini.progenitor=5) or (global.chapter_name="Blood Angels")) then st=true;
                if (st==false) then draw_sprite(spr_gear_halo,0,xx+x_draw,yy+y_draw);
            }
        
            // Weapons for below arms
            if (ui_weapon_1!=0) and (sprite_exists(ui_weapon_1)) and (ui_above[1]==false) and (fix_left<8){
                if (ui_twoh[1]==false) and (ui_twoh[2]==false) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                if (ui_twoh[1]==true){
                    if (specialist_colours<=1) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    if (specialist_colours>=2) then draw_sprite(ui_weapon_1,3,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    if (force_both_weapons==true){
                        if (specialist_colours<=1) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                        if (specialist_colours>=2) then draw_sprite(ui_weapon_1,1,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    }
                }
            }
            if (ui_weapon_2!=0) and (ui_above[2]==false) and (sprite_exists(ui_weapon_2)) and ((ui_twoh[1]==false) or (force_both_weapons==true)) and (fix_right<8){
                if (ui_spec[2]==false) then draw_sprite(ui_weapon_2,1,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                if (ui_spec[2]==true){
                    if (specialist_colours<=1) then draw_sprite(ui_weapon_2,2,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                    if (specialist_colours>=2) then draw_sprite(ui_weapon_2,3,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                }
            }
        
            if (unit.armour()=="") or (unit.armour()=="None") or (unit.armour()=="(None)"){
                if (ui_specialist==111) and (global.chapter_name=="Doom Benefactors") then skin=6;
            
                draw_sprite(spr_marine_base,skin,xx+x_draw,yy+y_draw);
            
                if (skin!=6) then draw_sprite(spr_clothing_colors,clothing_style,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="Scout Armour"){
                draw_sprite(spr_marine_base,skin,xx+x_draw,yy+y_draw);
                draw_sprite(spr_marine_base,5,xx+x_draw,yy+y_draw);// Kind of crops the 'skin tone' pixels below the scout ones
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                draw_sprite(spr_facial_colors,clothing_style,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK3 Iron Armour"){
                draw_sprite(armour_sprite,col_special,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_iron2_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_iron2_colors,5,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK4 Maximus"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_maximus_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_maximus_colors,5,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK5 Heresy"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_heresy_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_heresy_colors,5,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK6 Corvus"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_beakie_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_beakie_colors,5,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK7 Aquila") or (show_arm="Power Armour"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_aquila_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_aquila_colors,5,xx+x_draw,yy+y_draw);
            }
            if (unit.armour()=="MK8 Errant"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_errant_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_errant_colors,5,xx+x_draw,yy+y_draw);
            }
            if (show_arm="Artificer Armour"){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_artificer_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_artificer_colors,5,xx+x_draw,yy+y_draw);
            }
            if (terg=2){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_tartaros2_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_tartaros2_colors,5,xx+x_draw,yy+y_draw);
            }
            if (terg=1){
                draw_sprite(armour_sprite,specialist_colours,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours<=1) then draw_sprite(spr_terminator2_colors,4,xx+x_draw,yy+y_draw);
                if (ttrim==0) and (specialist_colours>=2) then draw_sprite(spr_terminator2_colors,5,xx+x_draw,yy+y_draw);
            }
            if (terg=5){
                draw_sprite(spr_dread_colors,specialist_colours,xx+x_draw,yy+y_draw);
            }
        
            if (slow>=10) and (blandify=0) then draw_sprite(armour_sprite,slow,xx+x_draw,yy+y_draw);// Slow and Purposeful battle damage
            if (brothers>=0) and (blandify=0) then draw_sprite(spr_gear_techb,brothers,xx+x_draw,yy+y_draw);// Tech-Brothers bling
        
        
            // This draws the arms
            if (show_arm!="Dreadnought") and (specialist_colours<=1) and (unit.armour()!=""){
                if (ui_left_Arm=true) then draw_sprite(armour_sprite,6,xx+x_draw,yy+y_draw);
                if (ui_right_arm=true) then draw_sprite(armour_sprite,8,xx+x_draw,yy+y_draw);
            }
            if (show_arm!="Dreadnought") and (specialist_colours>=2) and (unit.armour()!=""){
                if (ui_left_Arm=true) then draw_sprite(armour_sprite,6,xx+x_draw,yy+y_draw);
                if (ui_right_arm=true) then draw_sprite(armour_sprite,9,xx+x_draw,yy+y_draw);
            }
        
            // Apothecary Lens
            if (ui_specialist=3) and (unit.armour()!=""){
                if (terg=2) then draw_sprite(spr_gear_apoth,1,xx+x_draw-2,yy+y_draw-3);// was y_draw-4 with old tartar
                if (terg=1) then draw_sprite(spr_gear_apoth,1,xx+x_draw-4,yy+y_draw-2);
                if (terg!=1) and (terg!=2) then draw_sprite(spr_gear_apoth,1,xx+x_draw,yy+y_draw);
            }
        
            // Hood
            if (hood>0) and (unit.armour()!=""){
                var yep=0;
				
				for(var o=1;o<=4;o++){if (obj_ini.adv[o]="Daemon Binders") and (blandify=0) then yep=1;}
                if (yep=0) or (hood>=7){
                    if (obj_ini.main_color=obj_ini.secondary_color) then draw_sprite(spr_gear_hood1,hood,xx+x_draw,yy+y_draw);
                    if (obj_ini.main_color!=obj_ini.secondary_color) then draw_sprite(spr_gear_hood3,hood,xx+x_draw,yy+y_draw);
                }
                if (yep=1) and (hood<7){
                    if (ttrim=1) then draw_sprite(spr_gear_hood2,0,xx+x_draw-2,yy+y_draw-11);
                    if (ttrim==0) then draw_sprite(spr_gear_hood2,1,xx+x_draw-2,yy+y_draw-11);
                }
            }
			//Chaplain head and Terminator version
            if (skull>0) and (ui_specialist=1) and (unit.armour()!=""){
                if (terg!=2) and (terg!=1) then draw_sprite(spr_gear_chap,skull,xx+x_draw-2,yy+y_draw-11);
                if (terg=2) then draw_sprite(spr_gear_chap,skull,xx+x_draw-2,yy+y_draw-11);
                if (terg=1) then draw_sprite(spr_gear_chap,skull,xx+x_draw-2,yy+y_draw-11);
                if (unit.armour()!="Terminator"){
                  if (terg=2) or (terg=1) then draw_sprite(spr_terminator_chap,1,xx+x_draw-2,yy+y_draw-11);
             }
            }
			
			// bionics
			
			
			for (body_part = 0; body_part<array_length(global.body_parts);body_part++){
				if (struct_exists(unit.body[$ global.body_parts[body_part]], "bionic")){
					bionic_tooltip+=string("standard bionic {0}#",global.body_parts_display[body_part]);
					array_push(body_augmentations.bionics[0], body_part);
					array_push(body_augmentations.bionics[1], global.body_parts[body_part]);
					if (!array_contains(["Dreadnought", "Terminator Armour", "Tartaros"], unit.armour())){
						if (global.body_parts[body_part] == "left_eye") {
							if (unit.armour() == "MK3 Iron Armour"){
								draw_sprite(spr_bionics_eye,0,xx+x_draw+5,yy+y_draw)
							} else{
								draw_sprite(spr_bionics_eye,0,xx+x_draw+5,yy+y_draw-4)
							}
						};
						if (global.body_parts[body_part] == "right_eye") {
							if (unit.armour() == "MK3 Iron Armour"){
								draw_sprite(spr_bionics_eye,1,xx+x_draw+4,yy+y_draw);
							} else{
								draw_sprite(spr_bionics_eye,1,xx+x_draw+4,yy+y_draw-4);
							}
						};
						if (global.body_parts[body_part] == "left_leg") {draw_sprite(spr_bionics_leg,1,xx+x_draw,yy+y_draw)};
						if (global.body_parts[body_part] == "right_leg") {draw_sprite(spr_bionics_leg,0,xx+x_draw,yy+y_draw)};
						if (global.body_parts[body_part] == "left_arm") {draw_sprite(spr_bionics_arm,1,xx+x_draw,yy+y_draw)};
						if (global.body_parts[body_part] == "right_arm") {draw_sprite(spr_bionics_arm,0,xx+x_draw,yy+y_draw)};
					}
				}
			}
        
            // Honor Guard Helm
            if (hood==0) and (terg<1) and (unit.armour()!="") and (ui_specialist==14){
                var helm_ii,o,yep;
            	helm_ii=0;
                if (obj_ini.progenitor=7) or (global.chapter_name="Ultramarines") then helm_ii=1;
                if (obj_ini.progenitor=5) or (global.chapter_name="Blood Angels") then helm_ii=5;

				yep=0;
				for(var p=1; p<=4;p++){
					if (obj_ini.adv[p]="Tech-Brothers") then yep=1;
				}
				if (yep=1) then helm_ii=2;
      			yep=0;
				for(var q=1; q<=4;q++){
					if (obj_ini.dis[q]="Never Forgive") then yep=1;
				}
				if (yep=1) or (obj_ini.progenitor==1) then helm_ii=3;
                yep=0;
				for(var r=1; r<=4;r++){
					if (obj_ini.adv[r]="Reverent Guardians") then yep=1;
				}
				if (yep==1) then helm_ii=4;
                draw_sprite(spr_honor_helm,helm_ii,xx+x_draw-2,yy+y_draw-11);
			}
            // Weapons for above arms
            if (ui_weapon_1!=0) and (sprite_exists(ui_weapon_1)) and (ui_above[1]==true) and (fix_left<8){
                if (ui_twoh[1]==false) and (ui_twoh[2]==false) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                if (ui_twoh[1]==true){
                    if (specialist_colours<=1) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    if (specialist_colours>=2) then draw_sprite(ui_weapon_1,3,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    if (force_both_weapons==true){
                        if (specialist_colours<=1) then draw_sprite(ui_weapon_1,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                        if (specialist_colours>=2) then draw_sprite(ui_weapon_1,1,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                    }
                }
            }
            if (ui_weapon_2!=0) and (ui_above[2]==true) and (sprite_exists(ui_weapon_2)) and ((ui_twoh[1]==false) or (force_both_weapons==true)) and (fix_right<8){
                if (ui_spec[2]==false) then draw_sprite(ui_weapon_2,1,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                if (ui_spec[2]==true){
                    if (specialist_colours<=1) then draw_sprite(ui_weapon_2,2,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                    if (specialist_colours>=2) then draw_sprite(ui_weapon_2,3,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                }
            }
        
            // New powerfists for termi/tartaros
            if (ui_weapon_1!=0){
                if  (fix_left==8){
                	draw_sprite(spr_weapon_powfist3,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod)
                } else if(fix_left==8.1){
                	draw_sprite(spr_weapon_lightning2,0,xx+x_draw+x_pos_mod,yy+y_draw+y_pos_mod);
                }
                if (fix_right==8){
                	draw_sprite(spr_weapon_powfist3,1,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                } else if(fix_right==8.1){
                	draw_sprite(spr_weapon_lightning2,1,xx+x_draw+x_pos_mod_2,yy+y_draw+y_pos_mod_@);
                }
        	}
        
            // Draw the fixed upper hands for Terminators or Tartaros
            if (terg==1){
                if (fix_left>0) and (fix_left!=2) and (fix_left!=4) and (fix_left<8) then draw_sprite(spr_termi_wep_fix,4,xx+x_draw,yy+y_draw);
                if (fix_right>0) and (fix_right!=2) and (fix_right!=4) and (fix_right<8){
                    if (specialist_colours<=1) then draw_sprite(spr_termi_wep_fix,6,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_termi_wep_fix,7,xx+x_draw,yy+y_draw);
                }
            }
            if (terg==2){
                if (fix_left>0) and (fix_left!=2) and (fix_left!=4) and (fix_left<8) then draw_sprite(spr_tartaros_wep_fix,4,xx+x_draw,yy+y_draw);
                if (fix_right>0) and (fix_right!=2) and (fix_right!=4) and (fix_right<8){
                    if (specialist_colours<=1) then draw_sprite(spr_tartaros_wep_fix,6,xx+x_draw,yy+y_draw);
                    if (specialist_colours>=2) then draw_sprite(spr_tartaros_wep_fix,7,xx+x_draw,yy+y_draw);
                }
            }
            // if (braz=1) then draw_sprite(spr_pack_brazier,1,xx+x_draw,yy+y_draw);
			
            shader_reset();
        }else{
            draw_set_color(c_gray);
            draw_text(xx+x_draw,yy+y_draw,string_hash_to_newline("Color swap shader#did not compile"));
        }
        // if (unit.race()!="1"){draw_set_color(38144);draw_rectangle(xx+x_draw,yy+y_draw,xx+x_draw+166,yy+y_draw+231,0);}
    }

    draw_set_alpha(1);

    if (unit.name_role()!=""){
        if (unit.race()=="3"){
            if (string_count("Techpriest",unit.name_role())>0) then draw_sprite(spr_techpriest,0,xx+x_draw,yy+y_draw);
        }
        if (unit.race()=="4"){
            if (string_count("Crusader",unit.name_role())>0) then draw_sprite(spr_crusader,0,xx+x_draw,yy+y_draw);
        }
        if (unit.race()=="5"){
            if (string_count("Sister of Battle",unit.name_role())>0) then draw_sprite(spr_sororitas,0,xx+x_draw,yy+y_draw);
            if (string_count("Sister Hospitaler",unit.name_role())>0) then draw_sprite(spr_sororitas,1,xx+x_draw,yy+y_draw);
        }
        if (unit.race()=="6"){
            if (string_count("Ranger",unit.name_role())>0) then draw_sprite(spr_eldar_hire,0,xx+x_draw,yy+y_draw);
            if (string_count("Howling Banshee",unit.name_role())>0) then draw_sprite(spr_eldar_hire,1,xx+x_draw,yy+y_draw);
        }
    }

    // Crop anything sticking out of the display
    draw_set_color(0);
    draw_rectangle(xx+1y_draw,yy+168,xx+x_draw,yy+419,0);// Left
    draw_rectangle(xx+x_draw+166,yy+168,xx+1404,yy+419,0);// Right
    draw_rectangle(xx+1198,yy+168,xx+1384,yy+158,0);// Top
    draw_rectangle(xx+1198,yy+y_draw+231,xx+1384,yy+419,0);// Bottom

    draw_set_color(c_gray);draw_rectangle(xx+x_draw,yy+y_draw,xx+x_draw+166,yy+y_draw+231,1);
    draw_text_transformed(xx+1290,yy+145,string_hash_to_newline(string(unit.name_role())),1.5,1.5,0);

    draw_set_font(fnt_40k_14);
    draw_set_halign(fa_left);
}