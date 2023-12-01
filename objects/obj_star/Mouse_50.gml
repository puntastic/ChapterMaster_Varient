// Checks which systems you can see the planets
if (action_if_number(obj_saveload, 0, 0) &&
    action_if_number(obj_drop_select, 0, 0) &&
    action_if_number(obj_bomb_select, 0, 0)){
        var m_dist=point_distance(x,y,mouse_x,mouse_y);

        if (obj_controller.cooldown>0) then exit;
        if ((obj_controller.zoomed==0) and (mouse_y<__view_get( e__VW.YView, 0 )+62)) or (obj_controller.menu!=0) then exit;
        if ((obj_controller.zoomed==0) and (mouse_y>__view_get( e__VW.YView, 0 )+830)) or (obj_controller.menu!=0) then exit;
        if (p_type[1]=="Craftworld") and (obj_controller.known[eFACTION.Eldar]==0) then exit;
        if (vision==0) then exit;

        if (!scr_void_click()) then exit;

        if ((obj_controller.zoomed==0) and (m_dist<20)) or ((obj_controller.zoomed==1) and (m_dist<40)) and (obj_controller.cooldown<=0){
            // This should prevent overlap with fleet object
            if (mouse_x<=self.x+24) and (mouse_y>=self.y-24){

                if (obj_controller.zoomed==1){
                    obj_controller.x=self.x;
                    obj_controller.y=self.y;
                }

                alarm[3]=1;
            }
        }
}
