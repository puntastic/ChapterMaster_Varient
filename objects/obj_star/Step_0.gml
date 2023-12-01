// Sets up the images for each system and planet
if (global.load>0){
    sprite_index=spr_star;
    if (star=="orange1") then image_index=0;
    if (star=="orange2") then image_index=1;
    if (star=="red") then image_index=2;
    if (star=="white1") then image_index=3;
    if (star=="white2") then image_index=4;
    if (star=="blue") then image_index=5;
    if (vision==1) then image_alpha=1;
    if (vision==0) then image_alpha=0;
    exit;
}
// Sets up transparency of system image
if (name!="") and (planets==0) and (image_alpha!=0.33) then image_alpha=0.33;
if (name!="") and (planets!=0) and (image_alpha==0.33) then image_alpha=1;
// Sets up warp storm image
if (storm>0) then storm_image+=1;
if (storm==0) then storm_image=0;
// Checks if they are dead planets, then sets up image
if (planets==1) and (p_type[1]=="Dead") then image_alpha=0.33;
if (planets==2) and (p_type[1]=="Dead") and (p_type[2]=="Dead") then image_alpha=0.33;
if (planets==3) and (p_type[1]=="Dead") and (p_type[2]=="Dead") and (p_type[3]=="Dead") then image_alpha=0.33;
if (planets==4) and (p_type[1]=="Dead") and (p_type[2]=="Dead") and (p_type[3]=="Dead") and (p_type[4]=="Dead") then image_alpha=0.33;
// Reduces enemy ai count by 1 if they are present in planet
if (ai_a>=0) then ai_a-=1;
if (ai_b>=0) then ai_b-=1;
if (ai_c>=0) then ai_c-=1;
if (ai_d>=0) then ai_d-=1;
if (ai_e>=0) then ai_e-=1;
// Sets up enemy ai beheaviour
if (ai_a==0) then scr_enemy_ai_a();
if (ai_b==0) then scr_enemy_ai_b();
if (ai_c==0) then scr_enemy_ai_c();
if (ai_d==0) then scr_enemy_ai_d();
if (ai_e==0){
    scr_enemy_ai_e();
    scr_apothecary_ground();
}
//big ol temporary way
system_player_ground_forces = array_reduce(p_player, function(prev, curr) {
	return prev + curr	
})