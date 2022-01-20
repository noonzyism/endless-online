function weapon_fire(argument0, argument1, argument2, argument3) {
	//handles weapon firing logic and hit detection

	var shooter = argument0;
	var target	= argument1;
	var aimx	= argument2;
	var aimy	= argument3;

	var xslope = aimx - shooter.x;
	var yslope = aimy - shooter.y;

	//right now, we just calc from the player origin to an arbitrarily far away point along the line
	//one could change this to get the point along the line that intersects with the view boundary

	if (shooter.weapon == Weapons.ASSAULT_RIFLE) {
		if (shooter.cooldown == false) {
			var hit = collision_line_first(shooter.x, shooter.y, aimx + (2 * xslope), aimy + (2 * yslope), target, false, true);
			if (hit != noone) {
				var obstruction = find_obstruction_v2(shooter.x, shooter.y, hit.x, hit.y, 1, global.collision_map);
				if (obstruction == undefined) {
					hit.hp -= 1;
					hit.foe = shooter;
					shooter.target_x = hit.x;
					shooter.target_y = hit.y;
				}
				else {
					shooter.target_x = obstruction[0];
					shooter.target_y = obstruction[1];
				}
			}
			else {
				// this check can be less precise because it's not in line of a potential hit, just used for visual purposes
				var obstruction = find_obstruction_v2(shooter.x, shooter.y, aimx + (10 * xslope), aimy + (10 * yslope), 8, global.collision_map);
				if (obstruction == undefined) {
					shooter.target_x = aimx + (2 * xslope);
					shooter.target_y = aimy + (2 * yslope);
				}
				else {
					shooter.target_x = obstruction[0];
					shooter.target_y = obstruction[1];
				}
			}
		}
	}

	if (shooter.weapon == Weapons.SNIPER) {
		if (shooter.cooldown == false) {
			var hit = collision_line_first(shooter.x, shooter.y, aimx + (10 * xslope), aimy + (10 * yslope), target, false, true);
			shooter.cooldown = true;
			shooter.alarm[0] = 60;
			if (hit != noone) {
				var obstruction = find_obstruction_v2(shooter.x, shooter.y, hit.x, hit.y, 1, global.collision_map);
				if (obstruction == undefined) {
					hit.hp -= 50;
					hit.foe = shooter;
					shooter.target_x = hit.x;
					shooter.target_y = hit.y;
				}
				else {
					shooter.target_x = obstruction[0];
					shooter.target_y = obstruction[1];
				}
			}
			else {
				// this check can be less precise because it's not in line of a potential hit, just used for visual purposes
				var obstruction = find_obstruction_v2(shooter.x, shooter.y, aimx + (10 * xslope), aimy + (10 * yslope), 8, global.collision_map);
				if (obstruction == undefined) {
					shooter.target_x = aimx + (2 * xslope);
					shooter.target_y = aimy + (2 * yslope);
				}
				else {
					shooter.target_x = obstruction[0];
					shooter.target_y = obstruction[1];
				}
			}
		}
	}
	


}
