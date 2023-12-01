/*
    Creates all instances and logic for the game, 
    This is the MAIN script to load in the actual game UI and where most if not all MISC Stuff from the game is:
    NOTE from old Duke:

    Welcome to the project file for Chapter Master.  As of December
    2014 I will be attempting to add documentation across this file
    in order to facilitate the transfer of development.  This comment
    in particular will give you a rundown on the most key parts of
    Chapter Master.  Burn it to memory and it will help smooth out
    development.
    
    
    The main objects that you will probably be concering yourself
    with are as follows:
    
    obj_ini: Handles all of the marine, ship, and vehicle variables.
    It is first created after going through the main menu and
    finilizing chapter creation.
    
    obj_controller: Misc variables, is the focus of the room view,
    and draws the vast majority of the user interface.
    
    obj_popup: Draws and handles all of the popup stuff (such as
    random events, confirmation boxes, changing equipment, etc.)
    
    
    In addition to these objects, there are also a multitude of
    scripts.  They are split into a number of folders for different
    categories and relatively clean access.
    
    Sys: Utility functions that should be included within frikkin'
    Game Maker.  Stuff like drawing dotted lines, adding comas to
    numbers, exploding a banana string into multiple variables.
    
    Combat: Anything that relates to things dying goes in here.
    Note that the scr_weapon script also handles the tooltips for
    weapons and their stats, until it is cleaned up and rewritten.
    
    Interface: This contains all of the long, probably uneccesary
    scripts for drawing the UI.  The controller object executes these
    in the draw function when certain criteria is met.
    
    Turn: All of the end-of-turn AI, random events, and actions
    pertaining to ending turn go in here.  Note that the enemy AI
    is split further into a handful of different scripts, designated
    as A, B, C, D, and E.  These are all ran on each star object each
    turn.
        A: Enemy ground combat
        B: Rebellions, number increases, spreading
        C: Enemy production of ships
        D: Local random event happenings
        E: Enemy space combat and quening player battles
    Note that the alarm5 event of the controller also has some turn
    end scripts- this one handles the END of END of turn for variables
    and crap that is not neccesarily pertaining to a local star or planet.
    
    Diplomacy: Everything related to quests, trading, dialogue, and 
    names goes into this folder.  The scr_dialogue in particular is
    the main script that contains all of the dialogue writing for
    each enemy race.
    
    Root Folder: All of the frequently-accessed scripts that don't
    fall neatly into the other folders go on top.  The most important
    ones to take note of are scr_chapter (contains all the presets),
    chapter_random (randomizes the chapter), scr_initialize_custom
    (executed by obj_ini to generate the actual chapter arrays), and
    scr_loyalty (either calculates the loyalty or changes it on
    demand).  Check equipment, add items, add man, add vehicle, and add
    artifact are also in this root folder, and frequently used.
    
    The Machine God watches over you.
*/

is_test_map=false;
target_navy_number=5;
global.sound_playing=0;
global.defeat=0;
tutorial=0;
sound_in=0;
sound_to="";
fix_right=0;
text_bar=0;
bar_fix=0;
last_attack_form=1;
last_raid_form=3;
double_click=0;
double_was=0;
last_weapons_tab=1;
complex_event=false;
current_eventing="";
chaos_rating=0;
obj_cuicons.alarm[1]=1; // Clean up custom icons

diplomacy_pathway = "";
option_selections=[];
ready=false;

// ** Create Chaos Gods **
chaos_gods = {};
function build_chaos_gods(){
	var _god_names = ["Khorne", "Slaanesh", "Nurgle", "Tzeentch"]
	for (var _i = 0; _i < 4; _i++){
		chaos_gods[$ _god_names[_i]] = {};
		chaos_gods[$ _god_names[_i]].favour = 0;
		chaos_gods[$ _god_names[_i]].god_name = _god_names[_i];
		chaos_gods[$ _god_names[_i]].emmissary = "";
		chaos_gods[$ _god_names[_i]].power = 0;
		chaos_gods[$ _god_names[_i]].interfaced = 0;
	}
	
}
build_chaos_gods()

// ** Resets global vars **
obj_controller.restart_name="";
obj_controller.restart_founding="";
obj_controller.restart_secret="";
for(var i=0; i<=11; i++){obj_controller.restart_title[i]="";}
obj_controller.restart_icon=0;
obj_controller.restart_icon_name="";
obj_controller.restart_powers="";
for(var ad=0; ad<5; ad ++){
    obj_controller.restart_adv[ad]="";
    obj_controller.restart_dis[ad]="";
}
obj_controller.restart_recruiting_type="";
obj_controller.restart_trial="";
obj_controller.restart_recruiting_name="";
obj_controller.restart_home_type="";
obj_controller.restart_home_name="";
obj_controller.restart_fleet_type=0;
obj_controller.restart_recruiting_exists=0;
obj_controller.restart_homeworld_exists=0;
obj_controller.restart_homeworld_rule=0;
obj_controller.restart_battle_cry="";
obj_controller.restart_main_color="";
obj_controller.restart_secondary_color="";
obj_controller.restart_trim_color="";
obj_controller.restart_pauldron2_color="";
obj_controller.restart_pauldron_color="";
obj_controller.restart_lens_color="";
obj_controller.restart_weapon_color="";
obj_controller.restart_col_special=0;
obj_controller.restart_trim=0;
obj_controller.restart_skin_color=0;
obj_controller.restart_hapothecary="";
obj_controller.restart_hchaplain="";
obj_controller.restart_clibrarian="";
obj_controller.restart_fmaster="";
obj_controller.restart_recruiter="";
obj_controller.restart_admiral="";
obj_controller.restart_equal_specialists=0;
obj_controller.restart_load_to_ships=[0,0,0];
obj_controller.restart_successors=0;
obj_controller.restart_mutations=0;
obj_controller.restart_preomnor=0;
obj_controller.restart_voice=0;
obj_controller.restart_doomed=0;
obj_controller.restart_lyman=0;
obj_controller.restart_omophagea=0;
obj_controller.restart_ossmodula=0;
obj_controller.restart_membrane=0;
obj_controller.restart_zygote=0;
obj_controller.restart_betchers=0;
obj_controller.restart_catalepsean=0;
obj_controller.restart_secretions=0;
obj_controller.restart_occulobe=0;
obj_controller.restart_mucranoid=0;
obj_controller.restart_master_name="";
obj_controller.restart_master_melee=0;
obj_controller.restart_master_ranged=0;
obj_controller.restart_master_specialty=0;
obj_controller.restart_strength=0;
obj_controller.restart_cooperation=0;
obj_controller.restart_purity=0;
obj_controller.restart_stability=0;

