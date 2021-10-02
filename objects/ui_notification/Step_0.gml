curr_count = instance_number(ui_notification);

if (curr_count < prev_count) {
	index -= 1;
}

prev_count = curr_count;

y = 100 + index*32;

alpha -= fade;

if (alpha <= 0) {
	instance_destroy();
}