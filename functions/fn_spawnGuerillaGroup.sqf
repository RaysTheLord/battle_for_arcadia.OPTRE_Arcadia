/*
    File: fn_spawnGuerillaGroup.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2017-10-08
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Spawns a group of guerilla units with random gear depending on guerilla strength.

    Parameter(s):
        _pos    - Position where to spawn the group                             [POSITION, defaults to [0, 0, 0]]
        _amount - Amount of units for the group. 0 for automatic calculation    [NUMBER, defaults to 0]

    Returns:
        Spawned group [GROUP]
*/

params [
    ["_pos", [0, 0, 0], []],
    ["_amount", 0, []]
];

// Get tier and civilian reputation depending values
private _tier = [] call KPLIB_fnc_getResistanceTier;
private _cr_multi = [] call KPLIB_fnc_crGetMulti;
if (_amount == 0) then {_amount = (6 + (round (random _cr_multi)) + (round (random _tier)));};
private _weapons = missionNamespace getVariable ("KP_liberation_guerilla_weapons_" + str _tier);
private _uniforms = missionNamespace getVariable ("KP_liberation_guerilla_uniforms_" + str _tier);
private _vests = missionNamespace getVariable ("KP_liberation_guerilla_vests_" + str _tier);
private _headgear = missionNamespace getVariable ("KP_liberation_guerilla_headgear_" + str _tier);

//OVERRIDE LIST OF UNITS
_t1_elites_pool = ["OPTRE_CPD_Officer_M392", "OPTRE_CPD_Officer_M45", "OPTRE_CPD_Officer_M7", "OPTRE_CPD_Officer_MA37K"];
_t2_elites_pool = ["OPTRE_CPD_Riot_Officer"];
_t2_elites_pool = ["OPTRE_CPD_SWAT_Bulldog", "OPTRE_CPD_SWAT_M392", "OPTRE_CPD_SWAT_M45", "OPTRE_CPD_SWAT_M7", "OPTRE_CPD_SWAT_MA37K", "OPTRE_CPD_SWAT_RIOTCQQS48", "OPTRE_CPD_SWAT_RIOTM7", "OPTRE_CPD_SWAT_SRS99", "OPTRE_CPD_SWAT_Tactical_Sniper", "OPTRE_CPD_SWAT_VK78"];

_grunts_pool = ["OPTRE_CPD_Officer"];
_hunter_pool = ["OPTRE_CPD_Juggernaut"];
_hunter_chance = 5 * _tier;
_hunter_left = 0;

// Spawn guerilla units
private _grp = createGroup [GRLIB_side_resistance, true];
private _unit = objNull;
private _weapon = [];
private _selected_unit = "";
for "_i" from 1 to _amount do {
    // Create unit
    if ((_i - 1) % 6 < 2) then {
        if (_i > 2 && _hunter_left <= 0 && random 100 <= _hunter_chance) then {
            _hunter_left = 2;
        };
        if(_hunter_left > 0) then {
            _hunter_left = _hunter_left - 1;
            _selected_unit = selectRandom _hunter_pool;
        } else {
            switch (_tier) do {
                case 2: { _selected_unit = selectRandom _t2_elites_pool; };
                case 3: { _selected_unit = selectRandom _t3_elites_pool; };
                default { _selected_unit = selectRandom _t1_elites_pool; };
            };        
        };
    } else {
        _selected_unit = selectRandom _grunts_pool;
    };
    _unit = [_selected_unit, _pos, _grp, "PRIVATE", 5] call KPLIB_fnc_createManagedUnit;

};

_grp
