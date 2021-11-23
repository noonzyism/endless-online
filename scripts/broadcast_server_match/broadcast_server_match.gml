function broadcast_server_match(argument0) {
	//sends a MATCH message about the host to all clients
	//only the server/host should call this function

	var _session	= argument0;
	
	var i = 1;

	show_debug_message("About to send clients host MATCH update...");

	while (ctrl_server.clients[i, 0] != -1) {
		show_debug_message("Sending clients host MATCH update: sending to socket=" + string(ctrl_server.clients[i, 2]) + " for client " + string(i) + "...");
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.MATCH, 0, obj_player.username, obj_player.team, obj_player.matchscore, obj_player.kills, obj_player.deaths, obj_player.objhold);
		i++;
	}


}
