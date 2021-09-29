function ui_notify(x, text) {
	var inst = instance_create_depth(x,0,-1000,ui_notification);
	inst.text = text;
}