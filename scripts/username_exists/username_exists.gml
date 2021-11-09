function username_exists(argument0, argument1) {
	var sc_map = argument0;
	var sc_username = argument1;

	var matchCounter = 0;
	for(var j = ds_map_find_first(sc_map); !is_undefined(j); j = ds_map_find_next(sc_map, j)){
		var tmap = ds_map_find_value(sc_map, j);
		var tuser = ds_map_find_value(tmap, "username");
		var tlength = string_length(sc_username);
			
		if(string_delete(tuser, tlength+1, 3) == sc_username){
			matchCounter++;
		}
	}
		
	if(matchCounter > 0){
		return sc_username+"("+string(matchCounter)+")";
	}else{
		return sc_username;
	}




}
