///@desc Example - Draw

if (!instance_exists(imgui)) {
  draw_set_font(f_arial12);
  draw_set_color($F36EB2);
  var s = 2;
  var helpText = "Press [SPACE] to start ImGui!";
  var tw = string_width(helpText) * s,
      th = string_height(helpText) * s;
  var tx = floor((room_width - tw) * 0.5),
      ty = room_height - (th * 3);
  draw_text_transformed(tx, ty, helpText, s, s, 0);
}