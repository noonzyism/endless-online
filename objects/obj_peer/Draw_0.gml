if (shooting) {
	draw_set_color(c_yellow);
	draw_set_alpha(0.4);
	draw_line(x, y, target_x + random_range(-10, 10), target_y + random_range(-10, 10));
	draw_set_alpha(1.0);
}

draw_self();
draw_text(x-32, y-36, username + ": " + string(hp));