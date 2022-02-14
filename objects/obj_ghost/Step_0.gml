move_towards_point(target.x, target.y, speed);

image_angle = point_direction(x, y, target.x, target.y);


if (distance_to_object(target) < 16) {
	dir=point_direction(x,y,target.x,target.y);
	x=x+lengthdir_x(-1,dir);
	y=y+lengthdir_y(-1,dir);
}

if (hp < 0) {
 instance_destroy();	
}