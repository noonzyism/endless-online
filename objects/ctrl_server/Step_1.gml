// Authoritative Game Updates
if (obj_player.hp <= 0) {
	// for now...
	obj_player.x = 128;
	obj_player.y = 128;
	obj_player.hp = 100;
	obj_player.deaths += 1;
	if (obj_player.foe != -1) obj_player.foe.kills +=1;
	var i = 1;
	while (clients[i, 0] != -1) {
		broadcast_match(session, i);
		i++;
	}
	broadcast_server_match(session);
	// sync will be sent in the step event
	//broadcast_server_sync(session);
	/*
	obj_player.x = -1000;
	obj_player.y = -1000;
	obj_player.respawn = true;
	obj_player.alarm[1] = 60; // this timer will reset HP and spawn them back
	*/
}

var i = 1;
while (clients[i, 0] != -1) {
	var peer = clients[i, 0];
	if (peer.hp <= 0) {
		peer.x = 128;
		peer.y = 128;
		peer.hp = 100;
		peer.deaths += 1;
		if (peer.foe != -1) peer.foe.kills +=1;
		broadcast_match(session, i);
		broadcast_server_match(session);
		broadcast_sync(session, i, 0, true);
		/*
		peer.x = -1000;
		peer.y = -1000;
		peer.respawn = true;
		peer.alarm[1] = 60;
		broadcast_sync(session, i, 0, true);
		*/
	}
	i++;
}