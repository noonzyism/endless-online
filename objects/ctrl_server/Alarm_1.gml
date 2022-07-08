/// @description Match State Continual Sync

#region Mob Sync
// Note: Mobs are created and initially sent to clients by the ctrl_match_survival handler
// This just handles positional syncs, which don't need to be super-frequent realtime

mob_ticker += 1;
if (mob_ticker >= instance_number(par_mob)) {
	mob_ticker = 0;
}

var mob = instance_find(par_mob, mob_ticker);
if (mob != noone) {
	broadcast_survival_mob(session, false, 0, get_client_id_for_instance(mob.target), mob.x, mob.y, mob.speed, instance_number(par_mob));
}

#endregion

alarm[1] = syncrate_match;