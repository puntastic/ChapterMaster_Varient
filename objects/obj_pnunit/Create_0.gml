
unit="";
men=0;
veh=0;
charge=0;
engaged=0;
owner  = eFACTION.Player;
medi=0;
attacked_dudes=0;
dreads=0;
jetpack_destroy=0;
defenses=0;
highlight=0;
highlight2=0;
highlight3="";
// let="";let=string_delete(obj_ini.psy_powers,2,string_length(obj_ini.psy_powers)-1);let=string_upper(let);
// LET might be different for each marine; need a way of determining this

// show_message(let);
// x determines column; maybe every 10 or so?
// For fortified locations maybe create a wall unit for the player?

var i;i=-1;
repeat(1500){i+=1;
	unit_struct = {};
    marine_type[i]="";
    marine_co[i]=0;
    marine_id[i]=0;
    marine_hp[i]=0;
    marine_ac[i]=0;
    marine_exp[i]=0;
    marine_wep1[i]="";
    marine_wep2[i]="";
    marine_armour[i]="";
    marine_gear[i]="";
    marine_mobi[i]="";
    marine_powers[i]="";
    marine_dead[i]=1;
    marine_attack[i]=1;
    marine_ranged[i]=1;
    marine_defense[i]=1;
    marine_casting[i]=0;
    marine_local[i]=0;
    ally[i]=false;
    //
    // this would be set to the turns remaining
    // so long as >0 would apply an effect
    marine_mshield[i]=0;
    marine_quick[i]=0;
    marine_might[i]=0;
    marine_fiery[i]=0;
    marine_fshield[i]=0;
    marine_iron[i]=0;
    marine_dome[i]=0;
    marine_spatial[i]=0;
    marine_dementia[i]=0;
    //
    veh_co[i]=0;
    veh_id[i]=0;
    veh_type[i]="";
    veh_hp[i]=0;
    veh_ac[i]=0;
    veh_wep1[i]="";
    veh_wep2[i]="";
    veh_wep3[i]="";
    veh_upgrade[i]="";
    veh_acc[i]="";
    veh_dead[i]=0;
    veh_hp_multiplier[i]=1;
    veh_local[i]=0;
    veh_ally[i]=false;
}

i=-1;
repeat(71){i+=1;
    wep[i]="";
    wep_num[i]=0;
    wep_rnum[i]=0;
    combi[i]=0;
    range[i]=0;
    att[i]=0;
    apa[i]=0;
    ammo[i]=-1;
    splash[i]=0;
    wep_owner[i]="";
    wep_solo[i]="";
    wep_title[i]="";

    dudes[i]="";
    dudes_num[i]=0;
    dudes_vehicle[i]=0;
}

i=-1;
repeat(61){i+=1;
    lost[i]="";
    lost_num[i]=0;
}

hostile_shots=0;
hostile_shooters=0;
hostile_damage=0;
hostile_weapon="";
hostile_unit="";
hostile_men=0;
hostile_range=0;
hostile_splash=0;



alarm[1]=4;

action_set_alarm(1, 3);
