randomize();

// choose a terminal instance at random
taskpoint = instance_find(obj_terminal, irandom(instance_number(obj_terminal) - 1));

verb = ctrl_match_survival.actions[irandom(7)];

description = verb + " the " + taskpoint.objname;

alarm[0] = ctrl_match_survival.tasklife;

success = false;