// ** Sets default equipement for roles **
// 100 is defaults, 101 is the allowable starting equipment
for(var i=100; i<103; i++){
    obj_controller.r_role[i,2]="Honor Guard";
    obj_controller.r_wep1[i,2]="Power Sword";
    obj_controller.r_wep2[i,2]="Bolter";
    obj_controller.r_armour[i,2]="Power Armour";
    obj_controller.r_mobi[i,2]="";
    obj_controller.r_gear[i,2]="";
    
    obj_controller.r_role[i,3]="Veteran";
    obj_controller.r_wep1[i,3]="Chainsword";
    obj_controller.r_wep2[i,3]="Bolter";
    obj_controller.r_armour[i,3]="Power Armour";
    obj_controller.r_mobi[i,3]="";
    obj_controller.r_gear[i,3]="";
    
    obj_controller.r_role[i,4]="Terminator";
    obj_controller.r_wep1[i,4]="Power Fist";
    obj_controller.r_wep2[i,4]="Storm Bolter";
    obj_controller.r_armour[i,4]="Terminator Armour";
    obj_controller.r_mobi[i,4]="";
    obj_controller.r_gear[i,4]="";
    
    obj_controller.r_role[i,5]="Captain";
    obj_controller.r_wep1[i,5]="Power Fist";
    obj_controller.r_wep2[i,5]="Bolt Pistol";
    obj_controller.r_armour[i,5]="Power Armour";
    obj_controller.r_mobi[i,5]="";
    obj_controller.r_gear[i,5]="";
    
    obj_controller.r_role[i,6]="Dreadnought";
    obj_controller.r_wep1[i,6]="Close Combat Weapon";
    obj_controller.r_wep2[i,6]="Lascannon";
    obj_controller.r_armour[i,6]="Dreadnought";
    obj_controller.r_mobi[i,6]="";
    obj_controller.r_gear[i,6]="";
    
    obj_controller.r_role[i,7]="Company Champion";
    obj_controller.r_wep1[i,7]="Power Sword";
    obj_controller.r_wep2[i,7]="Storm Shield";
    obj_controller.r_armour[i,7]="Power Armour";
    obj_controller.r_mobi[i,7]="";
    obj_controller.r_gear[i,7]="";
    
    obj_controller.r_role[i,8]="Tactical Marine";
    obj_controller.r_wep1[i,8]="Bolter";
    obj_controller.r_wep2[i,8]="Chainsword";
    obj_controller.r_armour[i,8]="Power Armour";
    obj_controller.r_mobi[i,8]="";
    obj_controller.r_gear[i,8]="";
    
    obj_controller.r_role[i,9]="Devastator";
    obj_controller.r_wep1[i,9]="Heavy Ranged";
    obj_controller.r_wep2[i,9]="Combat Knife";
    obj_controller.r_armour[i,9]="Power Armour";
    obj_controller.r_mobi[i,9]="";
    obj_controller.r_gear[i,9]="";
    
    obj_controller.r_role[i,10]="Assault Marine";
    obj_controller.r_wep1[i,10]="Chainsword";
    obj_controller.r_wep2[i,10]="Bolt Pistol";
    obj_controller.r_armour[i,10]="Power Armour";
    obj_controller.r_mobi[i,10]="Jump Pack";
    obj_controller.r_gear[i,10]="";
    
    obj_controller.r_role[i,12]="Scout";
    obj_controller.r_wep1[i,12]="Sniper Rifle";
    obj_controller.r_wep2[i,12]="Combat Knife";
    obj_controller.r_armour[i,12]="Scout Armour";
    obj_controller.r_mobi[i,12]="";
    obj_controller.r_gear[i,12]="";
    
    obj_controller.r_role[i,14]="Chaplain";
    obj_controller.r_wep1[i,14]="Power Sword";
    obj_controller.r_wep2[i,14]="Storm Bolter";
    obj_controller.r_armour[i,14]="Power Armour";
    obj_controller.r_gear[i,14]="Rosarius";
    obj_controller.r_mobi[i,14]="";
    
    obj_controller.r_role[i,15]="Apothecary";
    obj_controller.r_wep1[i,15]="Power Sword";
    obj_controller.r_wep2[i,15]="Storm Bolter";
    obj_controller.r_armour[i,15]="Power Armour";
    obj_controller.r_gear[i,15]="Narthecium";
    obj_controller.r_mobi[i,15]="";
    
    obj_controller.r_role[i,16]="Techmarine";
    obj_controller.r_wep1[i,16]="Power Axe";
    obj_controller.r_wep2[i,16]="Storm Bolter";
    obj_controller.r_armour[i,16]="Power Armour";
    obj_controller.r_gear[i,16]="Servo Arms";
    obj_controller.r_mobi[i,16]="";
    
    obj_controller.r_role[i,17]="Librarian";
    obj_controller.r_wep1[i,17]="Force Weapon";
    obj_controller.r_wep2[i,17]="Storm Bolter";
    obj_controller.r_armour[i,17]="Power Armour";
    obj_controller.r_gear[i,17]="Psychic Hood";
    obj_controller.r_mobi[i,17]="";
                
    obj_controller.r_role[i,18]="Sergeant";
    obj_controller.r_wep1[i,18]="Chainsword";
    obj_controller.r_wep2[i,18]="Storm Bolter";
    obj_controller.r_armour[i,18]="Power Armour";
    obj_controller.r_gear[i,18]="";
    obj_controller.r_mobi[i,18]=""; 

    obj_controller.r_role[i,19]="Veteran Sergeant";
    obj_controller.r_wep1[i,19]="Chainsword";
    obj_controller.r_wep2[i,19]="Storm Bolter";
    obj_controller.r_armour[i,19]="Power Armour";
    obj_controller.r_gear[i,19]="";
    obj_controller.r_mobi[i,19]="";                     
} // 100 is defaults, 101 is the allowable starting equipment
// ** Resets all races and equipement for 100 **
for(var i=0; i<21; i++){
    obj_controller.r_race[100,i]=0;
    obj_controller.r_role[100,i]="";
    obj_controller.r_wep1[100,i]="";
    obj_controller.r_wep2[100,i]="";
    obj_controller.r_armour[100,i]="";
    obj_controller.r_gear[100,i]="";
    obj_controller.r_mobi[100,i]="";
}
// ** Sets to full screen/ checks for resolution **
window_data=string(window_get_x())+"|"+string(window_get_y())+"|"+string(window_get_width())+"|"+string(window_get_height())+"|";
window_old=window_data;
if (window_get_fullscreen()=1){
    window_old="fullscreen";
    window_data="fullscreen";
}
// ** Sets cheatcode values **
cheatcode=0;
cheatyface=0;
// ** Debugging file created **
debug_lines=0;
ini_open("debug_log.ini");
debug_lines=ini_read_real("Main","lines",0);
ini_close();

debugl("=========Controller Created");
// ** Creates saves.ini with default settings **
ini_open("saves.ini");
master_volume=ini_read_real("Settings","master_volume",1);
effect_volume=ini_read_real("Settings","effect_volume",1);
music_volume=ini_read_real("Settings","music_volume",1);
large_text=ini_read_real("Settings","large_text",0);
settings_heresy=ini_read_real("Settings","settings_heresy",0);
settings_fullscreen=ini_read_real("Settings","fullscreen",1);
settings_window_data=ini_read_string("Settings","window_data","fullscreen");
if (is_test_map) then global.cheat_debug=true;
ini_close();

// ** Sets play variables **
info_fragments=0;
play_time=0;
play_second=0;
invis=false;

otha=0;
zoomed=0;
spr_custom1=0;
spr_custom2=0;
spr_custom3=0;
spr_custom4=0;
force_scroll=0;
homeworld_rule=1;
demanding=0;
select_wounded=1;
terra_direction=floor(random(360))+1;

load_game=0;
good_log=0;

// Line
l_options=0;
l_menu=0;
l_manage=0;
l_settings=0;
l_apothecarium=0;
l_reclusium=0;
l_librarium=0;
l_armoury=0;
l_recruitment=0;
l_fleet=0;
l_diplomacy=0;
l_log=0;
l_turn=0;
current_planet_feature=0;
// Highlight
h_options=0;
h_menu=0;
h_manage=0;
h_settings=0;
h_apothecarium=0;
h_reclusium=0;
h_librarium=0;
h_armoury=0;
h_recruitment=0;
h_fleet=0;
h_diplomacy=0;
h_log=0;
h_turn=0;
// Relative Y
y_slide=0;
new_banner_x=0;
hide_banner=0;
// 
new_button_highlight="";
// new_button_highlighting=0;
new_buttons_hide=0;
new_buttons_frame=0;

