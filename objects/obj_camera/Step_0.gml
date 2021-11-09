/// @description 
move_towards_point(mouse_x, mouse_y, 0);

xTo = follow.x + lengthdir_x(min(max_distance, distance_to_point(mouse_x, mouse_y)), direction);
yTo = follow.y + lengthdir_y(min(max_distance, distance_to_point(mouse_x, mouse_y)), direction);

x+= (xTo - x)/25;
y+= (yTo - y)/25;

var viewmat = matrix_build_lookat(x,y, -300, x,y, 0, 0, 1, 0);
camera_set_view_mat(camera, viewmat);