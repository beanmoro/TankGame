/// @description 
if(player.isMoving){

	for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
			
		if(userID != j){
			
			var this_map = ds_map_find_value(net_map, j);
			if(ds_map_exists(this_map, "fast_port")){
				var target_ip = ds_map_find_value(this_map, "ip");
				var target_port = ds_map_find_value(this_map, "fast_port");
			
				buffer_seek(sv_buffer, buffer_seek_start, 0);
				buffer_write(sv_buffer, buffer_u8, CMD.MOVE);
				buffer_write(sv_buffer, buffer_string, userID);
				buffer_write(sv_buffer, buffer_u16, player.x);
				buffer_write(sv_buffer, buffer_u16,	player.y);
				buffer_write(sv_buffer, buffer_u16, player.dir);
				buffer_write(sv_buffer, buffer_u16, player.turret_dir);
				network_send_udp(sv_fast_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
			}
		}
	}
}