// ** Sets tooltips **
tooltip="";
tooltip_weapon=0;
tooltip_stat1=0;
tooltip_stat2=0;
tooltip_stat3=0;
tooltip_stat4=0;
tooltip_other="";
tooltip_x=0;
tooltip_y=0;
tooltip_width=0;
tooltip_height=0;

// ** For weapon display in management **
unit_profile=false;
unit_rollover=false;
view_squad=false;
exit_period=false;
cur_squad = 0;
company_squads = [];
rollover_sequence=0;
ttrim=0;
ui_coloring=""; 
ui_melee_penalty=0;
ui_ranged_penalty=0;

// ** Sets default mouse vars **
click=0;
click2=0;
mouse_left=0;
dropdown_open=0;
scrollbar_engaged=0;
born_leader=0;

// ** Sets the secrets/events of the world **
craftworld=0;
hurssy=0;
hurssy_time=0;
qsfx=0;
und_armouries=0;
und_gene_vaults=0;
und_lairs=0;
// ** Sets default gene seed values **
gene_sold=0;
gene_xeno=0;
gene_tithe=24;
gene_iou=0;

// ** Sets default views and in game values on creation **
managing=0;
formating=0;
man_current=0;
man_max=0;
man_see=0;
ship_current=0;
ship_max=0;
ship_see=0;
man_sel[0]=0;
man_size=0;
selecting_location="";
selecting_types="";
selecting_dudes="";
sel_all="";
sel_promoting=0;
sel_loading=0;
sel_uid=0;

// ** Sets Chapter events and celebrations **
fest_sid=0;
fest_wid=0;
fest_planet=0;
fest_star="";
fest_type="";
fest_cost=0;
fest_warp=0;
fest_scheduled=0;
fest_lav=0;
fest_locals=0;
fest_feature1=0;
fest_feature2=0;
fest_feature3=0;
fest_display=0;
fest_display_tags="";
fest_repeats=0;
fest_honor_co=0;
fest_honor_id=0;
fest_honoring=0;
fest_attend="";
// Sets the festivities and allowances
fest_feasts=0;
fest_boozes=0;
fest_drugses=0;

for(var i=0; i<601; i++){
    recent_type[i]="";recent_keyword[i]="";recent_turn[i]=0;recent_number[i]=0;
}recent_happenings=0;

// Sets up items to be default
for(var i=0; i<40; i++){
    sel_uni[i]="";
    sel_veh[i]="";
    command_set[i]=0;
}
// TODO command_set is used for equipement. We should re do this and have an array for all available equipement
command_set[1]=0;
command_set[2]=0;
command_set[3]=1;
command_set[4]=1;
command_set[5]=1;
command_set[6]=1;
command_set[7]=1;
command_set[8]=0;
command_set[9]=0;
command_set[20]=1;
command_set[24]=1;
blandify=0;

// ** Default menu items **
selecting_planet=0;
selecting_ship=0;
fleet_minimized=0;
fleet_all=1;
tolerant=0;
unload=0;
new_vehicles=1;
menu=500;
settings=0;
text_bar=0;
text_selected="";
return_object=0;
return_size=0;
// menu=0;
menu_artifact=1;
menu_artifact_type=0;
menu_adept=0;
artifacts=0;
identifiable=0;
repair_ships=0;
// ** STC values **
stc_wargear=0;
stc_vehicles=0;
stc_ships=0;
stc_un_total=0;
stc_wargear_un=0;
stc_vehicles_un=0;
stc_ships_un=0;
stc_bonus[0]=0;
stc_bonus[1]=0;
stc_bonus[2]=0;
stc_bonus[3]=0;
stc_bonus[4]=0;
stc_bonus[5]=0;stc_bonus[6]=0;
// ** Resets the years **
check_number=0;
year_fraction=0;
year=0;
millenium=0;

if (instance_exists(obj_ini)){
    if (obj_ini.millenium!=0){
        check_number=obj_ini.check_number;
        year_fraction=0;// 84 per turn
        year=obj_ini.year;
        millenium=obj_ini.millenium;
    }
}
// ** Penitent and blood debt reset **
penitent=0;
penitent_current=0;
penitent_max=0;
penitent_turnly=0;
penitent_turn=0;
penitent_end=0;
blood_debt=0;

// ** Sets penitent or blood debt if chapter disadvantage is selected **
if (instance_exists(obj_ini)){
    var bloo=0;
    for(var o=1; o<=4; o++){if (obj_ini.dis[o]="Blood Debt") then bloo=1;}

    penitent=obj_ini.penitent;
    penitent_current=obj_ini.penitent_current;
    penitent_max=obj_ini.penitent_max;
    
    if (bloo=1){
        penitent_end=millenium+year+(obj_ini.penitent_end/12);
        blood_debt=1;
    }
    if (bloo=0){
        penitent_end=millenium+year+(obj_ini.penitent_end);
    }
    
    if (string_count(obj_ini.spe[0,1],"$")>0) then born_leader=1;
}
// ** Resets marines and other vars **
for(var i=0; i<501; i++){
    man[i]="";
    ide[i]=0;
    man_sel[i]=0;
    ma_lid[i]=0;
    ma_wid[i]=0;
    ma_promote[i]=0;
    ma_race[i]=0;
    ma_loc[i]="";
    ma_name[i]="";
    ma_role[i]="";
    ma_wep1[i]="";
    ma_mobi[i]="";
    ma_wep2[i]="";
    ma_armour[i]="";
    ma_gear[i]="";
    ma_health[i]=100;
    ma_chaos[i]=0;
    ma_exp[i]=0;
    ma_god[i]=0;
    sh_ide[i]=0;
    sh_uid[i]=0;
    sh_name[i]="";
    sh_class[i]="";
    sh_loc[i]="";
    sh_hp[i]="";
    sh_cargo[i]=0;
    sh_cargo_max[i]="";
    squad[i]=0;
    display_unit[i]=0;

    
    if (i<=50){
        penit_co[i]=0;
        penit_id[i]=0;
    }
    if (i<=100){
        event[i]="";
        event_duration[i]=0;
    }
}
alll=0;
//
popup=0;// 1: fleet, 2: other, 3: system
selected=0;
sel_owner=0;
sel_system_x=0;
sel_system_y=0;
popup_master_crafted=0;
// ** Sets starting turn **
turn=1;
// turn=40;
// ** Sets events and missions **
last_event=0;
last_mission=0;
// ** Inquisition inspection **
last_world_inspection=0;// Duhuhu
last_fleet_inspection=0;

