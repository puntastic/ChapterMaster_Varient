
var i;
i=0;

if (cooldown>=0) then cooldown-=1;

if (alerts>0) and (popups_end=1) and (fadeout=0){
    repeat(alerts){
        i+=1;

        if (fast>=i) and (string_length(alert_text[i])<string_length(alert_text[i])){
            alert_char[i]+=1;
            alert_text[i]=string_copy(alert_text[i],0,alert_char[i]);
        }
        if (fast>=i) and (alert_alpha[i]<1) then alert_alpha[i]+=0.03;
    }
}


if (fadeout=1){
    i=0;
    repeat(alerts){
        i+=1;alert_alpha[i]-=0.05;
        if (i=1) and (alert_alpha[1]<=0) then instance_destroy();
    }
}



if (alarm[2]=2000) then instance_destroy();

