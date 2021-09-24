/// @description netplay_is_remote
/// @param session
function netplay_is_remote() {


	var _session = argument[0];

	return _session[? "host"] != "self";


}
