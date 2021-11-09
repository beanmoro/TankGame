// @description 
remote_port = async_load[? "port"];
remote_ip = string(async_load[? "ip"]);

var buffer = async_load[? "buffer"];
buffer_seek(buffer, buffer_seek_start, 0);
sv_process_packet(buffer, remote_ip, remote_port);