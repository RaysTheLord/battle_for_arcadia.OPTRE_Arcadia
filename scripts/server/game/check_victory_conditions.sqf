sleep 5;

if ([] call KP_liberation_victoryCheck && GRLIB_endgame != 1) then {
    GRLIB_endgame = 1;
    publicVariable "GRLIB_endgame";
    
    private _curDate = date;
    _curMonth = "";

    switch (_curDate select 1) do {
        case 1: { _curMonth = "Jan"; };
        case 2: { _curMonth = "Feb"; };
        case 3: { _curMonth = "Mar"; };
        case 4: { _curMonth = "Apr"; };
        case 5: { _curMonth = "May"; };
        case 6: { _curMonth = "Jun"; };
        case 7: { _curMonth = "Jul"; };
        case 8: { _curMonth = "Aug"; };
        case 9: { _curMonth = "Sep"; };
        case 10: { _curMonth = "Oct"; };
        case 11: { _curMonth = "Nov"; };
        case 12: { _curMonth = "Dec"; };
        default { _curMonth = "???"; };
    };

    private _dateString = format ["%3 %2 %1",
        _curDate select 0,
        _curMonth,
        (if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)
    ];

    {
        _x allowDamage false; 
        (vehicle _x) allowDamage false;
        //award all players distinguished service medal
        _medal_str = format ["(%1) For exceptionally meritous service in defending humanity.", _dateString];
        [getPlayerUID _x, ["ndsm", _medal_str]] call add_ranked_medal;        
    } forEach allPlayers;
    //Award Colonial Cross to...
    _colonial_cross_awardees = [];
    //Scan the ranks array for max score, max airscore, and max medals
    _max_score = -1;
    _max_airscore = -1;
    _max_medals = -1;
    
    //Thresholds to be considered for scoring
    _score_thresh = 500;
    _airscore_thresh = 2500;
    _medals_thresh = 3;
    {
        //Get score
        if (_max_score < (_x select 4)) then {
            _max_score = (_x select 4);
        };
        //Get airscore
        if (_max_airscore < (_x select 5)) then {
            _max_airscore = (_x select 5);
        };
        //Get medals
        _cur_medals = _x select 3;
        _medal_count = 0;
        for "_i" from 0 to ((count _cur_medals) - 1) do { 
            _medal_count = _medal_count + (_cur_medals select _i select 1);
        };
        if (_max_medals < _medal_count) then {
            _max_medals = _medal_count;
        };
    } forEach KP_liberation_playerRanks;
    
    {
        //Players within 50 of the top XP
        _uid = _x select 1;
        if ((_x select 4) >= _score_thresh && (_x select 4) >= (_max_score - 50)) then {
            _colonial_cross_awardees pushBackUnique _uid;
        };
        //Within top 50 of the top airscore
        if ((_x select 5) >= _airscore_thresh && (_x select 5) >= (_max_airscore - 50)) then {
            _colonial_cross_awardees pushBackUnique _uid;
        };
        //Having most medals above a threshold
        _cur_medals = _x select 3;
        _medal_count = 0;
        for "_i" from 0 to ((count _cur_medals) - 1) do { 
            _medal_count = _medal_count + (_cur_medals select _i select 1);
        };
        if (_medal_count >= _medals_thresh && _medal_count >= (_max_medals - 1)) then {
            _colonial_cross_awardees pushBackUnique _uid;
        };
    } forEach KP_liberation_playerRanks;
    //Award the colonial cross
    {
        _medal_str = format ["(%1) For acts of singular daring and devotion in battle.", _dateString];
        [_x, ["cc", _medal_str]] call add_ranked_medal;        
    } forEach _colonial_cross_awardees;


    
    
    private _rabbits = round (random 75) + round (random 80);

    publicstats = [];
    publicstats pushback stats_ammo_produced;
    publicstats pushback stats_ammo_spent;
    publicstats pushback stats_blufor_soldiers_killed;
    publicstats pushback stats_blufor_soldiers_recruited;
    publicstats pushback stats_blufor_teamkills;
    publicstats pushback stats_blufor_vehicles_built;
    publicstats pushback stats_blufor_vehicles_killed;
    publicstats pushback stats_civilian_buildings_destroyed;
    publicstats pushback stats_civilian_vehicles_killed;
    publicstats pushback stats_civilian_vehicles_killed_by_players;
    publicstats pushback stats_civilian_vehicles_seized;
    publicstats pushback stats_civilians_healed;
    publicstats pushback stats_civilians_killed;
    publicstats pushback stats_civilians_killed_by_players;
    publicstats pushback stats_fobs_built;
    publicstats pushback stats_fobs_lost;
    publicstats pushback stats_fuel_produced;
    publicstats pushback stats_fuel_spent;
    publicstats pushback stats_hostile_battlegroups;
    publicstats pushback stats_ieds_detonated;
    publicstats pushback stats_opfor_killed_by_players;
    publicstats pushback stats_opfor_soldiers_killed;
    publicstats pushback stats_opfor_vehicles_killed;
    publicstats pushback stats_opfor_vehicles_killed_by_players;
    publicstats pushback stats_player_deaths;
    publicstats pushback stats_playtime;
    publicstats pushback stats_prisoners_captured;
    publicstats pushback stats_readiness_earned;
    publicstats pushback stats_reinforcements_called;
    publicstats pushback stats_resistance_killed;
    publicstats pushback stats_resistance_teamkills;
    publicstats pushback stats_resistance_teamkills_by_players;
    publicstats pushback stats_secondary_objectives;
    publicstats pushback stats_sectors_liberated;
    publicstats pushback stats_sectors_lost;
    publicstats pushback stats_spartan_respawns;
    publicstats pushback stats_supplies_produced;
    publicstats pushback stats_supplies_spent;
    publicstats pushback stats_vehicles_recycled;
    publicstats pushback _rabbits;

    publicstats remoteExec ["remote_call_endgame"];

    private _playtime_days = floor (stats_playtime / 86400);
    private _playtime_hours = floor ((stats_playtime % 86400) / 3600);
    private _playtime_minutes = floor ((stats_playtime % 3600) / 60);
    private _playtime_seconds = stats_playtime % 60;

    ["------------------------------------", "MISSION END"] call KPLIB_fnc_log;
    [format ["Playtime: %1 days, %2 hours, %3 minutes, %4 seconds", _playtime_days, _playtime_hours, _playtime_minutes, _playtime_seconds], "MISSION END"] call KPLIB_fnc_log;
    [format ["OPFOR infantry killed: %1", stats_opfor_soldiers_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["OPFOR infantry killed by players: %1", stats_opfor_killed_by_players], "MISSION END"] call KPLIB_fnc_log;
    [format ["OPFOR vehicles destroyed: %1", stats_opfor_vehicles_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["OPFOR vehicles destroyed by players: %1", stats_opfor_vehicles_killed_by_players], "MISSION END"] call KPLIB_fnc_log;
    [format ["BLUFOR infantry recruited: %1", stats_blufor_soldiers_recruited], "MISSION END"] call KPLIB_fnc_log;
    [format ["BLUFOR infantry killed: %1", stats_blufor_soldiers_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["BLUFOR vehicles built: %1", stats_blufor_vehicles_built], "MISSION END"] call KPLIB_fnc_log;
    [format ["BLUFOR vehicles destroyed: %1", stats_blufor_vehicles_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Player deaths: %1", stats_player_deaths], "MISSION END"] call KPLIB_fnc_log;
    [format ["BLUFOR friendly fire incidents: %1", stats_blufor_teamkills], "MISSION END"] call KPLIB_fnc_log;
    [format ["Resistance fighters killed: %1", stats_resistance_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Resistance fighters (friendly) killed: %1", stats_resistance_teamkills], "MISSION END"] call KPLIB_fnc_log;
    [format ["Resistance fighters (friendly) killed by players: %1", stats_resistance_teamkills_by_players], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilians killed: %1", stats_civilians_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilians killed by players: %1", stats_civilians_killed_by_players], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilians healed: %1", stats_civilians_healed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilian vehicles destroyed: %1", stats_civilian_vehicles_killed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilian vehicles destroyed by players: %1", stats_civilian_vehicles_killed_by_players], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilian vehicles seized: %1", stats_civilian_vehicles_seized], "MISSION END"] call KPLIB_fnc_log;
    [format ["Civilian buildings destroyed: %1", stats_civilian_buildings_destroyed], "MISSION END"] call KPLIB_fnc_log;
    [format ["Vehicles recycled: %1", stats_vehicles_recycled], "MISSION END"] call KPLIB_fnc_log;
    [format ["Ammunition units produced: %1", stats_ammo_produced], "MISSION END"] call KPLIB_fnc_log;
    [format ["Ammunition units spent: %1", stats_ammo_spent], "MISSION END"] call KPLIB_fnc_log;
    [format ["Fuel units produced: %1", stats_fuel_produced], "MISSION END"] call KPLIB_fnc_log;
    [format ["Fuel units spent: %1", stats_fuel_spent], "MISSION END"] call KPLIB_fnc_log;
    [format ["Supply units produced: %1", stats_supplies_produced], "MISSION END"] call KPLIB_fnc_log;
    [format ["Supply units spent: %1", stats_supplies_spent], "MISSION END"] call KPLIB_fnc_log;
    [format ["Sectors liberated: %1", stats_sectors_liberated], "MISSION END"] call KPLIB_fnc_log;
    [format ["Sectors lost: %1", stats_sectors_lost], "MISSION END"] call KPLIB_fnc_log;
    [format ["FOBs built: %1", stats_fobs_built], "MISSION END"] call KPLIB_fnc_log;
    [format ["FOBs lost: %1", stats_fobs_lost], "MISSION END"] call KPLIB_fnc_log;
    [format ["Secondary objectives accomplished: %1", stats_secondary_objectives], "MISSION END"] call KPLIB_fnc_log;
    [format ["Prisoners captured: %1", stats_prisoners_captured], "MISSION END"] call KPLIB_fnc_log;
    [format ["Hostile battlegroups called: %1", stats_hostile_battlegroups], "MISSION END"] call KPLIB_fnc_log;
    [format ["Hostile reinforcements called: %1", stats_reinforcements_called], "MISSION END"] call KPLIB_fnc_log;
    [format ["Total combat readiness raised: %1", round stats_readiness_earned], "MISSION END"] call KPLIB_fnc_log;
    [format ["IEDs detonated: %1", stats_ieds_detonated], "MISSION END"] call KPLIB_fnc_log;
    [format ["Number of White Knight losses: %1", stats_spartan_respawns], "MISSION END"] call KPLIB_fnc_log;
    [format ["Grunts Teabagged: %1", _rabbits], "MISSION END"] call KPLIB_fnc_log;
    [format ["Final rank info: %1", str KP_liberation_playerRanks], "MISSION END"] call KPLIB_fnc_log;
    ["------------------------------------", "MISSION END"] call KPLIB_fnc_log;

    sleep 20;

    {if !(isPlayer _x) then {deleteVehicle _x;}} forEach allUnits;
};
