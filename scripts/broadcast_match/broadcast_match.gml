function broadcast_match(argument0, argument1) {
	//sends a sync message about the given client to all clients
	var _session	= argument0,
		_cid		= argument1;
	
	var i = 1;

	var peer = ctrl_server.clients[_cid, 0];

	while (ctrl_server.clients[i, 0] != -1) {
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.MATCH, _cid, peer.username, peer.team, peer.matchscore, peer.kills, peer.deaths, peer.objhold);
		i++;
	}


}
