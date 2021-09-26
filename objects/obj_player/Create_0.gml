/// @description player creation code

username = "jones";

xspeed = 0;
yspeed = 0;

//the movement speed per step
velocity = 10;

shooting = false;
weapon = Weapons.ASSAULT_RIFLE;
cooldown = false;

//match-related variables
team = false; //team? boolean (true = blue, false = red)
matchscore = 0;
kills = 0;
deaths = 0;
objhold = false; //holding objective? boolean

hp = 100;

//instance_create_depth(x, y, depth, obj_peer);