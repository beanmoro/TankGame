/// @description 
follow = obj_player;
xTo = x;
yTo = y;
max_distance = 128;


camera = camera_create();

var viewmat = matrix_build_lookat(x,y, -200, x,y, 0, 0, 1, 0);
var projmat = matrix_build_projection_ortho(320, 240, 1.0, 320000.0);

camera_set_view_mat(camera, viewmat);
camera_set_proj_mat(camera, projmat);


view_camera[0] = camera;