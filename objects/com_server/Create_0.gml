// @description Configuracion Servidor

secure_port = 27015;
fast_port = 27016;
var max_clients = 12;
sv_secure_socket = network_create_socket_ext(network_socket_udp, secure_port);
sv_fast_socket = network_create_socket_ext(network_socket_udp, fast_port);
network_set_config(network_config_enable_reliable_udp, sv_secure_socket);

username = get_string("Username: ","host");
userID = username+"_0";

remote_port = 0;
remote_ip = "0.0.0.0"

//sv_fast_socket = network_create_socket_ext(network_socket_udp, port_1);



sv_buffer = buffer_create(1024, buffer_fixed, 1);
//socket_list = ds_list_create();

net_map = ds_map_create();
ins_map = ds_map_create();
randomize();
player = instance_create_layer(320, 240, "Instances", obj_player);
player.username = username;
player.userID = userID;
var this_map = ds_map_create();
ds_map_add(this_map, "ip", "0.0.0.0");
ds_map_add(this_map, "secure_port", 0);
ds_map_add(this_map, "fast_port", 0);
ds_map_add(this_map, "username", username);
ds_map_add_map(net_map, userID, this_map);
ds_map_add(ins_map, userID, player);

show_debug_message(userID);

show_message("Servidor creado!");