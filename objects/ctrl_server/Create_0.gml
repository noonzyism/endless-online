ui_notify("Connected as host.");

clientId = -1;
clientName = "";
clientSocket = -1;
client_sent_hp = 100;

for (var i = 0; i < 9; i++) {
	clients[i, 0] = -1; //peer instance id
	clients[i, 1] = ""; //username
	clients[i, 2] = -1; //socket
}

//the id of 0 is reserved for the server, so this index is skipped in most client-related logic
clients[0, 0] = instance_nearest(0, 0, obj_player);
clients[0, 1] = obj_player.username;

//refers to last-sent SERVER state (not client)
sent_xspeed = -1;
sent_yspeed = -1;
sent_shooting = false;
sent_hp = 100;
sent_angle = 999;

// match-based variables
mob_ticker = 0;
syncrate_match = 30;
alarm[1] = syncrate_match; // match state updater

username = get_string("Enter a username: ", "Mr Host");

obj_player.username = username;

session = netplay_create_session();

netplay_add_event_handler(session, network_type_connect, example_connect_server_handler);
netplay_add_event_handler(session, network_type_data, example_data_server_handler);
netplay_add_event_handler(session, network_type_disconnect, example_disconnect_server_handler);

init_packets();

netplay_add_packet_handler(session, Packets.Echo, example_echo_server_handler);
netplay_add_packet_handler(session, Packets.Increment, example_increment_server_handler);
netplay_add_packet_handler(session, Packets.Position, example_position_server_handler);
netplay_add_packet_handler(session, Packets.STATE, server_state_handler);
netplay_add_packet_handler(session, Packets.JOIN, server_join_handler);

socket  = netplay_open(session, 5000, 32);