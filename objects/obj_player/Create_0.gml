/// @description player creation code

username = "jones";

xspeed = 0;
yspeed = 0;

//the movement speed per step
velocity = 10;

shooting = false;
weapon = Weapons.ASSAULT_RIFLE;
cooldown = false;
respawn = false;

foe = -1;

//match-related variables
team = false; //team? boolean (true = blue, false = red)
matchscore = 0;
kills = 0;
deaths = 0;
objhold = false; //holding objective? boolean

curr_kills = 0;
prev_kills = 0;

hp = 100;

target_x = 0;
target_y = 0;

//instance_create_depth(x, y, depth, obj_peer);