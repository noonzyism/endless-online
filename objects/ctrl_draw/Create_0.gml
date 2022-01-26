//unused vars atm
bullet_particle_x = -1;
bullet_particle_y = -1;

draw_request = false;

depth = -100;

//p3d stuff
vb_p3d = -1;
draw_requests = ds_list_create();
vf_p3d = global.vf_p3d;
txp_p3d = global.txp_p3d;

draw_set_font(f_conthrax9);

last_known_weapon = -1;
weapon_swap_transition = 1.0;

window_set_cursor(cr_none); //crosshair will be drawn where the cursor was