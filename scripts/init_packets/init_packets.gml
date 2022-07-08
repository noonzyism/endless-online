function init_packets() {
	netplay_add_packet(session, Packets.Echo, buffer_string); // unused/deprecated
	netplay_add_packet(session, Packets.Increment, buffer_u16); // unused/deprecated
	netplay_add_packet(session, Packets.Position, buffer_u16, buffer_u16); // unused/deprecated
	netplay_add_packet(session, Packets.SYNC, buffer_u16, buffer_u64, buffer_u8, buffer_u16, buffer_u16, buffer_s16, buffer_s16, buffer_u16, buffer_bool, buffer_u16, buffer_u16, buffer_bool);
	netplay_add_packet(session, Packets.JOIN, buffer_string);
	netplay_add_packet(session, Packets.ACCEPT, buffer_u16, buffer_bool);
	netplay_add_packet(session, Packets.STATE, buffer_u8, buffer_u64, buffer_s16, buffer_s16, buffer_u16, buffer_bool, buffer_u16, buffer_u16);
	netplay_add_packet(session, Packets.MATCH, buffer_u8, buffer_string, buffer_bool, buffer_u8, buffer_u8, buffer_u8, buffer_bool); // unused/deprecated
	
	netplay_add_packet(session, Packets.SURVIVAL_TASK, buffer_u8, buffer_string, buffer_u16, buffer_u8); //mainframe health, task description, task life, task state
	netplay_add_packet(session, Packets.SURVIVAL_MOB, buffer_u8, buffer_bool, buffer_u8, buffer_u8, buffer_u16, buffer_u16, buffer_u8, buffer_u16); // mainframe health, create or update, mob type, mob target, mob x, mob y, mob speed, mob count
	netplay_add_packet(session, Packets.SURVIVAL_KEYS, buffer_u8, buffer_u16, buffer_u16, buffer_u16, buffer_u16);  // mainframe health, alpha, delta, sigma, omega keys
}
