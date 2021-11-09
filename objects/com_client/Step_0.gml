/// @description 
if(player.isMoving && userID != ""){
	
	buffer_seek(cl_buffer, buffer_seek_start, 0);
	buffer_write(cl_buffer, buffer_u8, CMD.MOVE);
	buffer_write(cl_buffer, buffer_string, userID);
	buffer_write(cl_buffer, buffer_u16, player.x);
	buffer_write(cl_buffer, buffer_u16, player.y);
	buffer_write(cl_buffer, buffer_u16, player.dir);
	buffer_write(cl_buffer, buffer_u16, player.turret_dir);
	network_send_udp(cl_fast_socket, connect_ip, fast_port, cl_buffer, buffer_tell(cl_buffer));
}



if(connected && !fport_confirmed){
	buffer_seek(cl_buffer, buffer_seek_start, 0);
	buffer_write(cl_buffer, buffer_u8, CMD.SYNC);
	buffer_write(cl_buffer, buffer_string, userID);
	network_send_udp(cl_fast_socket, connect_ip, fast_port, cl_buffer, buffer_tell(cl_buffer));
}
/*
if(obj_player.shoot && obj_player.alarm[0] > 0 && userID != ""){
	buffer_seek(cl_buffer, buffer_seek_start, 0);
	buffer_write(cl_buffer, buffer_u8, CMD.SHOOT);
	buffer_write(cl_buffer, buffer_string, userID);
	buffer_write(cl_buffer, buffer_u16, obj_player.canonX);
	buffer_write(cl_buffer, buffer_u16, obj_player.canonY);
	buffer_write(cl_buffer, buffer_u16, obj_player.turret_dir);
	network_send_udp(cl_secure_socket, connect_ip, secure_port, cl_buffer, buffer_tell(cl_buffer));
	
}*/