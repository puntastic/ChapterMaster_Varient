// the min population of a planet is usually 1/3 of the max. so lava has 1500 max. min is 500. min + random should = max
// its important to know the population of a planet due to recruitment changing depending on population max
// If getting to max pop is very rare, it will be awful to recruit from
// some planets may be better or worse than others depending on their max pop.
// TODO refactor and improve logic
for(var i=1; i<=4; i++){
    p_population[i]=0;// 10B
    switch (p_type[i]) {
        case "Lava":
            p_population[i] = irandom(1500) + 500;
            p_station[i] = 2;
            p_max_population[i] = 2000;
            break;
        case "Desert":
            p_population[i] = irandom(150000000) + 100000000;
            p_fortified[i] = choose(2, 3, 4);
            p_station[i] = 3;
            p_max_population[i] = 250000000;
            break;
        case "Hive":
            p_population[i] = random(100) + 50;
            p_large[i] = 1;
            p_fortified[i] = 4;
            p_station[i] = choose(4, 5);
            p_max_population[i] = 150;
            break;
        case "Agri":
            p_population[i] = irandom(1000000) + 500000;
            p_fortified[i] = choose(0, 1);
            p_station[i] = choose(0, 1);
            p_max_population[i] = 1500000;
            break;
        case "Temperate":
            p_population[i] = irandom(4) + 2;
            p_large[i] = 1;
            p_fortified[i] = choose(3, 4);
            p_station[i] = choose(3, 4);
            p_max_population[i] = 6;
            break;
        case "Shrine":
            p_population[i] = irandom(5) + 3;
            p_large[i] = 1;
            p_fortified[i] = choose(4, 5);
            p_station[i] = choose(4, 5);
            p_max_population[i] = 8;
            break;
        case "Ice":
            p_population[i] = irandom(13500000) + 6500000;
            p_fortified[i] = choose(1, 2, 3);
            p_station[i] = choose(1, 2, 3);
            p_max_population[i] = 20000000;
            break;
        case "Feudal":
            p_population[i] = irandom(400000000) + 200000000;
            p_fortified[i] = choose(2, 3);
            p_station[i] = choose(2, 3, 4);
            p_max_population[i] = 600000000;
            break;
        case "Forge":
            p_population[i] = random(26) + 4;
            p_large[i] = 1;
            p_fortified[i] = 5;
            p_station[i] = 5;
            p_max_population[i] = 30;
            break;
        case "Death":
            p_population[i] = irandom(300000) + 200000;
            p_station[i] = choose(2, 3);
            p_max_population[i] = 500000;
            break;
        case "Craftworld":
            p_population[i] = irandom_range(150000, 300000);
            p_station = 6;
            p_max_population[i] = p_population[i];
            break;
    }
    // Sets military on planet
    if (p_population[i]>=10000000){
        var military=p_population[i]/470;
        p_guardsmen[i]=floor(military*0.25);
        p_pdf[i]=floor(military*0.75);
    }
    if (p_population[i]>=5000000) and (p_population[i]<10000000){
        var military=p_population[i]/200;
        p_guardsmen[i]=floor(military*0.25);
        p_pdf[i]=floor(military*0.75);
    }
    if (p_population[i]>=100000) and (p_population[i]<5000000){
        var military=p_population[i]/50;
        p_guardsmen[i]=floor(military*0.25);
        p_pdf[i]=floor(military*0.75);
    }
    if (p_population[i]<100000) and (p_population[i]>5) and (p_large[i]==0){
        p_pdf[i]=floor(p_population[i]/25);
    }
    if (p_population[i]<2000) and (p_population[i]>5) and (p_large[i]==0){
        p_pdf[i]=floor(p_population[i]/10);
    }
    if (p_large[i]==1){
        p_guardsmen[i]=floor(p_population[i]*1250000);
        p_pdf[i]=p_guardsmen[i]*3;
    }
    
    if (p_population[i]<1000000)  and (p_large[i]==0)then p_pop[i]=string(p_population[i]);
    if (p_population[i]>999999)  and (p_large[i]==0)and (p_population[i]<1000000000) then p_pop[i]=string(p_population[i]/1000000)+"M";
    if (p_large[i]==1) then p_pop[i]=string(p_population[i])+"B";
    
    if (craftworld==1){
        p_guardsmen[i]=0;
        p_pdf[i]=0;
        p_eldar[i]=6;
        owner = eFACTION.Eldar;
        p_owner[1]=6;
        buddy=0;
        x2=0;
    }
    // p_guardsmen[i]=0;
}

