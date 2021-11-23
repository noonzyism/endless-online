draw_self();
draw_text(x-32, y-36, username + ": " + string(hp));

if (obj_player.shooting) {
	draw_set_color(c_yellow);
	draw_line(obj_player.x, obj_player.y, mouse_x + random_range(-10, 10), mouse_y + random_range(-10, 10));
}

