if (vb_p3d != -1) {
	shader_set(sh_p3d);
	set_shader_uniforms();
	vertex_submit(vb_p3d,pr_trianglelist,txp_p3d);
	shader_reset();
}



// HP
draw_text(obj_player.x-32, obj_player.y-36, obj_player.username + ": " + string(obj_player.hp));


// Crosshair
crosshair_sprite = obj_player.weapon == 0 ? spr_crosshair_ar : spr_crosshair_sniper;
draw_sprite_ext(crosshair_sprite, obj_player.shooting ? -1 : 0, mouse_x, mouse_y, 1.0, 1.0, 0, obj_player.shooting ? c_yellow : c_white, 1.0);
draw_sprite_ext(crosshair_sprite, obj_player.shooting ? -1 : 0, mouse_x, mouse_y, 1.0, 1.0, 0, obj_player.shooting ? c_yellow : c_white, 1.0);