/// @description 


instance_hitted = shoot_bullet(obj_solid, shooter);

if(point_distance(startX, startY, x, y) > max_distance){
	instance_destroy();
}

if(instance_hitted != noone && instance_hitted.object_index != shooter){
	instance_destroy();
}
