///@desc example - Step
if (keyboard_check_pressed(vk_f1))
	game_restart();	

if (keyboard_check_pressed(vk_f2))
  imguigml_deactivate();

if (keyboard_check_pressed(vk_f3))
  imguigml_activate();
  
if (keyboard_check_pressed(vk_f4))
  room_goto(rm_test_persistance);
  
if (keyboard_check_pressed(vk_f5)) {
  imguigml_toggle_cursor();
  Cursor_visible = !Cursor_visible;
  window_set_cursor(Cursor_visible ? cr_arrow : cr_none);
}

if (keyboard_check_pressed(vk_f6)) {
	if (surface_exists(Surface)) 
		surface_free(Surface);
}

if (keyboard_check_pressed(vk_space)) {
	if (!instance_exists(imgui)) {
	  instance_create_depth(0, 0, depth-10, imgui);
		imguigml_add_font_from_ttf("pixel04b24.ttf", 12.0);	
	}
	else if(!ShowTestWindow){
		ShowTestWindow = true;	
	}
}	
 
if (imguigml_ready()) {
	var size = [ 0, 0 ];
	var pos = [ 0, 0 ];
	if (ShowTestWindow) {
		imguigml_set_next_window_size(550, 128, EImGui_Cond.Once);

		var ret = imguigml_begin("Endless Shooter", ShowTestWindow);
		imguigml_begin_child("Tests", 0, 170, true);
		{
			if (imguigml_button("Host a match...", 256, 64)) {
				//room_goto(room0);
			}
			imguigml_same_line();
			if(imguigml_button("Join a match...", 256, 64)) {
				
			}
		}
		imguigml_end();
	}
  
  if (TextEditor != undefined) {	
    imguigml_set_next_window_pos(pos[0] + size[0] + 5, pos[1], EImGui_Cond.Once);
    var ret = imguigml_begin("Text Editor", true);
    if (ret[0] && ret[1])
      imguigml_texteditor_render(TextEditor, "Edit some text!", 500, 300); 
    else if (!ret[1])
      TextEditor = imguigml_texteditor_destroy(TextEditor);
    imguigml_end();
  }
}