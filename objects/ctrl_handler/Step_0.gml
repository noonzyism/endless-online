/// @description Insert description here
// You can write your code in this editor
if keyboard_check_pressed(ord("C")) {
	instance_create_depth(32, 32, depth, ctrl_client);
	instance_destroy();
}

if keyboard_check_pressed(ord("S")) {
	instance_create_depth(32, 32, depth, ctrl_server);
	instance_destroy();
}