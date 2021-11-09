/// @description 
buffer_seek(cl_buffer, buffer_seek_start, 0);
buffer_write(cl_buffer, buffer_u8, CMD.DISCONNECT);
buffer_write(cl_buffer, buffer_string, userID);
network_send_udp(cl_secure_socket, connect_ip, secure_port, cl_buffer, buffer_tell(cl_buffer));
