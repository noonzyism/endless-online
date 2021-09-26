// returns the new x position if no collision, otherwise returns the current x
function step_x(x_curr, y_curr, x_speed) {
	//collision-related vars
	collision_map = global.collision_map;

	//boundary offsets from the sprite origin
	left_offset = -16;
	right_offset = 16;
	bottom_offset = 16;
	top_offset = -16;
	
	left_bound = x_curr + left_offset;
	right_bound = x_curr + right_offset;
	bottom_bound = y_curr + bottom_offset;
	top_bound = y_curr + top_offset;

	if (x_speed < 0) {
		var t1 = tilemap_get_at_pixel(collision_map, left_bound+x_speed, top_bound) & tile_index_mask;
		var t2 = tilemap_get_at_pixel(collision_map, left_bound+x_speed, bottom_bound) & tile_index_mask;
	
		if (t1 != 0 || t2 != 0) {
			// collision ahead, return current x
			return x_curr;
		}
	}

	if (x_speed > 0) {
		var t1 = tilemap_get_at_pixel(collision_map, right_bound+x_speed, top_bound) & tile_index_mask;
		var t2 = tilemap_get_at_pixel(collision_map, right_bound+x_speed, bottom_bound) & tile_index_mask;
	
		if (t1 != 0 || t2 != 0) {
			// collision ahead, return current x
			return x_curr;
		}
	}
	
	// coast is clear, you may proceed
	return x_curr + x_speed;
}

// returns the new y position if no collision, otherwise returns the current y
function step_y(x_curr, y_curr, y_speed) {
	//collision-related vars
	collision_map = global.collision_map;

	//boundary offsets from the sprite origin
	left_offset = -16;
	right_offset = 16;
	bottom_offset = 16;
	top_offset = -16;
	
	left_bound = x_curr + left_offset;
	right_bound = x_curr + right_offset;
	bottom_bound = y_curr + bottom_offset;
	top_bound = y_curr + top_offset;

	if (y_speed < 0) {
		var t1 = tilemap_get_at_pixel(collision_map, left_bound, top_bound+y_speed) & tile_index_mask;
		var t2 = tilemap_get_at_pixel(collision_map, right_bound, top_bound+y_speed) & tile_index_mask;
	
		if (t1 != 0 || t2 != 0) {
			// collision ahead, return current y
			return y_curr;
		}
	}

	if (y_speed > 0) {
		var t1 = tilemap_get_at_pixel(collision_map, left_bound, bottom_bound+y_speed) & tile_index_mask;
		var t2 = tilemap_get_at_pixel(collision_map, right_bound, bottom_bound+y_speed) & tile_index_mask;
	
		if (t1 != 0 || t2 != 0) {
			// collision ahead, return current y
			return y_curr;
		}
	}
	
	// coast is clear, you may proceed
	return y_curr + y_speed;
}

// returns the final x,y position given an initial position, speed, and number of steps
// if there is an intermediate collision, the point returned will be once it hits
function step_xy(x_init, y_init, x_speed, y_speed, steps) {
	//collision-related vars
	var collision_map = global.collision_map;

	//boundary offsets from the sprite origin
	var left_offset = -16;
	var right_offset = 16;
	var bottom_offset = 16;
	var top_offset = -16;
	
	var x_curr = x_init;
	var y_curr = y_init;
	
	var step = 0;
	while (step < steps) {
		var left_bound = x_curr + left_offset;
		var right_bound = x_curr + right_offset;
		var bottom_bound = y_curr + bottom_offset;
		var top_bound = y_curr + top_offset;
	
	
		if (x_speed < 0) {
			var t1 = tilemap_get_at_pixel(collision_map, left_bound+x_speed, top_bound) & tile_index_mask;
			var t2 = tilemap_get_at_pixel(collision_map, left_bound+x_speed, bottom_bound) & tile_index_mask;
	
			if (t1 != 0 || t2 != 0) {
				// collision ahead
			}
			else {
				x_curr += x_speed;
			}
		}

		if (x_speed > 0) {
			var t1 = tilemap_get_at_pixel(collision_map, right_bound+x_speed, top_bound) & tile_index_mask;
			var t2 = tilemap_get_at_pixel(collision_map, right_bound+x_speed, bottom_bound) & tile_index_mask;
	
			if (t1 != 0 || t2 != 0) {
				// collision ahead
			}
			else {
				x_curr += x_speed;
			}
		}
	
		if (y_speed < 0) {
			var t1 = tilemap_get_at_pixel(collision_map, left_bound, top_bound+y_speed) & tile_index_mask;
			var t2 = tilemap_get_at_pixel(collision_map, right_bound, top_bound+y_speed) & tile_index_mask;
	
			if (t1 != 0 || t2 != 0) {
				// collision ahead
			}
			else {
				y_curr += y_speed;
			}
		}

		if (y_speed > 0) {
			var t1 = tilemap_get_at_pixel(collision_map, left_bound, bottom_bound+y_speed) & tile_index_mask;
			var t2 = tilemap_get_at_pixel(collision_map, right_bound, bottom_bound+y_speed) & tile_index_mask;
	
			if (t1 != 0 || t2 != 0) {
				// collision ahead
			}
			else {
				y_curr += y_speed;
			}
		}
		step += 1;
	}
	
	var endpoint = [];
	endpoint[0] = x_curr;
	endpoint[1] = y_curr;
	
	return endpoint;
}