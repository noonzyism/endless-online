xspeed = 0;
yspeed = 0;

hp = 100; // client-side HP guesstimation

shooting = false;
draining = false;
foe = -1; // indicates the instance id of the last enemy to have damaged this peer


weapon = Weapons.ASSAULT_RIFLE;
cooldown = false;

curr_hp = hp;
prev_hp = hp;

aimx = 0;
aimy = 0;

username = "Player";

//match-related variables
team = true; //team? boolean (true = blue, false = red)
matchscore = 0;  //score
kills = 0;  //kills
deaths = 0;  //deaths
objhold = false;  //holding objective? boolean