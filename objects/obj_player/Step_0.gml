/// @description player step event

var mouse_dir = point_direction(x, y, mouse_x, mouse_y);

//movement logic
if keyboard_check(ord("W")) {
	yspeed = -velocity;
}
if keyboard_check(ord("A")) {
	xspeed = -velocity;
}
if keyboard_check(ord("S")) {
	yspeed = velocity;
}
if keyboard_check(ord("D")) {
	xspeed = velocity;
}

if !(keyboard_check(ord("A")) ^^ keyboard_check(ord("D"))) {
	xspeed = 0;
}

if !(keyboard_check(ord("W")) ^^ keyboard_check(ord("S"))) {
	yspeed = 0;
}

x = step_x(x, y, xspeed);
y = step_y(x, y, yspeed);

//aiming/shooting logic
image_angle = mouse_dir;

if mouse_check_button(mb_left) {
	shooting = cooldown ? false : true;
	weapon_fire(self, par_player, mouse_x, mouse_y);
}
else {
	shooting = false;
}

if (keyboard_check_released(ord("Q"))) {
	//toggle weapon
	weapon_switch(self);
}

curr_kills = kills;

if (curr_kills > prev_kills) {
	ui_notify("Kill confirmed.");
}

prev_kills = kills;