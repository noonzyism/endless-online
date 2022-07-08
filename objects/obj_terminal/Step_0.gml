if (distance_to_point(mouse_x, mouse_y) < 16) {
	if (keyboard_check_pressed(ord("E"))) {
		if (instance_number(obj_dashboard) == 0) {
			var dash = instance_create_depth(x, y, -1001, obj_dashboard);
			dash.source_terminal = id;
		}
		else {
			instance_destroy(obj_dashboard);
		}
	}
}