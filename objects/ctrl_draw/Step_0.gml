if (obj_player.weapon != last_known_weapon) {
	last_known_weapon = obj_player.weapon;
	weapon_swap_transition = 1.0;
}

weapon_swap_transition = max(0.0, weapon_swap_transition - 0.1);