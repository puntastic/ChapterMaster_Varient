
var comp,plan,i;i=0;comp=0;plan=0;
plan=instance_nearest(x,y,obj_star);
 delete_features(plan.p_feature[num], P_features.Artifact);

scr_return_ship(loc,self,num);

with(obj_star_select){instance_destroy();}
with(obj_fleet_select){instance_destroy();}

obj_controller.menu=20;obj_controller.diplomacy=3;obj_controller.force_goodbye=5;

if (obj_controller.disposition[3]<=10) then obj_controller.disposition[3]+=5;
if (obj_controller.disposition[3]>10) and (obj_controller.disposition[3]<=30) then obj_controller.disposition[3]+=7;
if (obj_controller.disposition[3]>30) and (obj_controller.disposition[3]<=50) then obj_controller.disposition[3]+=9;
if (obj_controller.disposition[3]>50) then obj_controller.disposition[3]+=11;

with(obj_controller){scr_dialogue("stc_thanks");}

with(obj_temp2){instance_destroy();}
with(obj_temp3){instance_destroy();}
with(obj_temp7){instance_destroy();}

if (obj_ini.fleet_type=1) then with(obj_star){
    if (owner  = eFACTION.Player) and ((p_owner[1]=1) or (p_owner[2]=1)) then instance_create(x,y,obj_temp2);
}
if (obj_ini.fleet_type!=1) then with(obj_p_fleet){// Get fleet star system
    if (capital_number>0) and (action="") then instance_create(instance_nearest(x,y,obj_star).x,instance_nearest(x,y,obj_star).y,obj_temp2);
    if (frigate_number>0) and (action="") then instance_create(instance_nearest(x,y,obj_star).x,instance_nearest(x,y,obj_star).y,obj_temp7);
}


if (obj_ini.fleet_type!=1){
    with(obj_p_fleet){if (action="") then instance_deactivate_object(instance_nearest(x,y,obj_star));}
}
with(obj_star){// Get origin star system for enemy fleet
    if (owner=obj_controller.diplomacy) and ((p_owner[1]=obj_controller.diplomacy) or (p_owner[2]=obj_controller.diplomacy) 
    or (p_owner[3]=obj_controller.diplomacy) or (p_owner[4]=obj_controller.diplomacy)){
        instance_create(x,y,obj_temp3);
    }
}

var targ, flit, i,chasing;chasing=0;// Set target

if (instance_exists(obj_temp2)) then targ=instance_nearest(obj_temp2.x,obj_temp2.y,obj_temp3);
if (!instance_exists(obj_temp2)) and (instance_exists(obj_temp7)) then targ=instance_nearest(obj_temp7.x,obj_temp7.y,obj_temp3);

// If player fleet is flying about then get their target for new target
if (!instance_exists(obj_temp2)) and (!instance_exists(obj_temp7)) and (instance_exists(obj_p_fleet)) and (obj_ini.fleet_type!=1){chasing=1;
    with(obj_p_fleet){var pop;
        if (capital_number>0) and (action!=""){pop=instance_create(action_x,action_y,obj_temp2);pop.action_eta=action_eta;}
        if (frigate_number>0) and (action!=""){pop=instance_create(action_x,action_y,obj_temp7);pop.action_eta=action_eta;}
    }
}
if (instance_exists(obj_temp2)) then targ=instance_nearest(obj_temp2.x,obj_temp2.y,obj_temp3);
if (!instance_exists(obj_temp2)) and (instance_exists(obj_temp7)) then targ=instance_nearest(obj_temp7.x,obj_temp7.y,obj_temp3);

flit=instance_create(targ.x-0,targ.y-32,obj_en_fleet);

flit.owner=obj_controller.diplomacy;
flit.home_x=targ.x;flit.home_y=targ.y;
flit.sprite_index=spr_fleet_mechanicus;

flit.image_index=0;
flit.capital_number=1;
flit.trade_goods="Requisition!500!|";

if (obj_ini.fleet_type!=1){
    if (instance_exists(obj_temp2)){flit.action_x=obj_temp2.x;flit.action_y=obj_temp2.y;flit.target=instance_nearest(flit.action_x,flit.action_y,obj_p_fleet);}
    if (!instance_exists(obj_temp2)) and (instance_exists(obj_temp7)){flit.action_x=obj_temp7.x;flit.action_y=obj_temp7.y;flit.target=instance_nearest(flit.action_x,flit.action_y,obj_p_fleet);}
}
if (obj_ini.fleet_type=1){
    targ=instance_nearest(flit.x,flit.y,obj_temp2);
    flit.action_x=targ.x;flit.action_y=targ.y;
}

flit.alarm[4]=1;

instance_activate_all();
with(obj_temp2){instance_destroy();}
with(obj_temp3){instance_destroy();}
with(obj_temp7){instance_destroy();}
instance_destroy();


