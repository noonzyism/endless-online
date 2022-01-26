// todo: don't hardcode the camera view values
x = clamp(lerp(x, obj_player.x, 0.08), 512, room_width-512);
y = clamp(lerp(y, obj_player.y, 0.08), 384, room_height-384);