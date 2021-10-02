function broadcast_sync(_session, _cid, _ticks, _force) {
	//sends a sync message about the given client to all clients
	
	var i = 1;

	var peer = ctrl_server.clients[_cid, 0];

	while (ctrl_server.clients[i, 0] != -1) {
		netplay_send(_session, ctrl_server.clients[i, 2], Packets.SYNC, _cid, _ticks, max(0, peer.hp), peer.x, peer.y, peer.xspeed, peer.yspeed, peer.weapon, peer.shooting, peer.aimx, peer.aimy, _force);
		i++;
	}


}
