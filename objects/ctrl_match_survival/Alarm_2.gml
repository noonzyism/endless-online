/// @description Mob Spawner

var ri = irandom_range(3, 10);
for (var i = 0; i < ri; i++) {
	var rx = irandom_range(0, room_width);
	var ry = irandom_range(0, room_height);
	instance_create_depth(rx, ry, -2000, obj_ghost);
}

alarm[2] = mob_rate;