/// shoot_bullet(to)
/// @description Funcion para ver si la bala impacto en algo
/// @param0 to Objeto en el que deberia impactar
function shoot_bullet(argument0, argument1) {

	var solidObject = argument0;
	var ignoreObject = argument1;


	var counter = 0;
	var collided = noone;
	while( (!collision_point(x,y, solidObject, true, true) || collision_point(x,y, solidObject, true, true) == ignoreObject) && counter <= spd ){
		x += lengthdir_x(1, dir)
		y += lengthdir_y(1, dir)
	
	
		collided = collision_point(x,y, solidObject, true, true);
		if collided != noone{
			hit = true;
			hitX = x
			hitY = y
			return collided;
		}
	
		counter++
	}
	return noone;



}
