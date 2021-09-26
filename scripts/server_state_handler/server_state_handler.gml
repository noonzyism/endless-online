/// example_increment_server_handler(session, socket, ip, port, packet_id, values);
function server_state_handler() {

	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];

	var _cid	  = _values[0];
	var _ticks	  = _values[1];
	var _xspeed	  = _values[2];
	var _yspeed	  = _values[3];
	var _weapon	  = _values[4];
	var _shooting = _values[5];
	var _aimx     = _values[6];
	var _aimy     = _values[7];
	
	// temporary simulation of packet-loss
	randomise();
	if (irandom(10) != 1000) {
		
		var peer = ctrl_server.clients[_cid, 0];

		show_debug_message("Server received: [id=" + string(_cid) + "| xspeed,yspeed=" + string(_xspeed) + ", " + string(_yspeed) + " | shooting=" + string(_shooting) + "| mouse x,y=" + string(_aimx) + ", " + string(_aimy) + "]");

		if (peer.weapon != _weapon) {
			weapon_switch(peer);
		}

		peer.xspeed = _xspeed;
		peer.yspeed = _yspeed;
		peer.shooting = _shooting;
		peer.image_angle = point_direction(peer.x, peer.y, _aimx, _aimy);
		peer.aimx = _aimx;
		peer.aimy = _aimy;

		broadcast_sync(_session, _cid, _ticks);
	}
}
