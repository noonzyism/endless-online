image_alpha = 0.5;
depth = 0;
speed = irandom_range(1, 5);
hp = 20;

target = instance_find(par_player, irandom(instance_number(par_player) - 1));