for(var i=1; i<=4; i++){p_guardsmen[i]=0;}

var fleet, system_fleet=0,capital=0,frigate=0,escort=0;
// Create Imperium Fleet
if (owner == eFACTION.Imperium) or (owner == eFACTION.Ork) or (owner == eFACTION.Mechanicus){
    for(var g=1; g<=4; g++){
        switch (p_type[g]) {
            case "Hive":
                system_fleet += 4;
                break;
            case "Forge":
                system_fleet += 8;
                break;
            case "Desert":
            case "Temperate":
                system_fleet += 1;
                break;
            case "Feudal":
            case "Ice":
                system_fleet += 0.5;
                break;
            case "Shrine":
                system_fleet += 2;
                break;
        }
    }
    
    frigate=round(system_fleet/2);
    escort=round(system_fleet);
    
    if (capital<0) then capital=0;
    if (frigate<0) then frigate=0;
    if (escort<0) then escort=0;
    
    if (system_fleet>0){                                                      // DISABLED FOR TESTING FLEET COMBAT
        fleet=instance_create(x,y-32,obj_en_fleet);
        fleet.owner = eFACTION.Imperium;
        
        fleet.capital_number=capital;
        fleet.frigate_number=frigate;
        fleet.escort_number=escort;
        
        // present_fleet[2]+=1;
        
        // Create ships here
        fleet.image_speed=0;
        var ii=0;
        ii+=capital-1;
        ii+=round((frigate/2));
        ii+=round((escort/4));
        if (ii<=1) and (capital+frigate+escort>0) then ii=1;
        fleet.image_index=ii;
    }
}
// Creates Ork forces
if (owner == eFACTION.Ork){
    if (p_population[1]>0) then p_orks[1]=1;
    if (p_population[2]>0) then p_orks[2]=1;
    if (p_population[3]>0) then p_orks[3]=1;
    if (p_population[4]>0) then p_orks[4]=1;
    
    if (p_orks[1]>0){p_orks[1]=choose(1,2,3,3,4,5);
    if (p_type[1]="Forge") or (p_type[1]="Hive") then p_orks[1]=choose(5);}
    if (p_orks[2]>0){p_orks[2]=choose(1,2,3,3,4,5);
    if (p_type[2]="Forge") or (p_type[2]="Hive") then p_orks[2]=choose(5);}
    if (p_orks[3]>0){p_orks[3]=choose(1,2,3,3,4,5);
    if (p_type[3]="Forge") or (p_type[3]="Hive") then p_orks[3]=choose(5);}
    if (p_orks[4]>0){p_orks[4]=choose(1,2,3,3,4,5);
    if (p_type[4]="Forge") or (p_type[4]="Hive") then p_orks[4]=choose(5);}
}

