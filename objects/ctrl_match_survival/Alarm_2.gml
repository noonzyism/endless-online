/// @description Mob Spawner

var ri = irandom_range(3, 10);
for (var i = 0; i < ri; i++) {
	var rx = irandom_range(0, room_width);
	var ry = irandom_range(0, room_height);
	var mob = instance_create_depth(rx, ry, -2000, obj_ghost);
	
	#region host-only
	if (instance_exists(ctrl_server)) {
		var target = get_client_id_for_instance(mob.target);
		show_debug_message("Mob targeting peer " + string(target));
		broadcast_survival_mob(ctrl_server.session, true, 0, target, rx, ry, mob.speed, instance_number(obj_ghost));
	}
	#endregion
}

alarm[2] = mob_rate;