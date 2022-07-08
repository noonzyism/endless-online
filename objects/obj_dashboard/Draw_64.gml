draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(256, 128, global.game_width - 256, global.game_height - 128, false);
draw_set_alpha(1.0);
draw_set_color(c_white);

var xx = 272;
var yy = 164;

draw_text(xx, yy, source_terminal.objname);
yy += 32;
draw_text(xx, yy, "--------------");
yy += 32;
draw_text(xx, yy, "[ESC] Exit Dashboard");
yy += 32;
for (var i = 0; i < ctrl_match_survival.action_count; i++) {
	draw_text(xx, yy, "[" + string(i) + "] " + ctrl_match_survival.actions[i]);
	yy += 32;
}