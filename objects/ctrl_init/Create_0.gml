global.collision_map = layer_tilemap_get_id(layer_get_id("collision_map"));

global.drawgrid = ds_priority_create();

global.should_rebuild_buffer = true;

// pseudo-3d vertex format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_textcoord();
vertex_format_add_custom(vertex_type_float4,vertex_usage_normal);
vertex_format_add_custom(vertex_type_float2,vertex_usage_texcoord);
vertex_format_add_custom(vertex_type_float2,vertex_usage_texcoord);
global.vf_p3d = vertex_format_end();

// pseudo-3d texture page
global.txp_p3d = sprite_get_texture(tx_brick, 0); // this references the texture page where all pseudo 3d textures reside

// uniforms
global.dynamics_count = 0;
global.uniforms_dynamic_id = -1;
global.uniforms_dynamic_pos = -1;
global.uniforms_dynamic_tex = -1;

global.metadata = ds_map_create(); // this map is used to store optional data at a per-instance level, which is preferable to using instance variables

global.logs = "";

global.game_width = 1024;
global.game_height = 768;

global.particle_system = part_system_create_layer("instances", false);
global.blood_particle = part_type_create();
part_type_shape(global.blood_particle, pt_shape_flare);
part_type_size(global.blood_particle, 1, 3, 0, 2);
part_type_scale(global.blood_particle, 0.1, 0.1);
part_type_color1(global.blood_particle, c_red);
part_type_alpha1(global.blood_particle, 1);
part_type_speed(global.blood_particle, 0.1, 0.1, 0.5, 0);
part_type_direction(global.blood_particle, 0, 359, 0, 0);
part_type_orientation(global.blood_particle, 0, 0, 0, 0, true);
part_type_blend(global.blood_particle, false);
part_type_life(global.blood_particle, 1, 15);


instance_create_depth(x, y, depth, ctrl_draw);
instance_create_depth(x, y, depth, ctrl_camera);
instance_create_depth(x, y, depth, ctrl_match_survival);

show_debug_overlay(true);