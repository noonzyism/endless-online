/// example_increment_client_handler(session, socket, ip, port, packet_id, values);
function example_increment_client_handler() {

	var _session   = argument[0],
	    _socket    = argument[1],
	    _ip        = argument[2],
	    _port      = argument[3],
	    _packet_id = argument[4],
	    _values    = argument[5];

	var _num = _values[0];

	show_debug_message("Client received: " + string(_num));


}
