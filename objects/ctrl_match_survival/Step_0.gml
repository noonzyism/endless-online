if (instance_exists(ctrl_client)) {
	// we're not the host
	// the host will own the match logic, don't execute it locally
	// turning off alarms
	alarm[0] = -1;
	alarm[1] = -1;
	alarm[2] = -1;
}