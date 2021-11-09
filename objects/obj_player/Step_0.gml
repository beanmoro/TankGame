/// @description 

bLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
bUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
bRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
bDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
mLeft = mouse_check_button(mb_left);

turret_dir = point_direction(x, y, mouse_x, mouse_y);

//Limite de velocidad
if( bUp || bDown){
	if (vel < vel_limit && vel > -vel_limit){
		vel += (bUp - bDown) * spd;
	}else{
		vel = (bUp - bDown) * vel_limit;
	}
	isMoving = true
}


//Friccion
if(!bUp && !bDown){
	if ( vel > fric_thershold || vel < -fric_thershold){
		vel *= 0.9;
	}else if(vel < fric_thershold && vel > -fric_thershold){
		vel = 0;
		isMoving = false;
	}
}

//Control de Direccion

if(bLeft || bRight){
	isMoving = true;
}

if(old_turret_dir != turret_dir){
	
	isMoving = true;
}


//Limite de angulo
if (dir > 360){
	dir = 0;
}else if(dir < 0){
	dir = 360;
}



//Limites del escenario (Truco de escenario infinito)
if(x < -32){ x = room_width+32; }
if(x > room_width+32){ x = -32; }

if(y < -32){ y = room_height+32; }
if(y > room_height+32){ y = -32; }

//Aplicacion de movimiento y collision

//rotacion
if(	bRight 
	&& !collision_line(x+lengthdir_x(width, dir), y+lengthdir_y(width, dir), x+lengthdir_x(width, dir)+lengthdir_x(height+rot_offset, dir-90), y+lengthdir_y(width, dir)+lengthdir_y(height+rot_offset,dir-90), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(-width, dir), y+lengthdir_y(-width, dir), x+lengthdir_x(-width, dir)+lengthdir_x(-height-rot_offset, dir-90), y+lengthdir_y(-width, dir)+lengthdir_y(-height-rot_offset,dir-90), obj_solid, true, true)
	|| bLeft
	&& !collision_line(x+lengthdir_x(width, dir), y+lengthdir_y(width, dir), x+lengthdir_x(width, dir)+lengthdir_x(-height-rot_offset, dir-90), y+lengthdir_y(width, dir)+lengthdir_y(-height-rot_offset,dir-90), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(-width, dir), y+lengthdir_y(-width, dir), x+lengthdir_x(-width, dir)+lengthdir_x(height+rot_offset, dir-90), y+lengthdir_y(-width, dir)+lengthdir_y(height+rot_offset,dir-90), obj_solid, true, true)
	){
	dir += (bLeft - bRight) * rot_spd;
}

//avance
if (vel > 0 
	&& !collision_line(x,y, x+lengthdir_x(width+front_offset,dir), y+lengthdir_y(width+front_offset,dir), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(height,dir+90), y+lengthdir_y(height,dir+90), x+lengthdir_x(height,dir+90)+lengthdir_x(width+front_offset,dir), y+lengthdir_y(height,dir+90)+lengthdir_y(width+front_offset,dir), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(height,dir-90), y+lengthdir_y(height,dir-90), x+lengthdir_x(height,dir-90)+lengthdir_x(width+front_offset,dir), y+lengthdir_y(height,dir-90)+lengthdir_y(width+front_offset,dir), obj_solid, true, true)
	|| vel < 0 
	&& !collision_line(x,y, x+lengthdir_x(-width-front_offset,dir), y+lengthdir_y(-width-front_offset,dir), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(height,dir+90), y+lengthdir_y(height,dir+90), x+lengthdir_x(height,dir+90)+lengthdir_x(-width-front_offset,dir), y+lengthdir_y(height,dir+90)+lengthdir_y(-width-front_offset,dir), obj_solid, true, true)
	&& !collision_line(x+lengthdir_x(height,dir-90), y+lengthdir_y(height,dir-90), x+lengthdir_x(height,dir-90)+lengthdir_x(-width-front_offset,dir), y+lengthdir_y(height,dir-90)+lengthdir_y(-width-front_offset,dir), obj_solid, true, true)
	){
	x+= lengthdir_x(vel, dir);
	y+= lengthdir_y(vel, dir);
}


//CanonX&Y
canonX = x+lengthdir_x(28,turret_dir);
canonY = y+lengthdir_y(28,turret_dir);

//disparo

if(mLeft && !shoot){
	
	switch(global.main_is){
	
		case GAME_NET.SERVER:
			var bullet = instance_create_layer(canonX, canonY, "Instances", obj_bullet);
			bullet.dir = turret_dir;
			break;
		case GAME_NET.CLIENT:
			with(com_client){
				if(userID != ""){
					buffer_seek(cl_buffer, buffer_seek_start, 0);
					buffer_write(cl_buffer, buffer_u8, CMD.SHOOT);
					buffer_write(cl_buffer, buffer_string, userID);
					buffer_write(cl_buffer, buffer_u16, obj_player.canonX);
					buffer_write(cl_buffer, buffer_u16, obj_player.canonY);
					buffer_write(cl_buffer, buffer_u16, obj_player.turret_dir);
					network_send_udp(cl_secure_socket, connect_ip, secure_port, cl_buffer, buffer_tell(cl_buffer));
				}
			}
			break;
	
	}
	alarm[0] = 0.25*room_speed;
	shoot = true;
}