// chaos_turn=100+((floor(random(10))+1)*choose(-1,1));
// ** Sets when chaos will arrive **
chaos_turn=2;
// ** Sets fleets**
chaos_fleets=0;
tau_fleets=0;
tau_stars=0;
tau_messenger=0;
imp_ships=0;
cooldown=8;
exit_all=0;
// ** Sets diplomacy and trading **
diplomacy=0;
trading=0;
trading_artifact=0;
trading_enemy_demand=0;
trading_demand=0;
trade_likely="";
questing=0;
liscensing=0;
audience=0;
force_goodbye=0;
trade_req=0;
trade_gene=0;
trade_chip=0;
trade_info=0;
zui=0;
was_zoomed=1;
// Variables for management
for(var t=0; i<200; t++){
    temp[t]="";
}
temp[90]=0;
temp[9000]="";
for(var t=4700; t<=4719; t++){
    temp[t]=0;temp[t+100]=0;
}
// ** Resets all audiences **
audiences=0;
audien[0]=0;
audien[1]=0;
audien[2]=0;
audien[3]=0;
audien[4]=0;
audien[5]=0;
audien[6]=0;
audien[7]=0;
audien[8]=0;
audien[9]=0;
audien[10]=0;
audien[11]=0;
audien[12]=0;
audien[13]=0;
audien[14]=0;
audien_topic[0]="";
audien_topic[1]="";
audien_topic[2]="";
audien_topic[3]="";
audien_topic[4]="";
audien_topic[5]="";
audien_topic[6]="";
audien_topic[7]="";
audien_topic[8]="";
audien_topic[9]="";
audien_topic[10]="";
audien_topic[11]="";
audien_topic[12]="";
audien_topic[13]="";
audien_topic[14]="";
// ** Sets default recruiting vars **
recruits=0;
recruiting_worlds="";
recruit_trial="Blood Duel";
recruit_last=0;
for(var i=0; i<501; i++){
    recruit_name[i]="";
    recruit_corruption[i]=0;
    recruit_distance[i]=0;
    recruit_training[i]=0;
    recruit_exp[i]=0;
    
    // For loyalty penalties
    if (i<=50){
        loyal[i]="";
        loyal_num[i]=0;// If less than 1 and greater than 0; that x100 is the chance for discovery
        loyal_time[i]=0;
    }
    if (i<=10){
        inquisitor_gender[i]=choose(1,1,1,1,2,2,2);
        inquisitor_type[i]=choose("Ordo Malleus","Ordo Xenos","Ordo Hereticus","Ordo Hereticus","Ordo Hereticus","Ordo Hereticus","Ordo Hereticus","Ordo Hereticus");
        inquisitor[i]=scr_imperial_name(inquisitor_gender[i]);// For 'random inquisitor wishes to inspect your fleet
    }
    if (i<60){
        quest[i]="";// 300req
        quest_faction[i]=0;// 6
        quest_end[i]=0;// like 4 or so after the turn this is created
    }
}
// ** Sets diplomacy variables **
diplo_last="";
diplo_text="";
diplo_txt="";
diplo_char=0;
for(var q=0; q<6; q++){
    diplo_option[q]="";
    diplo_goto[q]="";
}
diplo_alpha=0;
// ** Sets combat to not true **
combat=0;
random_event_next = EVENT.none;
useful_info="";

// ** Sets the reason for loss of loyalty **
var loyalReasons = [
    "Heretic Contact",
    "Heretical Homeworld",
    "Traitorous Marines",
    "Use of Sorcery",
    "Mutant Gene-Seed",
    
    "Non-Codex Arming",
    "Non-Codex Size",
    "Lack of Apothecary",
    "Upset Machine Spirits",
    "Undevout",
    "Irreverence for His Servants",
    "Unvigilant",
    "Conduct Unbecoming",
    "Refusing to Crusade",
    
    "Eldar Contact",
    "Ork Contact",
    "Tau Contact",
    "Xeno Trade",
    "Xeno Associate",
    
    "Inquisitor Killer",
    "Crossing the Inquisition",
    "Avoiding Inspections",
    "Lost Standard"
];

for(var i=0; i< array_length(loyalReasons); i++){
    loyal[i+1]=loyalReasons[i];
}

inqis_flag_lair=0;
inqis_flag_gene=0;

faction_justmet=0;

trade_mine[0]="";
trade_mine[1]="Requisition";
trade_mine[2]="Gene-Seed";
trade_mine[3]="STC Fragment";
trade_mine[4]="Info Chip";
trade_theirs[0]="";
trade_theirs[1]="";
trade_theirs[2]="";
trade_theirs[3]="";
trade_theirs[4]="";
trade_theirs[5]="";
trade_theirs[6]="";
trade_disp[0]=0;
trade_disp[1]=0;
trade_disp[2]=0;
trade_disp[3]=0;
trade_disp[4]=0;
trade_disp[5]=0;
trade_disp[6]=0;
trade_take[0]="";
trade_take[1]="";
trade_take[2]="";
trade_take[3]="";
trade_take[4]="";
trade_tnum[0]=0;
trade_tnum[1]=0;
trade_tnum[2]=0;
trade_tnum[3]=0;
trade_tnum[4]=0;
trade_give[0]="";
trade_give[1]="";
trade_give[2]="";
trade_give[3]="";
trade_give[4]="";
trade_mnum[0]=0;
trade_mnum[1]=0;
trade_mnum[2]=0;
trade_mnum[3]=0;
trade_mnum[4]=0;
// ** Sets up starting requisition **
requisition=500;
if (instance_exists(obj_ini)){
    if (obj_ini.progenitor==0) /*and (obj_creation.custom=0)*/ and (global.chapter_name!="Doom Benefactors") then requisition=2000;
}
if (is_test_map==true) then requisition=50000;
// ** Sets income **
income=0;
income_last=0;
/*income-=obj_ini.battle_barges;
income-=obj_ini.strike_cruisers/2;
income-=(obj_ini.gladius+obj_ini.hunters)/10;*/
income_base=0;
income_home=0;
income_forge=0;
income_agri=0;
income_recruiting=0;
income_training=0;
income_fleet=0;
income_trade=0;
income_leader=0;
income_tribute=0;
income_controlled_planets=0;
// ** Extra variables **
info_chips=0;
inspection_passes=0;
recruiting_worlds_bought=0;

// ** BATTLE FORMATIONS **
for(var i=0; i<16; i++){
    bat_formation[i]="";
    bat_formation_type[i]=0;
    bat_deva_for[i]=1;
    bat_assa_for[i]=4;
    bat_tact_for[i]=2;
    bat_vete_for[i]=2;
    bat_hire_for[i]=3;
    bat_libr_for[i]=3;
    bat_comm_for[i]=3;
    bat_tech_for[i]=3;
    bat_term_for[i]=3;
    bat_hono_for[i]=3;
    bat_drea_for[i]=5;
    bat_rhin_for[i]=6;
    bat_pred_for[i]=7;
    bat_land_for[i]=7;
    bat_scou_for[i]=1;
}
// ground=1    raid=2
// 1: Attack        type=1
// 2: Defend        type=1
// 3: Raid              type=2
// 4: (New Formation)   type=0
bat_formation[1]="Attack";
bat_formation_type[1]=1;
bat_formation[2]="Defend";
bat_formation_type[2]=1;
bat_formation[3]="Raid";
bat_formation_type[3]=2;
// Defaults formations end here

