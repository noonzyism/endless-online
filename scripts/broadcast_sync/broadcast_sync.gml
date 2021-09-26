function broadcast_sync(_session, _cid, _ticks) {
	//sends a sync message about the given client to all clients
	
	var i = 1;

	var peer = ctrl_server.clients[_cid, 0];

	while (ctrl_server.clients[i, 0] != -1) {
		//netplay_send(_session, ctrl_server.clients[i, 2], Packets.SYNC, _cid, _ticks, peer.hp, peer.x, peer.y, peer.xspeed, peer.yspeed, peer.weapon, peer.shooting, peer.aimx, peer.aimy);
		// temporary delayed sending for testing
		packet[0] = 0;
		packet[1] = _session;
		packet[2] = ctrl_server.clients[i, 2];
		packet[3] = _cid;
		packet[4] = _ticks;
		packet[5] = peer.hp;
		packet[6] = peer.x;
		packet[7] = peer.y;
		packet[8] = peer.xspeed;
		packet[9] = peer.yspeed;
		packet[10] = peer.weapon;
		packet[11] = peer.shooting;
		packet[12] = peer.aimx;
		packet[13] = peer.aimy;
		ds_list_add(ctrl_delayer.sync_packets, packet);
		i++;
	}


}
