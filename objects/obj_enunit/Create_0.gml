
unit="";
men=0;
veh=0;
dreads=0;
medi=0;
owner = eFACTION.Imperium;
engaged=0;
hostile_range=999;
hostile_splash=0;
flank=0;
flyer=0;// Works same as flank, but does not get denoted as such
neww=0;

highlight=0;
highlight2=0;
highlight3="";

enemy=0;
enemy2=0;



avg_attack=1;
avg_ranged=1;
avg_defense=1;
averages=1;


// x determines column; maybe every 10 or so?

var i;i=0;
i=0;
repeat(1001){i+=1;
    wep[i]="";
    wep_num[i]=0;
    combi[i]=0;
    range[i]=0;
    att[i]=0;
    apa[i]=0;
    ammo[i]=-1;
    splash[i]=0;
    wep_owner[i]="";
    
    dude_co[i]=0;
    dude_id[i]=0;
    
    dudes[i]="";
    dudes_special[i]="";
    dudes_num[i]=0;
    dudes_onum[i]=-1;
    dudes_ac[i]=0;
    dudes_hp[i]=0;
    dudes_dr[i]=1;
    dudes_vehicle[i]=0;
    dudes_damage[i]=0;
    dudes_exp[i]=0;
    dudes_powers[i]="";
    faith[i]=0;
    
    dudes_attack[i]=1;
    dudes_ranged[i]=1;
    dudes_defense[i]=1;
    
    dudes_wep1[i]="";
    dudes_wep2[i]="";
    dudes_gear[i]="";
    dudges_mobi[i]="";
}

alarm[1]=5;
alarm[5]=6;
if (obj_ncombat.enemy=1) then alarm[6]=10;

// if (obj_ncombat.enemy=1){alarm[1]=8;alarm[5]=10;}


pos = 0;
diff = 0;
siz = 0;
