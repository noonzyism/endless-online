function get_metadata_or_else(_inst, _keyname, _default) {
	// returns the piece of metadata for the given instance, or the given default if it doesn't exist
	var inst_map = global.metadata[? _inst];

	if (is_undefined(inst_map)) {
		return _default;
	}

	var val = inst_map[? _keyname];

	if (is_undefined(val)) {
		return _default;
	}
	else {
		return val;
	}
}

function set_metadata(_inst, _keyname, _value) {
	// adds a piece of metadata for the given instance
	var inst_map = global.metadata[? _inst];

	if (is_undefined(inst_map)) {
		ds_map_add(global.metadata, _inst, ds_map_create());
		inst_map = global.metadata[? _inst];
	}

	// adds or replaces the value for the key
	ds_map_replace(inst_map, _keyname, _value);
}

