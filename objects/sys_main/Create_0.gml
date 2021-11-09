/// @description 
enum CMD{

	CONNECT,
	DISCONNECT,
	MESSAGE,
	SPAWN,
	DESPAWN,
	MOVE,
	ID,
	SYNC,
	SHOOT,
	HIT
}

enum GAME_NET{
	
	UNDEF,
	SERVER,
	CLIENT
}


global.main_is = GAME_NET.UNDEF;
is_server = false;
is_client = false;
network_done = false;