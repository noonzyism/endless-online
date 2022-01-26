/// example_increment_client_handler(session, socket, ip, port, packet_id, values);
function client_sync_handler() {

	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];

	var _id			= _values[0];
	// sendtime: only applicable to SYNCs relating to this client's self state, not other peers
	// returns the tickstamp that the server received from the STATE message this client sent and for which the server is responding to
	// if this is not applicable, (data for another peer or it was a server-initiated SYNC) _sendtime = 0
	var _sendtick	= _values[1];
	var _hp			= _values[2];
	var _x			= _values[3];
	var _y			= _values[4];
	var _xspeed		= _values[5];
	var _yspeed		= _values[6];
	var _weapon		= _values[7];
	var _shooting	= _values[8];
	var _aimx		= _values[9];
	var _aimy		= _values[10];
	var _force		= _values[11];

	//setting the position from server unconditionally causes the player to stutter a bit since the received position is a couple ms outdated
	//as a workaround, for now we'll just ignore the server's correction if we're only slightly off
		
	//self state
	if (_id == ctrl_client.clientId) {
		var msg = "[t=" + string(_sendtick) + "] Client received SYNC: client position [" + string(_x) + ", " + string(_y) + "]"
		show_debug_message(msg);
		global.logs += "\n"+msg;
		
		// if this is the latest response to a state update (or if it's a server-forced update), project movement
		if (_force || _sendtick == ctrl_client.tick_lastsent) {
			var delta = (ctrl_client.ticks - _sendtick)+1;
			
			//obj_player.x = _x;
			//obj_player.y = _y;
			
			var actual_x = obj_player.x;
			var actual_y = obj_player.y;
			var dest = step_xy(_x, _y, _xspeed, _yspeed, delta);
			
			// if speed matches what the server last knew about (or if it's a server-forced update), correct/project position
			if (_force || (_xspeed == obj_player.xspeed && _yspeed == obj_player.yspeed)) {
				obj_player.x = dest[0];
				obj_player.y = dest[1];
			}
			
			if (actual_x != dest[0] || actual_y != dest[1]) {
				var msg = "[t=" + string(_sendtick) + "] *************Host sync: [" + string(_x) + ", " + string(_y) + ", " + string(_xspeed) + ", " + string(_yspeed) + "] ||||| [" + string(actual_x) + ", " + string(actual_y) + "] -> [" + string(dest[0]) + ", " + string(dest[1]) + "]";
				show_debug_message(msg);
				global.logs += "\n"+msg;
			}
		}
	
		//hp is fully dictated by server, any local calculation (no matter how "close" it is) gets overwritten by this
		obj_player.hp = _hp;
	}
	//server state
	//some potential consolidation of code is possible here - these logic blocks for both host and peer IDs effectively do the same exact thing (update some peer instance)
	else if (_id == 0) {
		show_debug_message("Client received SYNC: host position [" + string(_x) + ", " + string(_y) + "]");
	
		//create an instance of this peer if it hasn't already been done
		if (ctrl_client.peers[0] == -1) {
			ctrl_client.peers[0] = instance_create_depth(_x, _y, 100, obj_peer);
		}
		
		ctrl_client.peers[0].x = _x;
		ctrl_client.peers[0].y = _y;
	
		if abs(ctrl_client.peers[0].x - _x) > (obj_player.velocity * 2) + 1 {
			//ctrl_client.peers[0].x = _x;
		}

		if abs(ctrl_client.peers[0].y - _y) > (obj_player.velocity * 2) + 1 {
			//ctrl_client.peers[0].y = _y;
		}
	
		ctrl_client.peers[0].xspeed = _xspeed;
		ctrl_client.peers[0].yspeed = _yspeed;
	
		ctrl_client.peers[0].image_angle = point_direction(_x, _y, _aimx, _aimy);
	
		ctrl_client.peers[0].aimx = _aimx;
		ctrl_client.peers[0].aimy = _aimy;
	
		if (ctrl_client.peers[0].weapon != _weapon) {
			weapon_switch(ctrl_client.peers[0]);
		}
		ctrl_client.peers[0].shooting = _shooting;
	
		ctrl_client.peers[0].hp = _hp;
	}
	else if (_id != 0 && _id != ctrl_client.clientId) { //other peer
		//create an instance of this peer if it hasn't already been done
		if (ctrl_client.peers[_id] == -1) {
			ctrl_client.peers[_id] = instance_create_depth(_x, _y, 100, obj_peer);
		}
	
		var peer = ctrl_client.peers[_id];
	
		peer.x = _x;
		peer.y = _y;
	
		peer.xspeed = _xspeed;
		peer.yspeed = _yspeed;
		peer.image_angle = point_direction(_x, _y, _aimx, _aimy);
	
		peer.aimx = _aimx;
		peer.aimy = _aimy;
	
	
		if (peer.weapon != _weapon) {
			weapon_switch(peer);
		}
		peer.shooting = _shooting;
		peer.hp = _hp;
	}


}
