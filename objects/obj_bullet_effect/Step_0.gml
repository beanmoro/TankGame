/// @description 

if abs(point_distance(startX, startY, endX, endY)) > spd{
	startX += lengthdir_x(spd, dir);
	startY += lengthdir_y(spd, dir);
}else{
	instance_destroy();
}

if wdth > 1 {
	wdth -= 0.25;
}

if alpha > 0 {
	alpha -= 0.05;
}