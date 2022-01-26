draw_set_color(c_white);

draw_text(32, 64, "Weapon: " + string(obj_player.weapon == 0 ? "Assault Rifle" : "Sniper"));

draw_text(32, 96, "Cooldown: " + string(obj_player.alarm[0] == -1 ? "None" : obj_player.alarm[0]));

draw_text(32, 128, "Move with [W,A,S,D] / Switch weapon with [Q]");


var red_score = (obj_player.team) ? obj_player.deaths : obj_player.kills;
var blue_score = (obj_player.team) ? obj_player.kills : obj_player.deaths;

draw_text(32, 160, "Red Team: " + string(red_score));
draw_text(32, 192, "Blue Team: " + string(blue_score));

// Weapon UI
weapon_ui_x = global.game_width - 160;
weapon_ui_y = global.game_height - 90;

top_y = lerp(weapon_ui_y + 16, weapon_ui_y + 28, weapon_swap_transition);
bot_y = lerp(weapon_ui_y + 28, weapon_ui_y + 16, weapon_swap_transition);

weapon_sprite = obj_player.weapon == 0 ? spr_ui_ar : spr_ui_sniper;
draw_set_font(f_conthrax9);
draw_set_halign(fa_left);
draw_text(weapon_ui_x, bot_y, string(obj_player.weapon == 0 ? "Assault Rifle" : "Sniper"));
draw_set_font(f_conthrax7);
draw_set_halign(fa_left);
draw_set_alpha(0.6);
draw_text(weapon_ui_x + 25, top_y, string(obj_player.weapon != 0 ? "/Assault Rifle" : "/Sniper"));
draw_set_alpha(1.0);
draw_sprite(weapon_sprite, 0, weapon_ui_x + 70, weapon_ui_y + 64);


// Score
/*
c_br_red = $FF6644;
c_dk_red = $A8432C;
var red_percent = (red_score/20) * 100;
var blue_percent = (blue_score/20) * 100;
draw_healthbar(32, global.game_height - 90, 96, global.game_height - 74, red_percent, c_red, c_br_red, c_dk_red, 0, true, false);
*/

draw_set_font(f_conthrax9);
draw_set_alpha(1.0);
draw_set_color(c_white);