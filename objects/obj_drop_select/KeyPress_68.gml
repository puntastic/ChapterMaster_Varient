

var i,comp,good,chick;i=0;comp=0;good=1;
refresh_raid=0;chick=1;

repeat(3500){
    if (good=1){
        i+=1;if (i>300){i=1;comp+=1;}
        if (comp>10) then good=0;
    }
    
    if (good=1){if (obj_ini.lid[comp][i]>0) and (via[obj_ini.lid[comp][i]]!=1) then chick=0;}
    
    if (good=1){
        if (fighting[comp][i]=1) then show_message(string(comp)+":"+string(i)+", "+string(obj_ini.role[comp][i])+" is 'fighting'");
    }
}



