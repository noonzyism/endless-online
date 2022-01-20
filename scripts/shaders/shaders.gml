function set_shader_uniforms() {
	shader_set_uniform_f(
		shader_get_uniform(sh_p3d, "viewData"),
		obj_cam.x, 
		obj_cam.y,
		0,
		1000
	);
	
	shader_set_dynamic_uniforms(sh_p3d);
}

function shader_set_dynamic_uniforms(argument0) {
	var _shader = argument0;

	// set uniforms
	if (global.uniforms_dynamic_id != -1) {
		shader_set_uniform_i(shader_get_uniform(_shader, "dynamicCount"), min(16, global.dynamics_count));
		shader_set_uniform_i_array(shader_get_uniform(_shader, "dynamicIds"), global.uniforms_dynamic_id);
		shader_set_uniform_f_array(shader_get_uniform(_shader, "dynamicPosition"), global.uniforms_dynamic_pos);
		shader_set_uniform_f_array(shader_get_uniform(_shader, "dynamicTextureDiffs"), global.uniforms_dynamic_tex);
	}
	else {
		shader_set_uniform_i(shader_get_uniform(_shader, "dynamicCount"), 0);
	}

}
