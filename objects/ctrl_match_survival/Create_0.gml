mainframe_health = 100;
task_rate = 500;
keygen_rate = 3600;
mob_rate = 1000;
tasklife = 1500;
tasks = ds_list_create();

actions[0] = "Reboot";
actions[1] = "Exfoliate";
actions[2] = "Debug";
actions[3] = "Authenticate";
actions[4] = "Repair";
actions[5] = "Interrogate";
actions[6] = "Deserialize";
actions[7] = "Jongle";
actions[8] = "Re-calibrate";
actions[9] = "Lactate";
action_count = 10;

alarm[0] = 1; // refresh keys
alarm[1] = 1; // task spawner
alarm[2] = 1; // spawn mobs

objective[0] = obj_player;
blockade_object = obj_blockade;

global.aigrid = mp_grid_create(0, 0, room_width / 16, room_height /16, 16, 16) //Set up Grid
mp_grid_add_instances(global.aigrid,obj_block,1) // Add objects to avoid