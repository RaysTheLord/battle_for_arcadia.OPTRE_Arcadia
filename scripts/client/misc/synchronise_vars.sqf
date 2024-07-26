one_synchro_done = false;
synchro_done = false;

waitUntil {!isNil "sync_vars"};

//To check for rank data changes
private _KP_liberation_playerRanks_old = [];

while {true} do {
    waitUntil {sleep 0.2; (count sync_vars) > 0};
    
    KP_liberation_fob_resources = sync_vars select 0;
    KP_liberation_supplies_global = sync_vars select 1;
    KP_liberation_ammo_global = sync_vars select 2;
    KP_liberation_fuel_global = sync_vars select 3;
    unitcap = sync_vars select 4;
    KP_liberation_heli_count = sync_vars select 5;
    KP_liberation_plane_count = sync_vars select 6;
    KP_liberation_heli_slots = sync_vars select 7;
    KP_liberation_plane_slots = sync_vars select 8;
    combat_readiness = sync_vars select 9;
    resources_intel = sync_vars select 10;
    infantry_cap = sync_vars select 11;
    KP_liberation_civ_rep = 100;
    KP_liberation_guerilla_strength = sync_vars select 13;
    infantry_weight = sync_vars select 14;
    armor_weight = sync_vars select 15;
    air_weight = sync_vars select 16;
    
    KP_liberation_playerRanks = sync_vars select 17;
    
    //Handle changes to the rank lineup
    if !(_KP_liberation_playerRanks_old isEqualTo KP_liberation_playerRanks) then {
        _KP_liberation_playerRanks_old = +KP_liberation_playerRanks;
        //TODO: When medal display is ready, refresh the medal display.  For now, we will simply print the rank info
        //systemChat str KP_liberation_playerRanks;
        //Recalculate our medals
        [] call recalculate_medal_entries;
    };
    

    sync_vars = [];
    one_synchro_done = true;
    synchro_done = true;
};
