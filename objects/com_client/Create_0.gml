/// @description Configuracion del cliente

username = get_string("Username: ","UnnamedPlayer");
userID = ""
ins_map = ds_map_create();

connect_ip = get_string("IP: ","127.0.0.1");

secure_port = 27015;
fast_port = 27016;

connected = false;
fport_confirmed = false;

cl_secure_socket = network_create_socket(network_socket_udp);
cl_fast_socket = network_create_socket(network_socket_udp);
network_set_config(network_config_enable_reliable_udp, cl_secure_socket);

//cl_fast_socket = network_create_socket(network_socket_udp)
randomize();
cl_buffer = buffer_create(1024, buffer_fixed, 1);
player = instance_create_layer(320, 240, "Instances", obj_player);
buffer_seek(cl_buffer, buffer_seek_start, 0);
buffer_write(cl_buffer, buffer_u8, CMD.CONNECT);
buffer_write(cl_buffer, buffer_string, username);
buffer_write(cl_buffer, buffer_u16, obj_player.x);
buffer_write(cl_buffer, buffer_u16, obj_player.y);
buffer_write(cl_buffer, buffer_u16, obj_player.dir);
network_send_udp(cl_secure_socket, connect_ip, secure_port, cl_buffer, buffer_tell(cl_buffer));




