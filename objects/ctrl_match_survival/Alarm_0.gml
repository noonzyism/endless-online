/// @description Refresh Security Keys

alpha_key = irandom_range(10000, 64000);
sigma_key = irandom_range(10000, 64000);
delta_key = irandom_range(10000, 64000);
omega_key = irandom_range(10000, 64000);

alarm[0] = keygen_rate;

#region host-only

if (instance_exists(ctrl_server)) {
	broadcast_survival_keys(ctrl_server.session);
}

#endregion