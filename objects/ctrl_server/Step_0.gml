#region player state

//send server state to clients
if ((obj_player.xspeed != sent_xspeed) || (obj_player.yspeed != sent_yspeed)) {
	sent_xspeed = obj_player.xspeed;
	sent_yspeed = obj_player.yspeed;
	alarm[0] = 30;
}

//we send continuous syncs while shooting to keep track of aim...
if (obj_player.shooting) {
	sent_shooting = obj_player.shooting;
	alarm[0] = 30;
}
	
if (obj_player.hp != sent_hp) {
	sent_hp = obj_player.hp;
	alarm[0] = 30;
}

curr_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
if (abs(curr_angle - sent_angle) > 15) {
	sent_angle = curr_angle;
	alarm[0] = 30;
}

if (alarm[0] > 0) {
	broadcast_server_sync(session);
}

#endregion