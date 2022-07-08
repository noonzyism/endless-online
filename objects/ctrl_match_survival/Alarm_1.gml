/// @description Task Spawner

// create a task
var task = instance_create_depth(x, y, depth, obj_task);

// reset the task spawner clock
alarm[1] = task_rate;


#region host-only

if (instance_exists(ctrl_server)) {
	broadcast_survival_task(ctrl_server.session, task.description, tasklife, 0);
}

#endregion