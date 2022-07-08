// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_client_id_for_instance(_inst) {
	if (instance_exists(ctrl_server)) {
		var i = 0;
		while (ctrl_server.clients[i, 0] != -1) {
			if (ctrl_server.clients[i, 0] == _inst) {
				return i;
			}
			i++;
		}
	}
	if (instance_exists(ctrl_client)) {
		var i = 0;
		while (ctrl_client.peers[i] != -1) {
			if (ctrl_client.peers[i] == _inst) {
				return i;
			}
			i++;
		}
	}
	return -1;
}