system_fleet=1;
capital=0;
frigate=0;
escort=0;
// Create Tau Fleet
if (owner == eFACTION.Tau){
    for (var i = 1; i <= 4; i++) {
        if (p_type[i] == "Desert") {
            system_fleet += 5;
        }
    }
    
    if (system_fleet>=4){
        capital=choose(1,2,2,2,3,4);
        frigate=floor(random_range(5,10));
        escort=floor(random_range(8,14));
    }
    if (system_fleet>=1) and (system_fleet<3){
        capital=choose(1,2,2);
        frigate=floor(random_range(4,8));
        escort=floor(random_range(5,12));
    }
    if (system_fleet>0){
        fleet=instance_create(x-24,y-24,obj_en_fleet);
        fleet.owner = eFACTION.Tau;
        // Create ships here
        fleet.sprite_index=spr_fleet_tau;
        fleet.image_speed=0;
        
        fleet.capital_number=capital;
        fleet.frigate_number=frigate;
        fleet.escort_number=escort;
        
        fleet.image_index=floor((capital)+(frigate/2)+(escort/4));
    }
    
    for (var i = 1; i <= 4; i++) {
        if (p_type[i] != "Dead") {
            p_tau[i] = choose(1,2,3,4);
        }
    }
    for (var i = 1; i <= 4; i++) {
        if (p_type[i] == "Desert" && p_tau[i] < 4) {
            p_tau[i] = 4;
        }
    }
    for (var i = 1; i <= 4; i++) {
        if (p_tau[i] > 0) {
            p_owner[i] = 8;
            p_first[i] = 8;
            
            switch (p_type[i]) {
                case "Forge":
                case "Hive":
                    p_tau[i] = choose(2,3);
                    break;
                case "Ice":
                    p_tau[i] = choose(1,2);
                    break;
                case "Temperate":
                case "Desert":
                case "Feudal":
                    p_tau[i] = choose(3,3,4,4,5);
                    break;
            }
        }
    }
    
    p_owner[1]=8;
    p_first[1]=8;
    p_influence[1]=70;
    p_owner[2]=8;
    p_first[2]=8;
    p_influence[2]=70;
    p_owner[3]=8;
    p_first[3]=8;
    p_influence[3]=70;
    p_owner[4]=8;
    p_first[4]=8;
    p_influence[4]=70;
}
// Create Nids
if (owner == eFACTION.Tyranids){
    for (var i = 1; i <= 4; i++) {
        if (p_population[i] > 0) {
            p_tyranids[i] = 1;
            
            switch (p_type[i]) {
                case "Forge":
                case "Hive":
                    p_tyranids[i] = choose(4,5,5);
                    break;
            }
        }
        p_owner[i] = 2;
    }
}

if (owner>20){
    for (var i = 1; i <= 4; i++) {
        if (p_population[i] > 0) {
            p_tyranids[i] = 3;
        }
        p_owner[i] = 2;
    }
    owner = eFACTION.Tyranids;
}

for(var i=1; i<=4; i++){
    if (p_owner[i]=8) and (p_guardsmen[i]>0){
        p_pdf[i]+=p_guardsmen[i];
        p_guardsmen[i]=0;
    }
    if (p_type[i]="Shrine") and (p_owner[i]!=1) and (p_first[i]!=1){
        p_owner[i]=5;
        p_first[i]=5;
        p_sisters[i]=4;
    }
    // if (p_owner[i]=3) or (p_owner[i]=5){p_feature[i]="Artifact|";}Testing ; 137
}

if (name=="Kim Jong") and (owner == eFACTION.Chaos){
    for (var i = 1; i <= 4; i++) {
        if (p_type[i] != "Dead") {
            p_heresy[i] = 100;
            p_traitors[i] = 2;
        }
    }
}

obj_controller.alarm[3]=1;

