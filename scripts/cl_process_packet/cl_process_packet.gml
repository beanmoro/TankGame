function cl_process_packet(argument0) {
	var buffer = argument0;
	var msg_id = buffer_read(buffer, buffer_u8);

	switch(msg_id){

		/*case CMD.CONNECT:
			userid = buffer_read(buffer, buffer_u8);
		
			show_message(userid);
			break;*/

		case CMD.MESSAGE:
			var text = buffer_read(buffer, buffer_string);
			show_message(text);
			break;
		
		case CMD.SPAWN:
		
			var _userid = buffer_read(buffer, buffer_string);
			var _username = buffer_read(buffer, buffer_string);
			var _x = buffer_read(buffer, buffer_u16);
			var _y = buffer_read(buffer, buffer_u16);
			var _dir = buffer_read(buffer, buffer_u16);
		
			var _puppet = instance_create_layer(_x, _y, "Instances", obj_puppet);
			_puppet.image_angle = _dir;
			_puppet.username = _username;
			ds_map_add(ins_map, _userid, _puppet);
			break;
		
		case CMD.DESPAWN:
	
			var _userid = buffer_read(buffer, buffer_string);
			var _puppet = ds_map_find_value(ins_map, _userid);
			instance_destroy(_puppet);
			ds_map_delete(ins_map, _userid);
			break;
		
		case CMD.MOVE:
			var _userid = buffer_read(buffer, buffer_string);
			var _x = buffer_read(buffer, buffer_u16);
			var _y = buffer_read(buffer, buffer_u16);
			var _dir = buffer_read(buffer, buffer_u16);
			var _turret_dir = buffer_read(buffer, buffer_u16);
		
			var _puppet = ds_map_find_value(ins_map, _userid);
			_puppet.x = _x;
			_puppet.y = _y;
			_puppet.image_angle = _dir;
			_puppet.turret_dir = _turret_dir;
			break;
	
		case CMD.ID:
			userID = buffer_read(buffer, buffer_string);
			show_message("Mi id es: "+userID);
			connected = true;
			break;
		
		case CMD.SYNC:
			fport_confirmed = true;
			break;
	
		case CMD.SHOOT:
			var _hitX = buffer_read(buffer, buffer_u16);
			var _hitY = buffer_read(buffer, buffer_u16);
			var _startX = buffer_read(buffer, buffer_u16);
			var _startY = buffer_read(buffer, buffer_u16);
			var _dir = buffer_read(buffer, buffer_u16);
		
			var effect = instance_create_layer(_startX, _startY, "Instances", obj_bullet_effect);
			effect.dir = _dir;
			effect.startX = _startX;
			effect.startY = _startY;
			effect.endX = _hitX;
			effect.endY = _hitY;
			instance_create_layer(_hitX, _hitY, "Instances", obj_explotion);
			break;
		
		case CMD.HIT:
		
			var _userid = buffer_read(buffer, buffer_string);
			var _hp = buffer_read(buffer, buffer_u8);
		
			if userID == _userid {
				obj_player.hp = _hp;
			}else{
				var _puppet = ds_map_find_value(ins_map, _userid);
				_puppet.hp = _hp;
			}
		
		
			break;
	
	
	}


}
