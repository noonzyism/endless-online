ticks += 1;

if (clientId != -1) {
	curr_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
	
	if ((obj_player.xspeed != sent_xspeed) || (obj_player.yspeed != sent_yspeed) || (obj_player.shooting != sent_shooting) || (abs(curr_angle - sent_angle) > 15) || (obj_player.weapon != sent_weapon)) {
		sent_xspeed = obj_player.xspeed;
		sent_yspeed = obj_player.yspeed;
		sent_shooting = obj_player.shooting;
		sent_angle = curr_angle;
		sent_weapon = obj_player.weapon;
		//netplay_send(session, socket, Packets.STATE, clientId, ticks, sent_xspeed, sent_yspeed, sent_weapon, sent_shooting, mouse_x, mouse_y);
		// temporary delayed sending for testing
		var packet = [];
		packet[0] = 0;
		packet[1] = session;
		packet[2] = socket;
		packet[3] = clientId;
		packet[4] = ticks;
		packet[5] = sent_xspeed;
		packet[6] = sent_yspeed;
		packet[7] = sent_weapon;
		packet[8] = sent_shooting;
		packet[9] = mouse_x;
		packet[10] = mouse_y;
		ds_list_add(ctrl_delayer.state_packets, packet);
		tick_lastsent = ticks;
	}
}