bat_devastator_column=1;
bat_assault_column=4;
bat_tactical_column=2;
bat_veteran_column=2;
bat_hire_column=3;
bat_librarian_column=3;
bat_command_column=3;
bat_techmarine_column=3;
bat_terminator_column=3;
bat_honor_column=3;
bat_dreadnought_column=5;
bat_rhino_column=6;
bat_predator_column=7;
bat_landraider_column=7;
bat_scout_column=1;
// ** Sets up disposition per faction **
enum eFACTION {
	Player = 1,
	Imperium,
	Mechanicus,
	Inquisition,
	Ecclesiarchy,
	Eldar,
	Ork,
	Tau,
	Tyranids,
	Chaos,
	Heretics,
	Necrons = 13
}
faction[0]="";
disposition[0]=0;
faction[1]="Player";
disposition[1]=0;
faction[2]="Imperium";
disposition[3]=0;
faction[3]="Mechanicus";
disposition[4]=0;
faction[4]="Inquisition";
disposition[4]=0;
faction[5]="Ecclesiarchy";
disposition[5]=0;
// ** Initial disposition for Imperial factions **
if (instance_exists(obj_ini)){
    faction[2]="Imperium";
    disposition[2]=obj_ini.imperium_disposition;
    faction[3]="Mechanicus";
    disposition[3]=obj_ini.mechanicus_disposition;
    faction[4]="Inquisition";
    disposition[4]=obj_ini.inquisition_disposition;
    faction[5]="Ecclesiarchy";
    disposition[5]=obj_ini.ecclesiarchy_disposition;
}
// ** Initial disposition for non Imperials **
faction[6]="Eldar";
disposition[6]=-10;
faction[7]="Ork";
disposition[7]=-40;
faction[8]="Tau";
disposition[8]=0;
faction[9]="Tyranids";
disposition[9] = irandom_range(40,100) = 1;// use this to countdown genestealer cults, create one at the end
faction[10]="Chaos";
disposition[10]=-70;
faction[11]="Heretics";
disposition[10]=-70;
faction[12]="";
disposition[12]=0;
faction[13]="Necrons";
disposition[13]=-20;
// ** Max disposition for imperials **
disposition_max[0]=0;
disposition_max[1]=0;
disposition_max[2]=40;
disposition_max[3]=40;
disposition_max[4]=40;
disposition_max[5]=40;
if (instance_exists(obj_ini)){
    disposition_max[2]=40+obj_ini.imperium_disposition;
    if (disposition_max[2]>100) then disposition_max[2]=100;
    disposition_max[3]=40+obj_ini.mechanicus_disposition;
    if (disposition_max[3]>100) then disposition_max[3]=100;
    disposition_max[4]=40+obj_ini.inquisition_disposition;
    if (disposition_max[4]>100) then disposition_max[4]=100;
    disposition_max[5]=40+obj_ini.ecclesiarchy_disposition;
    if (disposition_max[5]>100) then disposition_max[5]=100;
}
// ** Max disposition for non imperials **
disposition_max[6]=0;
disposition_max[7]=0;
disposition_max[8]=0;
disposition_max[9]=0;
disposition_max[10]=0;
disposition_max[11]=0;
disposition_max[12]=0;
disposition_max[13]=0;
// ** Sets up faction leader names as well as player faction stuff **
faction_leader[0]="";
faction_title[0]="";
faction_status[0]="";
faction_leader[1]="";
faction_title[1]="";
faction_status[1]="";
// Sector Command faction
faction_leader[eFACTION.Imperium]=scr_imperial_name(1);
faction_title[2]="Sector Commander";
faction_status[eFACTION.Imperium]="Allied";
// Mechanicus faction
faction_leader[eFACTION.Mechanicus]=scr_imperial_name(1);
faction_title[3]="Magos";
faction_status[eFACTION.Mechanicus]="Allied";
if (faction_leader[eFACTION.Mechanicus]==faction_leader[eFACTION.Imperium]) then faction_leader[eFACTION.Mechanicus]=scr_marine_name();
// Inquisition faction
faction_leader[eFACTION.Inquisition]=scr_imperial_name(1);
if (faction_leader[eFACTION.Inquisition]==faction_leader[eFACTION.Mechanicus]) then faction_leader[eFACTION.Inquisition]=scr_imperial_name(1);
faction_title[4]="Inquisitor Lord";
faction_status[eFACTION.Inquisition]="Allied";
// Sisters faction
faction_leader[eFACTION.Ecclesiarchy]=scr_imperial_name(2);
faction_title[5]="Prioress";
faction_status[eFACTION.Ecclesiarchy]="Allied";
// Eldar faction
faction_leader[eFACTION.Eldar]=scr_eldar_name(2);
faction_title[6]="Farseer";
faction_status[eFACTION.Eldar]="Antagonism";// If disposition = 0 then instead set it to "Antagonism"
if (instance_exists(obj_ini)){if (string_count("Eldar",obj_ini.strin)>0) then faction_status[eFACTION.Eldar]="War";}
// Orkz faction
faction_leader[eFACTION.Ork]=scr_ork_name();
faction_title[7]="Warboss";
faction_status[eFACTION.Ork]="War";
// Tau faction
faction_leader[eFACTION.Tau]="Por'O ";
// TODO put tau names into a script same as scr_eldar_name;
faction_leader[eFACTION.Tau]+=choose("Ar","Cha","Doran","Eldi","Kais","Ko","Kunas","M'yen","Ro","Tsua'm","Ukos");
faction_title[8]="Diplomat";
faction_status[eFACTION.Tau]="Antagonism";
// Other factions unkown to player
faction_leader[eFACTION.Tyranids]="";
faction_title[9]="";
faction_status[eFACTION.Tyranids]="War";

faction_leader[eFACTION.Chaos]=":D";
faction_title[10]="Chaos Lord";
faction_status[eFACTION.Chaos]="War";

faction_leader[eFACTION.Heretics]="";
faction_title[11]="";
faction_status[eFACTION.Heretics]="War";

faction_leader[12]="";
faction_title[12]="";
faction_status[12]="War";

faction_leader[eFACTION.Necrons]="";
faction_title[13]="";
faction_status[eFACTION.Necrons]="War";
// ** Sets faction gender for names **
faction_gender[0]=1;
faction_gender[1]=1;
faction_gender[2]=1;
faction_gender[3]=1;
faction_gender[4]=1;
faction_gender[10]=1;
faction_gender[5]=1;
faction_gender[6]=choose(1,2);
faction_gender[7]=1;
faction_gender[8]=choose(1,1,2);
faction_gender[9]=1;
if (faction_gender[4]=2) then faction_leader[eFACTION.Inquisition]=scr_imperial_name(2);
faction_gender[10]=choose(1,1,1,2,2);
if (faction_gender[10]==1) then faction_leader[eFACTION.Chaos]=choose("1","1","1","2");
if (faction_gender[10]==2) then faction_leader[eFACTION.Chaos]=choose("1","2","2","2");
if (faction_leader[eFACTION.Chaos]=="1") then faction_leader[eFACTION.Chaos]=scr_marine_name();
if (faction_leader[eFACTION.Chaos]=="2") then faction_leader[eFACTION.Chaos]=scr_chaos_name();
faction_gender[11]=1;
faction_gender[12]=1;
faction_gender[13]=1;

known[0]=2;
known[eFACTION.Player]=999;
known[eFACTION.Imperium]=1;
known[eFACTION.Mechanicus]=1;
known[eFACTION.Inquisition]=0;
known[eFACTION.Ecclesiarchy]=0;
known[eFACTION.Eldar]=0;
known[eFACTION.Ork]=0;
known[eFACTION.Tau]=0;
known[eFACTION.Tyranids]=0;
known[eFACTION.Chaos]=0;
known[eFACTION.Heretics]=0;
known[12]=0;
known[eFACTION.Necrons]=0;

// UI testing
// known[eFACTION.Inquisition]=1;known[eFACTION.Ecclesiarchy]=1;known[eFACTION.Eldar]=1;known[eFACTION.Ork]=1;known[eFACTION.Tau]=1;known[eFACTION.Tyranids]=1;known[eFACTION.Chaos]=1;

// eldar mission testing
// known[eFACTION.Eldar]=2;
// disposition[4]=90;
// disposition[3]=60;
// ** Sets diplomacy annoyed status **
annoyed[0]=0;
annoyed[eFACTION.Player]=0;
annoyed[eFACTION.Imperium]=0;
annoyed[eFACTION.Mechanicus]=0;
annoyed[eFACTION.Inquisition]=0;
annoyed[eFACTION.Ecclesiarchy]=0;
annoyed[eFACTION.Eldar]=0;
annoyed[eFACTION.Ork]=0;
annoyed[eFACTION.Tau]=0;
annoyed[eFACTION.Tyranids]=0;
annoyed[eFACTION.Chaos]=0;
annoyed[eFACTION.Heretics]=0;
annoyed[12]=0;
annoyed[eFACTION.Necrons]=0;
// ** Sets diplomacy ignore status **
ignore[0]=0;
ignore[eFACTION.Player]=0;
ignore[eFACTION.Imperium]=0;
ignore[eFACTION.Mechanicus]=0;
ignore[eFACTION.Inquisition]=0;
ignore[eFACTION.Ecclesiarchy]=0;
ignore[eFACTION.Eldar]=0;
ignore[eFACTION.Ork]=0;
ignore[eFACTION.Tau]=0;
ignore[eFACTION.Tyranids]=0;
ignore[eFACTION.Chaos]=0;
ignore[eFACTION.Heretics]=0;
ignore[12]=0;
ignore[eFACTION.Necrons]=0;
// ** Sets diplomacy turns to be ignored **
turns_ignored[0]=0;
turns_ignored[1]=0;
turns_ignored[2]=0;
turns_ignored[3]=0;
turns_ignored[4]=0;
turns_ignored[5]=0;
turns_ignored[6]=0;
turns_ignored[7]=0;
turns_ignored[8]=0;
turns_ignored[9]=0;
turns_ignored[10]=0;
turns_ignored[11]=0;
turns_ignored[12]=0;
turns_ignored[13]=0;
// ** Sets faction defeated **
faction_defeated[0]=0;
faction_defeated[1]=0;
faction_defeated[2]=0;
faction_defeated[3]=0;
faction_defeated[4]=0;
faction_defeated[5]=0;
faction_defeated[6]=0;
faction_defeated[7]=0;
faction_defeated[8]=0;
faction_defeated[9]=0;
faction_defeated[10]=0;
faction_defeated[11]=0;
faction_defeated[12]=0;
faction_defeated[13]=0;

