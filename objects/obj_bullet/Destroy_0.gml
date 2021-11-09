/// @description 

var _ins_hitted = "";

var _hitX = x;
var _hitY = y;

var _startX = startX;
var _startY = startY;
var _dir = dir;

if instance_hitted != noone {
	if instance_hitted.object_index == obj_puppet || instance_hitted.object_index == obj_player {
		_ins_hitted = instance_hitted.userID;
		show_debug_message(_ins_hitted);
		var _ins = ds_map_find_value(com_server.ins_map, _ins_hitted);
		if _ins.hp > 0 {
			_ins.hp -= 10;
		}
	
	}
}


with(com_server){

	for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
	
		if(userID != j){ // Evitamos reenviarselo al servidor, ya que el host ya conoce la situacion
			
			var this_map = ds_map_find_value(net_map, j);
			var target_ip = ds_map_find_value(this_map, "ip");
			var target_port = ds_map_find_value(this_map, "secure_port");
			
			
			buffer_seek(sv_buffer, buffer_seek_start, 0);
			buffer_write(sv_buffer, buffer_u8, CMD.SHOOT);	
			buffer_write(sv_buffer, buffer_u16, _hitX);
			buffer_write(sv_buffer, buffer_u16, _hitY);
			buffer_write(sv_buffer, buffer_u16, _startX);
			buffer_write(sv_buffer, buffer_u16, _startY);
			buffer_write(sv_buffer, buffer_u16,	_dir);
			network_send_udp(sv_secure_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
			
		}
	}
	
	if (_ins_hitted != "") {
		for(var j = ds_map_find_first(net_map); !is_undefined(j); j = ds_map_find_next(net_map, j)){
	
			if(userID != j){ // Evitamos reenviarselo al servidor, ya que el host ya conoce la situacion
			
				var this_map = ds_map_find_value(net_map, j);
				var target_ip = ds_map_find_value(this_map, "ip");
				var target_port = ds_map_find_value(this_map, "secure_port");
			
			
				buffer_seek(sv_buffer, buffer_seek_start, 0);
				buffer_write(sv_buffer, buffer_u8, CMD.HIT);	
				buffer_write(sv_buffer, buffer_string, _ins_hitted);
				buffer_write(sv_buffer, buffer_u8, _ins.hp);
				network_send_udp(sv_secure_socket, target_ip, target_port, sv_buffer, buffer_tell(sv_buffer));
			
			}
		}
	}
	
}

var effect = instance_create_layer(x, y, "Instances", obj_bullet_effect);
effect.dir = dir;
effect.startX = startX;
effect.startY = startY;
effect.endX = _hitX;
effect.endY = _hitY;
instance_create_layer(x, y, "Instances", obj_explotion);