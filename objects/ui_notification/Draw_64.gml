alpha -= fade;
draw_set_alpha(alpha);
draw_text(x, y, text);
draw_set_alpha(1.0);