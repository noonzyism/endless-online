if (vb_p3d != -1) {
	shader_set(sh_p3d);
	set_shader_uniforms();
	vertex_submit(vb_p3d,pr_trianglelist,txp_p3d);
	shader_reset();
}



draw_text(obj_player.x-32, obj_player.y-36, obj_player.username + ": " + string(obj_player.hp));