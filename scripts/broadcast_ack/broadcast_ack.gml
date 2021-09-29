function send_ack(_session, _cid, _ticks) {
	//sends an ack message back to a given client with latest sync info
	var peer = ctrl_server.clients[_cid, 0];
	netplay_send(_session, ctrl_server.clients[_cid, 2], Packets.ACK, _cid, _ticks, peer.hp, peer.x, peer.y, peer.xspeed, peer.yspeed, peer.weapon, peer.shooting, peer.aimx, peer.aimy);
}
