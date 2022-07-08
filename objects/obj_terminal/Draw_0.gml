// drawing is handled by the p3d engine

if (distance_to_point(mouse_x, mouse_y) < 16) {
	//draw_set_halign(fa_center);
	draw_text(mouse_x + 16, mouse_y, "[E] " + objname);
}