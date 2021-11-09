/// @description 
draw_text(8, 440,"HP: "+string(hp));
//draw_set_color(c_red);
//draw_rectangle(x-32,y-32, x+32, y-30, false);
//draw_set_color(c_lime);
//draw_rectangle(x-32,y-32, x+(32*(hp/100)), y-30, false);
//draw_set_color(c_white);
draw_healthbar(8, 465, 256, 475, hp, c_red, c_lime, c_lime, 0, true, true);