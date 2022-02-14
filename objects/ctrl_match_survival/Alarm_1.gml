/// @description Task Spawner

// create a task
instance_create_depth(x, y, depth, obj_task);

// reset the task spawner clock
alarm[1] = task_rate;