ticks += 1;

if (clientId != -1) {
	curr_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
	
	if ((obj_player.xspeed != sent_xspeed) || (obj_player.yspeed != sent_yspeed) || (obj_player.shooting != sent_shooting) || (abs(curr_angle - sent_angle) > 15) || (obj_player.weapon != sent_weapon)) {
		sent_xspeed = obj_player.xspeed;
		sent_yspeed = obj_player.yspeed;
		sent_shooting = obj_player.shooting;
		sent_angle = curr_angle;
		sent_weapon = obj_player.weapon;
		var msg = "[t=" + string(ticks) + "] Sending server current state [" + string(obj_player.x) + ", " + string(obj_player.y) + ", " + string(sent_xspeed) + ", " + string(sent_yspeed) + "]";
		show_debug_message(msg);
		global.logs += "\n"+msg;
		netplay_send(session, socket, Packets.STATE, clientId, ticks, sent_xspeed, sent_yspeed, sent_weapon, sent_shooting, mouse_x, mouse_y);
		tick_lastsent = ticks;
	}
}