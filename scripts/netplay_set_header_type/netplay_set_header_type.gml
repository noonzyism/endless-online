/// @description netplay_set_header_type
/// @param session
/// @param type
function netplay_set_header_type() {


	var _session = argument[0],
	    _type    = argument[1];

	_session[? "header_type"] = _type;


}
