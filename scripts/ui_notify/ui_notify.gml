function ui_notify(x, y, text) {
	var inst = instance_create_depth(x,y,-1000,ui_notification);
	inst.text = text;
}