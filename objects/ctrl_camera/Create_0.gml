view_enabled = true;
view_set_wport(0, global.game_width);
view_set_hport(0, global.game_height);
view_set_visible(0, true);

surface_resize(application_surface, global.game_width, global.game_height);
window_set_size(global.game_width, global.game_height);