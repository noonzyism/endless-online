x = step_x(x, y, xspeed);
y = step_y(x, y, yspeed);

if (shooting) {
	//right now, we just calc from the player origin to an arbitrarily far away point along the line
	//we could change this to get the point along the line that intersects with the view boundary
	
	weapon_fire(self, par_player, aimx, aimy);
}

if (hp < 1) {
	alarm[10] = 30; // notify MATCH update (only applicable if server/host)
}

curr_hp = hp;

if (curr_hp < prev_hp) {
	draining = true;
	alarm[11] = 30; // notify SYNC update (only applicable if server/host)
}
else {
	draining = false;
}

prev_hp = hp;