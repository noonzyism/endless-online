/////////////////////////////////////////////////////
// Server State Updates
////////////////////////////////////////////////////

//send server state to clients
if ((obj_player.xspeed != sent_xspeed) || (obj_player.yspeed != sent_yspeed)) {
	sent_xspeed = obj_player.xspeed;
	sent_yspeed = obj_player.yspeed;
	broadcast_server_sync(session);
}

//we send continuous syncs while shooting to keep track of aim...
if (obj_player.shooting) {
	sent_shooting = obj_player.shooting;
	broadcast_server_sync(session);
}
//...and send one more to notify when we're done shooting
if (!obj_player.shooting) && (sent_shooting == true) {
	sent_shooting = obj_player.shooting;
	broadcast_server_sync(session);
}
	
if (obj_player.hp != sent_hp) {
	sent_hp = obj_player.hp;
	broadcast_server_sync(session);
}
	
curr_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
if (abs(curr_angle - sent_angle) > 15) {
	sent_angle = curr_angle;
	broadcast_server_sync(session);
}

/////////////////////////////////////////////////////
// Client State Updates
////////////////////////////////////////////////////

for (var i = 0; i < 9; i ++) {
	var inst = clients[i, 0];
	if (inst !=  -1) {
		if (inst.alarm[11] < 1) {
			broadcast_sync(session, i);
		}
		else if (inst.alarm[10] < 1) {
			broadcast_match(session, i);
		}
		else if (inst.hp < 1) {
			// respawn
			inst.x = 128;
			inst.y = 128;
			inst.hp = 100;
			inst.deaths += 1;
			if (inst.foe != -1) inst.foe.kills += 1;
			broadcast_sync(session, i);
			broadcast_match(session, i);
		}
	}
}