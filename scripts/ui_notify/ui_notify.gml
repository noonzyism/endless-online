function ui_notify(text) {
	var inst = instance_create_depth(0,0,-1000,ui_notification);
	inst.text = text;
}