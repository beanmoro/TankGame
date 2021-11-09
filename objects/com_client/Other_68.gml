/// @description 
var buffer = async_load[? "buffer"];

buffer_seek(buffer, buffer_seek_start, 0);
cl_process_packet(buffer);