/// @description 

if (keyboard_check(vk_f1) && !is_server && !network_done){
	show_message("Creando servidor!");
	instance_create_depth(0, 0, depth, com_server);
	//room_goto(host_room);
	global.main_is = GAME_NET.SERVER;
	is_server = true;
	network_done = true;
}else if(keyboard_check(vk_f2) && !is_client  && !network_done){
	show_message("Creando cliente!");
	instance_create_depth(0, 0, depth, com_client);
	//room_goto(client_room);
	global.main_is = GAME_NET.CLIENT;
	is_client = true;
	network_done = true;
}