// **** CHAPTER CREATION VARS ****
// ** Sets up Chapter configuration variables **
battle_cry="For the Emperor";
fortress_name="";
flagship_name="";
home_name="";
home_type="";
recruiting_name="";
recruiting_type="";
// ** Sets up chapter colors **
main_color=0;
secondary_color=0;
trim_color=0;
pauldron2_color=0;
pauldron_color=0;
lens_color=0;
weapon_color=0;
col_special=0;
trim=0;
// ** Sets up names, progenitor, successors and mutations ** 
adept_name="";
recruiter_name="";
progenitor="";
successor_chapters=0;
mutation="";

// ** Sets up disposition among imperial factions **
progenitor_disposition=0;
astartes_disposition=0;
astartes_max=0;
imperium_disposition=0;
imperium_max=0;
guard_disposition=0;
guard_max=0;
inquisition_disposition=0;
inquisition_max=0;
ecclesiarchy_disposition=0;
ecclesiarchy_max=0;
mechanicus_disposition=0;
mechanicus_max=0;
other1_disposition=0;
other1="";
// ** Sets up bonuses once chapter is created **
if (instance_exists(obj_ini)){
    // Tolerant trait
    if (global.load==0) and (string_count("Tolerant",obj_ini.strin2)>0){
        obj_controller.disposition[6]+=5;
        obj_controller.disposition[7]+=5;
        obj_controller.disposition[8]+=10;
    }
    // General setup
    if (global.load==0){
        // Founding Chapter STC Bonuses here
        if (global.chapter_name=="Salamanders"){
            stc_wargear=4;
            stc_bonus[1]=3;
            stc_bonus[2]=3;
        }
        if (global.chapter_name=="Iron Hands"){
            stc_wargear=2;
            stc_bonus[1]=5;
            stc_vehicles=2;
            stc_bonus[3]=3;
        }
        if (global.chapter_name=="Blood Ravens"){
            for(var i=0; i<3; i++){scr_add_artifact("random_nodemon","",0,obj_ini.ship[1],501);}
        }
        // TODO should add special bonus to different chapters based on lore
        adept_name=scr_marine_name();
        recruiter_name=obj_ini.recruiter_name;
        progenitor=obj_ini.progenitor;
        successor_chapters=obj_ini.successors;
        mutation="";
        main_color=obj_ini.main_color;
        secondary_color=obj_ini.secondary_color;
        trim_color=obj_ini.trim_color;
        pauldron2_color=obj_ini.pauldron2_color;
        pauldron_color=obj_ini.pauldron_color;
        lens_color=obj_ini.lens_color;
        weapon_color=obj_ini.weapon_color;
        col_special=obj_ini.col_special;
        trim=obj_ini.trim;
        recruit_trial=obj_ini.aspirant_trial;
        homeworld_rule=obj_ini.homeworld_rule;
        
        scr_colors_initialize();
        scr_shader_initialize();
        instance_create(-100,-100,obj_event_log);
        debugl("New Game");
    }
}
// ** Loads the game **
if (global.load>0){
    load_game=global.load;
    successor_chapters=0;
    instance_create(0,0,obj_saveload);
    with(obj_ini){instance_destroy();}
    instance_create(0,0,obj_ini);
    // obj_saveload.menu=2;
    obj_saveload.alarm[0]=1;
    obj_saveload.load_part=1;
    obj_cursor.image_alpha=0;
    scr_colors_initialize();
    if (global.restart==0) then debugl("Loading Game");
    if (global.restart>0) then debugl("Restarting Game");
    exit;
}

var xx,yy,me,dist,go,plan;
global.custom=1;

// ** Sets up base training level and trainees at game start **
training_apothecary=2;
apothecary_points=0;
apothecary_aspirant=0;
training_chaplain=2;
chaplain_points=0;
chaplain_aspirant=0;
training_psyker=2;
psyker_points=0;
psyker_aspirant=0;
training_techmarine=0;
tech_points=0;
tech_aspirant=0;
recruiting=0;
penitorium=0;
// Redefines training based on chapter
if (instance_exists(obj_ini)){
    if (string_count("Intolerant",obj_ini.strin2)>0) then training_psyker=0;
    if (global.chapter_name="Space Wolves") then training_chaplain=0;
}

// 0: none      1: management
// 11: apothecary       12: chaplain        13: librarium       14: armamentarium
// ** Sets the star for the chapter ? **
instance_create(irandom(room_width-400),irandom(room_height-400),obj_star);
plan=floor(random(5))+19;
plan=30*1.5;
plan=70;
if (is_test_map=true) then plan=20;


mask_index = spr_star
while(instance_number(obj_star)<plan) {
    xx = irandom(room_width-400)
    yy = irandom(room_height-400)
	
	if !place_meeting(xx, yy, obj_star) {
		instance_create(xx,yy,obj_star);
	}
}
mask_index = -1;

fleet_type="";
if (obj_ini.fleet_type==1) then fleet_type="Fleet";
if (obj_ini.fleet_type==1) then fleet_type="Homeworld";
if (obj_ini.fleet_type==3) then fleet_type="Crusade";
star_names="";
// ** Sets up the number of enemy factions to appear **
tau=1; 
tyranids=0;
ork=1;
eldar=1;
// if tau = 1 then tau spawn. also does eldar 
/*
if (global.custom=1){ 
    tau=choose(0,0,1);
    eldar=choose(0,1);
}
*/
// ** Sets up loyalty **
loyalty=100;
loyalty_hidden=100;// Updated when inquisitors do an inspection
// ** Sets up gene seed **
gene_seed=20;
if (string_count("Sieged",obj_ini.strin2)>0) then gene_seed=floor(random_range(300,500));
if (global.chapter_name=="Lamenters") then gene_seed=30;
if (global.chapter_name=="Soul Drinkers") then gene_seed=60;

//   ** sets up the starting squads**
squads = true;
game_start_squads()
squads = false;
// ** Sets up the number of marines per company **
marines=0;
marines=obj_ini.specials+obj_ini.firsts+obj_ini.seconds+obj_ini.thirds+obj_ini.fourths+obj_ini.fifths;
marines+=obj_ini.sixths+obj_ini.sevenths+obj_ini.eighths+obj_ini.ninths+obj_ini.tenths;
command=0;
command=obj_ini.commands;
// Removes the command marines from marine count
if (global.load==0) then marines-=command;
// **** INTRO SCREEN ****
temp[30]=string(check_number)+" "+string(year_fraction)+" "+string(year)+".M"+string(millenium);// Date
temp[31]=string_upper(adept_name);// Adept name
temp[32]=string_upper(obj_ini.name[0,1]);// Master name
temp[33]=string_upper(scr_thought());// Thought of the day

