/// @description 
draw_self();
draw_sprite_ext(spr_tank_turret, 0, x, y, 1, 1, turret_dir, c_white, image_alpha);

draw_point_color(canonX, canonY, c_red);
/*
draw_line(x,y, x+lengthdir_x(width,dir), y+lengthdir_y(width,dir));
draw_line(x,y, x+lengthdir_x(-width,dir), y+lengthdir_y(-width,dir));

draw_line(x+lengthdir_x(height,dir+90),y+lengthdir_y(height,dir+90), x+lengthdir_x(height,dir+90)+lengthdir_x(width,dir), y+lengthdir_y(height,dir+90)+lengthdir_y(width,dir));
draw_line(x+lengthdir_x(height,dir+90),y+lengthdir_y(height,dir+90), x+lengthdir_x(height,dir+90)+lengthdir_x(-width,dir), y+lengthdir_y(height,dir+90)+lengthdir_y(-width,dir));

draw_line(x+lengthdir_x(height,dir-90),y+lengthdir_y(height,dir-90), x+lengthdir_x(height,dir-90)+lengthdir_x(width,dir), y+lengthdir_y(height,dir-90)+lengthdir_y(width,dir));
draw_line(x+lengthdir_x(height,dir-90),y+lengthdir_y(height,dir-90), x+lengthdir_x(height,dir-90)+lengthdir_x(-width,dir), y+lengthdir_y(height,dir-90)+lengthdir_y(-width,dir));

draw_set_color(c_blue);
draw_line(x+lengthdir_x(width, dir), y+lengthdir_y(width, dir), x+lengthdir_x(width, dir)+lengthdir_x(height+4, dir-90), y+lengthdir_y(width, dir)+lengthdir_y(height+4,dir-90));
draw_line(x+lengthdir_x(-width, dir), y+lengthdir_y(-width, dir), x+lengthdir_x(-width, dir)+lengthdir_x(height+4, dir-90), y+lengthdir_y(-width, dir)+lengthdir_y(height+4,dir-90));
draw_set_color(c_red);
draw_line(x+lengthdir_x(width, dir), y+lengthdir_y(width, dir), x+lengthdir_x(width, dir)+lengthdir_x(-height-4, dir-90), y+lengthdir_y(width, dir)+lengthdir_y(-height-4,dir-90));
draw_line(x+lengthdir_x(-width, dir), y+lengthdir_y(-width, dir), x+lengthdir_x(-width, dir)+lengthdir_x(-height-4, dir-90), y+lengthdir_y(-width, dir)+lengthdir_y(-height-4,dir-90));
draw_set_color(c_white);
*/
image_angle = dir;