var i=choose(0,1);
if (i==1) and (planets>0){
    var nostart=false,aa=0;
    i=floor(random(planets))+1;
    
    if (instance_exists(obj_p_fleet)) {
        aa = instance_nearest(x, y, obj_p_fleet);
        if (point_distance(x, y, aa.x, aa.y) > 50) {
            nostart = true;
        }
    }
    if (!instance_exists(obj_p_fleet)) then nostart=true;
    
    if (array_length(p_feature[i])==0) and (p_owner[i]!=1) and (nostart){
		var ranb=0;
		// if (ranb=1) and (p_owner[i]!=1) and (p_owner[i]!=2) and (p_owner[i]!=3) then ranb=floor(random(4))+2;
		//
		var goo=0;
		if (goo==0){
            for(var j=0; j<10; j++){
                if (goo==0)and (irandom(9)<2){
                    ranb=floor(random(6))+1;

                    switch (name) {
                        case "Vulvis Major":
                            ranb = 1;
                            break;
                        case "Necron Assrape":
                            ranb = 2;
                            break;
                        case "Morrowynd":
                            ranb = 5;
                            break;
                    }
			
                    if (goo==0){
                        switch (ranb){
                            case 1:
                                array_push(p_feature[i], new new_planet_feature(P_features.Sororitas_Cathedral))
                                if (p_heresy[i]>10) then p_heresy[i]-=10;
                                p_sisters[i]=choose(2,2,3);
                                goo=1;
                                break;
                            case 2:
                                if (p_type[i]!="Hive") and (p_type[i]!="Lava") and (goo==0){
                                    array_push(p_feature[i], new new_planet_feature(P_features.Necron_Tomb))
                                    goo=1;
                                }
                                break;
                            case 3:
                                array_push(p_feature[i], new new_planet_feature( P_features.Artifact))
                                goo=1;
                                break;
                            case 4:
                                array_push(p_feature[i], new new_planet_feature( P_features.STC_Fragment))
                                goo=1;
                                break;
                            case 5:
                                if (p_type[i]!="Ice") and (p_type[i]!="Dead") and (p_type[i]!="Feudal"){
                                    goo=1;
                                    array_push(p_feature[i], new new_planet_feature( P_features.Ancient_Ruins))
                                }
                                break;
                            //alternative spawn for necron tomb probably needs merging with other method
                            case 6:
                                if ((p_type[i]=="Ice") or (p_type[i]=="Dead")){
                                    array_push(p_feature[i], new new_planet_feature( P_features.Necron_Tomb))
                                    goo=1;
                                }
                                break;
                            case 7:
                            if ((p_type[i]=="Dead") or (p_type[i]=="Desert")){
                                var randum=floor(random(100))+1;
                                if (randum<=25){
                                    array_push(p_feature[i], new new_planet_feature( P_features.Cave_Network))
                                    goo=1;
                                }
                            }
                            break;
                        }
                    }
		        }
		    }
	    }
    }
}

var hyu=0;
for(var i=1; i<=4; i++){
    if (p_tyranids[i]>=5){
        p_guardsmen[i]=0;
        p_pdf[i]=0;
        p_population[i]=0;
        hyu+=1;
        p_owner[i]=9;
    }
    if (p_first[i]<=5) and (dispo[i]>-5000) then dispo[i]=-20;
}
if (hyu==0) and (owner == eFACTION.Tyranids) then owner = eFACTION.Imperium;

scr_star_ownership(false);

if (obj_controller.is_test_map=true){
    /*if (p_owner[1]=3) then p_feature[1]="STC Fragment|";
    if (p_owner[2]=3) then p_feature[2]="STC Fragment|";
    if (p_owner[3]=3) then p_feature[3]="STC Fragment|";
    
    
    // Testing new guardsmen
    p_guardsmen[1]=5000000;
    p_tyranids[1]=4;
    
    p_guardsmen[2]=500000;
    p_tyranids[2]=3;
    
    p_guardsmen[3]=100000;
    p_tyranids[3]=2;
    
    p_orks[1]=0;p_orks[2]=0;p_orks[3]=0;*/
}

// if (obj_controller.is_test_map=true) and (p_owner[2]=1){

if (p_owner[2]=1){
    /*
    p_guardsmen[2]=10000000;
    p_pdf[2]=0;
    obj_controller.faction_status[eFACTION.Imperium]="War";
    */
    
    // p_type[1]="Dead";
    // p_feature[2]="";
    
    // p_orks[2]=3;
    // p_feature[2]="Starship!0!|";
    
    /*repeat(4){
        var fleet;fleet=instance_create(x+(floor(random_range(100,200))*choose(1,-1)),y+(floor(random_range(100,200))*choose(1,-1)),obj_en_fleet);
        fleet.owner = eFACTION.Chaos;fleet.sprite_index=spr_fleet_chaos;fleet.orbiting=0;
        fleet.action_x=x;fleet.action_y=y;fleet.alarm[4]=1;
        
        fleet.capital_number=0;
        fleet.frigate_number=1;
        fleet.escort_number=2;
        
        // Create ships here
        fleet.image_speed=0;
        var ii;ii=0;ii+=capital-1;ii+=round((frigate/2));ii+=round((escort/4));
        if (ii<=1) and (capital+frigate+escort>0) then ii=1;
        fleet.image_index=ii;
    }*/
    
}

obj_controller.alarm[9]=2;
if (obj_controller.is_test_map!=true) and (p_owner[2]!=1){
    for(var i=1; i<=4; i++){p_guardsmen[i]=0;}
}
