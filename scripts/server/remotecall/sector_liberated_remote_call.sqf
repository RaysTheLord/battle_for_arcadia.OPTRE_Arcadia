params ["_liberated_sector"];

private _combat_readiness_increase = 0;
switch (true) do {
    case (_liberated_sector in sectors_bigtown):    {_combat_readiness_increase = floor (random 10) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_capture):    {_combat_readiness_increase = floor (random 6) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_military):   {_combat_readiness_increase = 5 + (floor (random 11)) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_factory):    {_combat_readiness_increase = 3 + (floor (random 7)) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_tower):      {_combat_readiness_increase = floor (random 4);};
};

combat_readiness = combat_readiness + _combat_readiness_increase;
if (combat_readiness > 100.0 && GRLIB_difficulty_modifier <= 2.0) then {combat_readiness = 100.0};
resources_intel = resources_intel + _combat_readiness_increase;
stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;

[_liberated_sector, 0] remoteExecCall ["remote_call_sector"];
blufor_sectors pushback _liberated_sector; publicVariable "blufor_sectors";
stats_sectors_liberated = stats_sectors_liberated + 1;

reset_battlegroups_ai = true; publicVariable "reset_battlegroups_ai";

if (_liberated_sector in sectors_factory) then {
    {
        if (_liberated_sector in _x) exitWith {KP_liberation_production = KP_liberation_production - [_x];};
    } forEach KP_liberation_production;

    private _sectorFacilities = (KP_liberation_production_markers select {_liberated_sector == (_x select 0)}) select 0;
    KP_liberation_production pushBack [
        markerText _liberated_sector,
        _liberated_sector,
        1,
        [],
        _sectorFacilities select 1,
        _sectorFacilities select 2,
        _sectorFacilities select 3,
        3,
        KP_liberation_production_interval,
        0,
        0,
        0
    ];
};

[_liberated_sector] spawn F_cr_liberatedSector;

if ((random 100) <= KP_liberation_cr_wounded_chance || (count blufor_sectors) == 1) then {
    [_liberated_sector] spawn civrep_wounded_civs;
};

asymm_blocked_sectors pushBack [_liberated_sector, time];
publicVariable "asymm_blocked_sectors";

[] spawn check_victory_conditions;

sleep 1;

[] spawn KPLIB_fnc_doSave;

sleep 45;

if (GRLIB_endgame == 0) then {
    if (
        !(_liberated_sector in sectors_tower)
        && {
            (random (150 / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity))) < (combat_readiness - 15)
            || _liberated_sector in sectors_bigtown
        }
        && {[] call KPLIB_fnc_getOpforCap < GRLIB_battlegroup_cap}
    ) then {
        [_liberated_sector, (random 100) < 45] spawn spawn_battlegroup;
        
        //COVENANT ASSAULT
        _punished = false;

        _position = markerPos _liberated_sector;
        _directions = [0, 45, 90, 135, 180, 225, 270, 315];
        _scarab_chance = 15;
        
        if (!_punished && combat_readiness >= 95) then {
            _punished = true;
            //Glass the area
            [_position, selectRandom _directions, 2000, 1000, true] call PHAN_ScifiSupportPlus_fnc_COV_GlassingStrike;
        };
        if (!_punished && (combat_readiness > (40 + (30 / GRLIB_csat_aggressivity)))) then {
            _punished = true;
            //Armed covenant cruiser or Scarab
            if(((random 100) <= _scarab_chance)) then {
                [_position, selectRandom _directions, selectRandom ["NJP_Scarab_Hull_Base", "NJP_Scarab_Hull_AT", "NJP_Scarab_Hull_AA", "NJP_Scarab_Hull_Cmdr", "NJP_Scarab_Hull_Cmdr_AA"]] call PHAN_ScifiSupportPlus_fnc_COV_ScarabDrop;
            } else {
                [_position, selectRandom _directions, 750, "COV_CCS", 1] call PHAN_ScifiSupportPlus_fnc_COV_ArmedCruiser;
            };
        };
        if (!_punished && (combat_readiness > (20 + (30 / GRLIB_csat_aggressivity)))) then {
            _punished = true;
            //SDV Bombardment
            [_position, selectRandom _directions, 1000, true] call PHAN_ScifiSupportPlus_fnc_COV_SDV_Bombardment;
        };
        if (!_punished && (combat_readiness > (0 + (30 / GRLIB_csat_aggressivity)))) then {
            _punished = true;
            //Mortar strikes
            [_position, 1000, 50] call PHAN_ScifiSupportPlus_fnc_COV_PlasmaMortar;
        };

    };
};
