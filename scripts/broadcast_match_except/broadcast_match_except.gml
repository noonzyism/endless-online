function broadcast_match_except(argument0, argument1, argument2) {
	//sends a sync message about the given client to all clients except the one on the given socket
	var _session		= argument0,
		_cid			= argument1,
		_excludeSocket	= argument2;
	
	var i = 1;

	var peer = ctrl_server.clients[_cid, 0];

	while (ctrl_server.clients[i, 0] != -1) {
		if (ctrl_server.clients[i, 2] != _excludeSocket) {
			netplay_send(_session, ctrl_server.clients[i, 2], Packets.MATCH, _cid, peer.username, peer.team, peer.matchscore, peer.kills, peer.deaths, peer.objhold);
		}
		i++;
	}


}