// Starts the vars for the 4 pages of intro
var njm=34,com=0,vih=0,word="",masta=0,forga=0,chapla=0,apa=0,liba=0,techa=0,libra=0,coda=0,lexa=0,apotha=0,old_dudes=0;

var honoh=0,termi=0,veter=0,capt=0,chap=0,apoth=0,stand=0,dread=0,tact=0,assa=0,deva=0,rhino=0,speeder=0,raider=0,standard=0,bike=0,scou=0,whirl=0,pred=0;
for(var mm=1; mm<=100; mm++){
    if (obj_ini.role[com,mm]=="Chapter Master") then masta=1;
    if (obj_ini.role[com,mm]=="Forge Master") then forga=1;
    if (obj_ini.role[com,mm]=="Master of Sanctity") then chapla=1;
    if (obj_ini.role[com,mm]=="Master of the Apothecarion") then apa=1;
    if (obj_ini.role[com,mm]=="Chief "+string(obj_ini.role[100,17])) then liba=1;
    if (obj_ini.role[com,mm]==obj_ini.role[100][16]) then techa+=1;
    if (obj_ini.role[com,mm]==obj_ini.role[100,17]) then libra+=1;
    if (obj_ini.role[com,mm]=="Codiciery") then coda+=1;
    if (obj_ini.role[com,mm]=="Lexicanum") then lexa+=1;
    if (obj_ini.role[com,mm]==obj_ini.role[100][14]) then old_dudes+=1;
    if (obj_ini.role[com,mm]==obj_ini.role[100][15]) then apotha+=1;
    if (obj_ini.role[com,mm]==obj_ini.role[100][2]) then honoh+=1;
}

temp[njm]="Command staff which includes";

if (masta==1) then temp[njm]+=", your majesty "+string(obj_ini.name[com,1]);
if (forga==1) then temp[njm]+=",  Forge Master "+string(obj_ini.name[com,2]);
if (chapla==1) then temp[njm]+=",  Master of Sanctity "+string(obj_ini.name[com,3]);
if (apa==1) then temp[njm]+=",  Master of the Apothecarion "+string(obj_ini.name[com,4]);
if (liba==1) then temp[njm]+=",  and Chief Librarian "+string(obj_ini.name[com,5])+".  ";

vih=string_pos(",",temp[njm]);
temp[njm]=string_delete(temp[njm],vih,1);
njm+=1;
temp[njm] = "";
temp[njm]+="  It has";
if (techa>0) then temp[njm]+=", "+string(techa)+" "+string(obj_ini.role[100][16])+"s";
if (old_dudes>0) then temp[njm]+=", "+string(techa)+" "+string(obj_ini.role[100][16])+"s";
if (apotha>0) then temp[njm]+=", "+string(apotha)+" "+string(obj_ini.role[100][15])+"s";
if (libra>0) then temp[njm]+=", "+string(libra)+" "+string(obj_ini.role[100,17])+"s";
if (coda>0) then temp[njm]+=", "+string(coda)+" Codiciery";
if (lexa>0) then temp[njm]+=", "+string(lexa)+" Lexicanum.";

vih=string_pos(",",temp[njm]);
temp[njm]=string_delete(temp[njm],vih,1);

if (honoh>0) then temp[njm]+="  You have an Honor Guard which contains "+string(honoh)+" souls.";
for(var company=0; company<10; company++){
    njm+=1;
    com+=1;
    fisted=0;
    techa=0;
    termi=0;
    veter=0;
    capt=0;
    chap=0;
    apoth=0;
    stand=0;
    dread=0;
    tact=0;
    assa=0;
    deva=0;
    rhino=0;
    speeder=0;
    raider=0;
    standard=0;
    bike=0;
    scou=0;
    whirl=0;
    pred=0;
    for(var mm=1; mm<=400; mm++){
        if (obj_ini.role[com,mm]==obj_ini.role[100][4]) then termi+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][3]) then veter+=1;
        if (obj_ini.role[com,mm]=="Venerable "+string(obj_ini.role[100][6])) then dread+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][5]) then capt+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][14]) then chap+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][15]) then apoth+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][16]) then techa+=1;
        if (obj_ini.role[com,mm]=="Standard Bearer") then standard+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][8]) then tact+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][10]) then assa+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][9]) then deva+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][6]) then dread+=1;
        if (obj_ini.role[com,mm]==obj_ini.role[100][12]) then scou+=1;
    }
    for(vih=1; vih<=100; vih++){
        if (obj_ini.veh_role[com,vih]=="Land Raider") then raider+=1;
        if (obj_ini.veh_role[com,vih]=="Rhino") then rhino+=1;
        if (obj_ini.veh_role[com,vih]=="Land Speeder") then speeder+=1;
        if (obj_ini.veh_role[com,vih]=="Bike") then bike+=1;
        if (obj_ini.veh_role[com,vih]=="Predator") then pred+=1;
        if (obj_ini.veh_role[com,vih]=="Whirlwind") then whirl+=1;
    }
    
    if (com==1) then word="first";
    if (com==2) then word="second";
    if (com==3) then word="third";
    if (com==4) then word="fourth";
    if (com==5) then word="fifth";
    if (com==6) then word="sixth";
    if (com==7) then word="seventh";
    if (com==8) then word="eighth";
    if (com==9) then word="ninth";
    if (com==10) then word="tenth";
    if (com>=1){
        if (veter+termi+stand+dread+tact+assa+deva+rhino+raider+standard+scou+whirl>0) then temp[njm]="You have a "+string(word)+" company.  It has";
        else{temp[njm]="";}
    }
    
    if (capt==1) then temp[njm]+=", "+string(capt)+" "+string(obj_ini.role[100][5]);
    if (chap==1) then temp[njm]+=", "+string(chap)+" "+string(obj_ini.role[100][14]);
    if (chap>1) then temp[njm]+=", "+string(chap)+" "+string(obj_ini.role[100][14])+"s";
    if (apoth==1) then temp[njm]+=", "+string(apoth)+" "+string(obj_ini.role[100][15]);
    if (apoth>1) then temp[njm]+=", "+string(apoth)+" "+string(obj_ini.role[100][15])+"s";
    if (techa==1) then temp[njm]+=", "+string(techa)+" "+string(obj_ini.role[100][16]);
    if (techa>1) then temp[njm]+=", "+string(techa)+" "+string(obj_ini.role[100][16])+"s";
    
    if (standard==1) then temp[njm]+=", 1 Standard Bearer, 1 Company Champion, ";
    if (termi>0) then temp[njm]+=", "+string(termi)+" "+string(obj_ini.role[100][4])+"s";
    if (veter>0) then temp[njm]+=", "+string(veter)+" "+string(obj_ini.role[100][3])+"s";
    if (tact>0) then temp[njm]+=", "+string(tact)+" "+string(obj_ini.role[100][8])+"s";
    if (assa>0) then temp[njm]+=", "+string(assa)+" "+string(obj_ini.role[100][10])+"s";
    if (deva>0) then temp[njm]+=", "+string(deva)+" "+string(obj_ini.role[100][9])+"s";
    if (scou>0) then temp[njm]+=", "+string(scou)+" "+string(obj_ini.role[100][12])+"s";
    if (dread==1) then temp[njm]+=", "+string(dread)+" "+string(obj_ini.role[100][6])+"";
    if (dread>1) then temp[njm]+=", "+string(dread)+" "+string(obj_ini.role[100][6])+"s";
    if (raider==1) then temp[njm]+=", "+string(raider)+" Land Raider";
    if (raider>1) then temp[njm]+=", "+string(raider)+" Land Raiders";
    if (pred==1) then temp[njm]+=", "+string(pred)+" Predator";
    if (pred>1) then temp[njm]+=", "+string(pred)+" Predators";
    if (whirl==1) then temp[njm]+=", "+string(whirl)+" Whirlwind";
    if (whirl>1) then temp[njm]+=", "+string(whirl)+" Whirlwinds";
    if (rhino==1) then temp[njm]+=", "+string(rhino)+" Rhino";
    if (rhino>1) then temp[njm]+=", "+string(rhino)+" Rhinos";
    if (speeder==1) then temp[njm]+=", "+string(speeder)+" Land Speeder";
    if (speeder>1) then temp[njm]+=", "+string(speeder)+" Land Speeders";
    if (bike==1) then temp[njm]+=", "+string(bike)+" Attack Bike";
    if (bike>1) then temp[njm]+=", "+string(raider)+" Attack Bikes";
    
    if (string_length(temp[njm])>0) then temp[njm]+=".";
    
    if (njm!=0){
        vih=string_pos(",",temp[njm]);
        temp[njm]=string_delete(temp[njm],vih,1);
    }
}

