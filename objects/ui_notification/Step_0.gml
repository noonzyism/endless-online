curr_count = instance_number(ui_notification);

if (curr_count < prev_count) {
	index -= 1;
}

prev_count = curr_count;

y = 132 + index*32;

if (alpha <= 0) {
	instance_destroy();
}