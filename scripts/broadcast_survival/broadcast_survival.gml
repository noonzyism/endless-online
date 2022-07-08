function broadcast_survival_task(_session, _taskdesc, _tasklife, _taskstate) {
	// informs all clients about a new task
	
	var i = 1;

	show_debug_message("Sending SURVIVAL_TASK update...");

	while (ctrl_server.clients[i, 0] != -1) {
		//show_debug_message("Sending clients SURVIVAL_TASK update: sending to socket=" + string(ctrl_server.clients[i, 2]) + " for client " + string(i) + "...");
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.SURVIVAL_TASK, 
			ctrl_match_survival.mainframe_health,
			_taskdesc,
			_tasklife,
			_taskstate
		);
		i++;
	}
}

function broadcast_survival_mob(_session, _iscreate, _mobtype, _mobtarget, _mobx, _moby, _mobspeed, _mobcount) {
	// informs all clients about a new mob
	
	var i = 1;

	show_debug_message("Sending SURVIVAL_MOB update...");

	while (ctrl_server.clients[i, 0] != -1) {
		//show_debug_message("Sending clients SURVIVAL_MOB update: sending to socket=" + string(ctrl_server.clients[i, 2]) + " for client " + string(i) + "...");
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.SURVIVAL_MOB, 
			ctrl_match_survival.mainframe_health,
			_iscreate,
			_mobtype,
			_mobtarget,
			_mobx,
			_moby,
			_mobspeed,
			_mobcount
		);
		i++;
	}
}

function broadcast_survival_keys(_session) {
	// informs all clients about the current keys
	
	var i = 1;

	show_debug_message("Sending SURVIVAL_KEYS update...");

	while (ctrl_server.clients[i, 0] != -1) {
		//show_debug_message("Sending clients SURVIVAL_KEYS update: sending to socket=" + string(ctrl_server.clients[i, 2]) + " for client " + string(i) + "...");
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.SURVIVAL_KEYS, 
			ctrl_match_survival.mainframe_health,
			ctrl_match_survival.alpha_key,
			ctrl_match_survival.delta_key,
			ctrl_match_survival.sigma_key,
			ctrl_match_survival.omega_key
		);
		i++;
	}
}