/// @description 
draw_self();
draw_sprite_ext(spr_tank_turret, 0, x, y, 1, 1, turret_dir, c_white, image_alpha);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(view_xview[0]+x,view_yview[0]+y-48,username);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_healthbar(view_xview[0]+x-32, view_yview[0]+y-32, view_xview[0]+x+32, view_yview[0]+y-30, hp, c_red, c_lime, c_lime, 0, true, true);