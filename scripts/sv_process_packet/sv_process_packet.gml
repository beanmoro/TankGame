function sv_process_packet(argument0, argument1, argument2) {
	var buffer = argument0;
	var ip = argument1;
	var port = argument2;
	var msg_id = buffer_read(buffer, buffer_u8);


	switch(msg_id){

		case CMD.CONNECT:
		
			var _username = buffer_read(buffer, buffer_string);
			var _x = buffer_read(buffer, buffer_u16);
			var _y = buffer_read(buffer, buffer_u16);
			var _dir = buffer_read(buffer, buffer_u16);
		
		
			var _userid = _username+"_"+string(port);
			var new_username = username_exists(net_map, _username);
			var this_map = ds_map_create();
			ds_map_add(this_map, "ip", ip);
			ds_map_add(this_map, "secure_port", port);
			ds_map_add(this_map, "username", new_username);
			ds_map_add_map(net_map, _userid, this_map);
		
		
			var _player = instance_create_layer(_x, _y, "Instances", obj_puppet);
			_player.image_angle = _dir;
			_player.username = new_username;
			_player.userID = _userid;
			ds_map_add(ins_map, _userid, _player); // Guardar instancia en el mapa de instancias
		

			show_debug_message("Se ha conectado cliente: "+_userid);
			buffer_seek(sv_buffer, buffer_seek_start, 0);
			buffer_write(sv_buffer, buffer_u8, CMD.ID);
			buffer_write(sv_buffer, buffer_string, _userid);
			network_send_udp(sv_secure_socket, ip, port, sv_buffer, buffer_tell(sv_buffer));
		
		
			for(var i = ds_map_find_first(ins_map); !is_undefined(i); i = ds_map_find_next(ins_map, i)){
			
				if(i !=  _userid){
					var _puppet = ds_map_find_value(ins_map, i);
			
					buffer_seek(sv_buffer, buffer_seek_start, 0);
					buffer_write(sv_buffer, buffer_u8, CMD.SPAWN);
					buffer_write(sv_buffer, buffer_string, i);
					buffer_write(sv_buffer, buffer_string, _puppet.username)
					buffer_write(sv_buffer, buffer_u16, _puppet.x);
					buffer_write(sv_buffer, buffer_u16, _puppet.y);
					buffer_write(sv_buffer, buffer_u16, _puppet.image_angle);
					network_send_udp(sv_secure_socket, ip, port, sv_buffer, buffer_tell(sv_buffer));
				}
			}
			for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
			
				if(_userid != j && userID != j){
				
					var this_map = ds_map_find_value(net_map, j);
					var target_ip = ds_map_find_value(this_map, "ip");
					var target_port = ds_map_find_value(this_map, "secure_port");
				
					buffer_seek(sv_buffer, buffer_seek_start, 0);
					buffer_write(sv_buffer, buffer_u8, CMD.SPAWN);
					buffer_write(sv_buffer, buffer_string, _userid);
					buffer_write(sv_buffer, buffer_string, _player.username)
					buffer_write(sv_buffer, buffer_u16, _player.x);
					buffer_write(sv_buffer, buffer_u16, _player.y);
					buffer_write(sv_buffer, buffer_u16, _player.image_angle);
					network_send_udp(sv_secure_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
				}
			}
			break;
		
		case CMD.DISCONNECT:
		
			var _userid = buffer_read(buffer, buffer_string);
			_player = ds_map_find_value(ins_map, _userid);
			ds_map_delete(net_map, _userid);
			instance_destroy(_player);
			ds_map_delete(ins_map, _userid);
		
		
		
			for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
			
				if(_userid != j && userID != j){
				
					var this_map = ds_map_find_value(net_map, j);
					var target_ip = ds_map_find_value(this_map, "ip");
					var target_port = ds_map_find_value(this_map, "secure_port");
				
					buffer_seek(sv_buffer, buffer_seek_start, 0);
					buffer_write(sv_buffer, buffer_u8, CMD.DESPAWN);
					buffer_write(sv_buffer, buffer_string, _userid);
					network_send_udp(sv_secure_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
				}
			}
		
		
			show_debug_message("Se ha desconectado cliente: "+_userid);
		
			break;
		
		
		case CMD.MOVE:
	
			var _userid = buffer_read(buffer, buffer_string)
			var _x = buffer_read(buffer, buffer_u16);
			var _y = buffer_read(buffer, buffer_u16);
			var _dir = buffer_read(buffer, buffer_u16);
			var _turret_dir = buffer_read(buffer, buffer_u16);
		
		
			var _puppet = ds_map_find_value(ins_map, _userid);
			_puppet.x = _x;
			_puppet.y = _y;
			_puppet.image_angle = _dir;
			_puppet.turret_dir = _turret_dir;
		
			for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
				if(_userid != j && userID != j){
				
					var this_map = ds_map_find_value(net_map, j);
					if(ds_map_exists(this_map, "fast_port")){
						var target_ip = ds_map_find_value(this_map, "ip");
						var target_port = ds_map_find_value(this_map, "fast_port");
				
						buffer_seek(sv_buffer, buffer_seek_start, 0);
						buffer_write(sv_buffer, buffer_u8, CMD.MOVE);
						buffer_write(sv_buffer, buffer_string, _userid);
						buffer_write(sv_buffer, buffer_u16, _x);
						buffer_write(sv_buffer, buffer_u16, _y);
						buffer_write(sv_buffer, buffer_u16, _dir);
						buffer_write(sv_buffer, buffer_u16, _turret_dir);
						network_send_udp(sv_fast_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
					}
				}
			}
			break
		
		case CMD.SYNC:
			var _userid = buffer_read(buffer, buffer_string);
			var this_map = ds_map_find_value(net_map, _userid);
		
			if(!ds_map_exists(this_map, "fast_port")){
				ds_map_add(this_map, "fast_port", port);
			}
		
			buffer_seek(sv_buffer, buffer_seek_start, 0);
			buffer_write(sv_buffer, buffer_u8, CMD.SYNC);
		
		
			var target_ip = ds_map_find_value(this_map, "ip");
			var target_port = ds_map_find_value(this_map, "secure_port");
			show_debug_message(_userid+": "+target_ip+":"+string(target_port));
			network_send_udp(sv_secure_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
			break;
		
		case CMD.SHOOT:
			var _userid = buffer_read(buffer, buffer_string);
			var _canonX = buffer_read(buffer, buffer_u16);
			var _canonY = buffer_read(buffer, buffer_u16);
			var _turret_dir = buffer_read(buffer, buffer_u16);
		
		
			var _shooter = ds_map_find_value(ins_map, _userid);
		
		
			var bullet = instance_create_layer(_canonX, _canonY, "Instances", obj_bullet);
			bullet.dir = _turret_dir;
			bullet.shooter = _shooter;
			break;
	
		
	}


}
