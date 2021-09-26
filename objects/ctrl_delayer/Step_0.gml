var delete_syncpacket_ids = ds_list_create();
var delete_statepacket_ids = ds_list_create();

////////////////////////////////////////////////////////////////////////////////
// Sync packets
// send packets which have reached their timer, and reduce time on all others
var i = 0;
for (i = 0; i < ds_list_size(sync_packets); i += 1) {
	var packet = sync_packets[|i];
	if (packet[0] <= 0) {
		var p1 = packet[1];
		var p2 = packet[2];
		var p3 = packet[3];
		var p4 = packet[4];
		var p5 = packet[5];
		var p6 = packet[6];
		var p7 = packet[7];
		var p8 = packet[8];
		var p9 = packet[9];
		var p10 = packet[10];
		var p11 = packet[11];
		var p12 = packet[12];
		var p13 = packet[13];
		netplay_send(packet[1], packet[2], Packets.SYNC, packet[3], packet[4], packet[5], packet[6], packet[7], packet[8], packet[9], packet[10], packet[11], packet[12], packet[13]);
		ds_list_add(delete_syncpacket_ids, i);
	}
	else {
		packet[0] -= 1;
	}
}

// remove sent packets
i = 0;
for (i = 0; i < ds_list_size(delete_syncpacket_ids); i += 1) { 
	ds_list_delete(sync_packets, delete_syncpacket_ids[|i]);
}

////////////////////////////////////////////////////////////////////////////////
// State packets
// send packets which have reached their timer, and reduce time on all others
var i = 0;
for (i = 0; i < ds_list_size(state_packets); i += 1) {
	var packet = state_packets[|i];
	if (packet[0] <= 0) {
		var p1 = packet[1];
		var p2 = packet[2];
		var p3 = packet[3];
		var p4 = packet[4];
		var p5 = packet[5];
		var p6 = packet[6];
		var p7 = packet[7];
		var p8 = packet[8];
		var p9 = packet[9];
		var p10 = packet[10];
		netplay_send(packet[1], packet[2], Packets.STATE, packet[3], packet[4], packet[5], packet[6], packet[7], packet[8], packet[9], packet[10]);
		ds_list_add(delete_statepacket_ids, i);
	}
	else {
		packet[0] -= 1;
	}
}

// remove sent packets
i = 0;
for (i = 0; i < ds_list_size(delete_statepacket_ids); i += 1) { 
	ds_list_delete(state_packets, delete_statepacket_ids[|i]);
}