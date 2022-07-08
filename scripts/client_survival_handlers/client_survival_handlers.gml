function client_survival_task_handler() {
	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];
		
	var _mainframe_health	= _values[0];
	var _task_description	= _values[1];
	var _task_life			= _values[2];
	var _task_state			= _values[3];
	
	show_debug_message("[CLIENT] Received SURVIVAL_TASK event.");
	ctrl_match_survival.mainframe_health = _mainframe_health;
	
	// TODO: just overriding description for now, but this should fully override the create event of the task
	var task = instance_create_depth(x, y, 0, obj_task);
	task.description = _task_description; 
	task.alarm[0] = _task_life;
}

function client_survival_mob_handler() {
	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];
		
	var _mainframe_health	= _values[0];
	var _is_create			= _values[1];
	var _mob_type			= _values[2];
	var _mob_target			= _values[3];
	var _mob_x				= _values[4];
	var _mob_y				= _values[5];
	var _mob_speed			= _values[6];
	var _mob_count			= _values[7];
		
	show_debug_message("[CLIENT] Received SURVIVAL_MOB event.");
	ctrl_match_survival.mainframe_health = _mainframe_health;
	
	// TODO: assuming/ignoring mob type for now
	if (_is_create || _mob_count > instance_number(obj_ghost)) {
		var mob = instance_create_depth(_mob_x, _mob_y, 0, obj_ghost);
	}
	else {
		var mob = instance_nearest(_mob_x, _mob_y, par_mob);
		if (mob != noone) {
			mob.teleport_x = _mob_x;
			mob.teleport_y = _mob_y;
		}
	}
	if (_mob_target == clientId) {
		mob.target = obj_player;
	}
	else {
		mob.target = ctrl_client.peers[_mob_target];
	}
	mob.speed = _mob_speed;
}

function client_survival_keys_handler() {
	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];
		
	var _mainframe_health	= _values[0];
	var _alpha_key			= _values[1];
	var _delta_key			= _values[2];
	var _sigma_key			= _values[3];
	var _omega_key			= _values[4];
	
	show_debug_message("[CLIENT] Received SURVIVAL_KEYS event.");
	ctrl_match_survival.mainframe_health = _mainframe_health;
	ctrl_match_survival.alpha_key = _alpha_key;
	ctrl_match_survival.delta_key = _delta_key;
	ctrl_match_survival.sigma_key = _sigma_key;
	ctrl_match_survival.omega_key = _omega_key;
}