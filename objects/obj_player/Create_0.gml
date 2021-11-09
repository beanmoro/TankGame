/// @description 
username = "";
randomize();
dir = random(360);
vel = 0;
vel_limit = 5;
fric_thershold = 0.01;
spd = 1;
rot_spd = 2;
isMoving = false;
turret_dir = 0;
old_turret_dir = 0;
width = 16;
height = 10;
front_offset = 0;
rot_offset = 0;
shoot = false;
canonX = 0;
canonY = 0;
userID = "";
hp = 100


//camara

instance_create_layer(x,y, "Instances", obj_camera);