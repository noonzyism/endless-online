// this is a test object for the sole purpose of delaying packet sends for testing purposes
/* format:
		packet[0] = timer;
		packet[1] = _session;
		packet[2] = _socket;
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
*/
sync_packets = ds_list_create();



/* format:
		packet[0] = timer;
		packet[1] = _session;
		packet[2] = _socket;
		packet[3] = _cid;
		packet[4] = _ticks;
		packet[5] = xspeed;
		packet[6] = yspeed;
		packet[7] = weapon;
		packet[8] = shooting;
		packet[9] = aimx;
		packet[10] = aimy;
*/
state_packets = ds_list_create();
