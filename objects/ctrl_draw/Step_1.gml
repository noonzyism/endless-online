// converts the drawgrid to an ordered list for quick iteration when building the buffer
// this conversion only happens when there is a change in the draw requests
// todo: this is slow
if (ds_list_size(draw_requests) != ds_priority_size(global.drawgrid)) {
	ds_list_clear(draw_requests);
	var count = ds_priority_size(global.drawgrid);
	var i = 0;
	var tempstack = ds_priority_create();
	ds_priority_copy(tempstack, global.drawgrid);
	
	while (i < count) {
		ds_list_add(draw_requests, ds_priority_delete_max(tempstack));
		i += 1;
	}
	global.should_rebuild_buffer = true;
}

if (global.should_rebuild_buffer) {		
	vb_p3d = build_buffer_from_requests(draw_requests, vf_p3d);
	global.should_rebuild_buffer = false;
}