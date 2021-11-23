draw_set_color(c_white);

draw_text(32, 64, "Weapon: " + string(obj_player.weapon == 0 ? "Assault Rifle" : "Sniper"));

draw_text(32, 96, "Cooldown: " + string(obj_player.alarm[0] == -1 ? "None" : obj_player.alarm[0]));

draw_text(32, 128, "Move with [W,A,S,D] / Switch weapon with [Q]");


var red_score = (obj_player.team) ? obj_player.deaths : obj_player.kills;
var blue_score = (obj_player.team) ? obj_player.kills : obj_player.deaths;

draw_text(32, 160, "Red Team: " + string(red_score));
draw_text(32, 192, "Blue Team: " + string(blue_score));