temp[59]="CLASSIFICATION: SECTOR LOGISTICAE#++++++++++DATE: "+string(temp[30])+"#++++++++AUTHOR: MASTER ADEPT "+string(temp[31])+"#++++++++++++RE: INTRODUCTORY MISSIVE#+++++RECIPIENT: CHAPTER MASTER "+string(temp[32])+"##++THOUGHT: "+string(temp[33])+"++##I see you have made it unscathed, your grace.  Death comes with you as it should!  The enemy is on the horizon.  Thy chapter is mighty and only waits for your word to wreak havoc upon our enemies.##Your chapter contains-#";
temp[60]=string(temp[59])+string(temp[34])+string(temp[35])+"##"+string(temp[36])+"##"+string(temp[37])+"##"+string(temp[38])+"##"+string(temp[39])+"##"+string(temp[40])+"##"+string(temp[41])+"##"+string(temp[42])+"##"+string(temp[43])+"##"+string(temp[44])+"##"+string(temp[45]);

temp[61]="##Your armamentarium contains some spare equipment- ";
for(var u=1; u<=30; u++){
    if (obj_ini.equipment[u]!="") then temp[61]+=string(obj_ini.equipment_number[u])+" "+string(obj_ini.equipment[u])+", ";
    if (obj_ini.equipment[u]=="") and (obj_ini.equipment[u-1]!=""){
        temp[61]=string_delete(temp[61],string_length(temp[61]),3);
        temp[61]+=".";
    }
}

temp[62]="##Your fleet contains ";

var bb=0,sk=0,glad=0,hunt=0,ships=0,bb_names="",sk_names="",glad_names="",hunt_names="";

codex[0]="";codex_discovered[0]=0;
for(var mm=1; mm<=30; mm++){
    if (obj_ini.ship[mm]!=""){
        ships+=1;
        if (obj_ini.ship_class[mm]=="Battle Barge"){
            bb+=1;
            bb_names+=", "+string(obj_ini.ship[mm]);
        }
        if (obj_ini.ship_class[mm]=="Strike Cruiser"){
            sk+=1;
            sk_names+=", "+string(obj_ini.ship[mm]);
        }
        if (obj_ini.ship_class[mm]=="Gladius"){
            glad+=1;
            glad_names+=", "+string(obj_ini.ship[mm]);
        }
        if (obj_ini.ship_class[mm]=="Hunter"){
            hunt+=1;
            hunt_names+=", "+string(obj_ini.ship[mm]);
        }
    }
    codex[mm]="";
    codex_discovered[mm]=0;
}
temp[62]+=string(ships)+" warships.#";

vih=string_pos(",",bb_names);
bb_names=string_delete(bb_names,vih,1);
vih=string_pos(",",sk_names);
sk_names=string_delete(sk_names,vih,1);
vih=string_pos(",",glad_names);
glad_names=string_delete(glad_names,vih,1);
vih=string_pos(",",hunt_names);
hunt_names=string_delete(hunt_names,vih,1);

if (obj_ini.fleet_type!=1) or (bb==1) then temp[62]+="Your flagship is the Battle Barge "+string(obj_ini.ship[1])+".  ";
if (obj_ini.fleet_type==1) and (bb>1){
    temp[62]+="There are "+string(bb)+" Battle Barges; "+string(bb_names)+".  ";
}
temp[62]+="#";
if (sk>0){
    temp[62]+="There are "+string(sk)+" Strike Cruisers; "+string(sk_names)+".  ";
    temp[62]+="#";
}
if (glad>0){
    temp[62]+="There are "+string(glad)+" Gladius Escorts; "+string(glad_names)+".  ";
    temp[62]+="#";
}
if (hunt>0){
    temp[62]+="There are "+string(hunt)+" Hunter Escorts; "+string(hunt_names)+".";
    temp[62]+="#";
}
// show_message(temp[61]);
// show_message(temp[62]);
// 61 : equipment
// 62 : ships
var lol=160;
draw_set_font(fnt_small);
vih=string_height(string_hash_to_newline(string(temp[60])+string(temp[61])+string(temp[62])));
vih-=210;vih=(vih/lol)+1;

if (floor(vih)<vih){
    vih+=1;
    vih=floor(vih);
}

// show_message(string(vih)+" pages");
var tman=65;
temp[65]=string(temp[60])+string(temp[61])+string(temp[62]);
for(var i=0; i<vih; i++){
    tman+=1;
    temp[tman]=string(temp[60])+string(temp[61])+string(temp[62]);
}

var lig=0,remov=0,stahp=0;

if (vih>=1){
    for(var i=0; i<4000; i++){
        if (string_height(string_hash_to_newline(temp[65]))>210){
            lig=string_length(temp[65]);
            temp[65]=string_delete(temp[65],lig-1,1);
        }
    }
}
remov=string_length(string(temp[65]))+1;

if (vih>=2){
    temp[66]=string_delete(temp[66],1,remov);
    for(var i=0; i<4000; i++){
        if (string_height(string_hash_to_newline(temp[66]))>130){
            lig=string_length(temp[66]);
            temp[66]=string_delete(temp[66],lig-1,1);
        }
    }
}
remov=string_length(string(temp[65])+string(temp[66]))+1;
// show_message(remov);

if (vih>=3){
    temp[67]=string_delete(temp[67],1,remov);
    for(var i=0; i<4000; i++){
        if (string_height(string_hash_to_newline(temp[67]))>lol){
            lig=string_length(temp[67]);
            temp[67]=string_delete(temp[67],lig-1,1);
        }
    }
}
remov=string_length(string(temp[65])+string(temp[66])+string(temp[67]))+1;

if (vih<4) then temp[68]="";
if (vih>=4){
    temp[68]=string_delete(temp[68],1,remov);
    for(var i=0; i<4000; i++){
        if (string_height(string_hash_to_newline(temp[68]))>lol){
            lig=string_length(temp[68]);
            temp[68]=string_delete(temp[68],lig-1,1);
        }
    }
}
remov=string_length(string(temp[65])+string(temp[66])+string(temp[67])+string(temp[68]))+1;

if (vih<5) then temp[69]="";
if (vih>=5){
    temp[69]=string_delete(temp[69],1,remov);
    for(var i=0; i<4000; i++){
        if (string_height(string_hash_to_newline(temp[69]))>lol){
            lig=string_length(temp[69]);
            temp[69]=string_delete(temp[69],lig-1,1);
        }
    }
}
remov=string_length(string(temp[65])+string(temp[66])+string(temp[67])+string(temp[68])+string(temp[69]))+1;

action_set_alarm(2, 0);
