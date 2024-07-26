/*
    File: fn_spawnMilitiaCrew.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Spawns a militia crew for given vehicle.

    Parameter(s):
        _vehicle - Vehicle to spawn the crew for [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith {["Null object given"] call BIS_fnc_error; false};

// Spawn units
private _grp = createGroup [GRLIB_side_enemy, true];
private _units = [];
//Select a unit at random to sample
_sample_unit = selectRandom militia_squad;

_wbk_only = false;
if (["WBK", _sample_unit] call BIS_fnc_inString || ["OPTREW", _sample_unit] call BIS_fnc_inString || ["IMS", _sample_unit] call BIS_fnc_inString) then {
    _wbk_only = true;
};
for "_i" from 1 to 3 do {
    _selected_unit = selectRandom militia_squad;
    while { !((_wbk_only && (["WBK", _selected_unit] call BIS_fnc_inString || ["OPTREW", _selected_unit] call BIS_fnc_inString || ["IMS", _selected_unit] call BIS_fnc_inString)) || (!_wbk_only && !(["WBK", _selected_unit] call BIS_fnc_inString || ["OPTREW", _selected_unit] call BIS_fnc_inString || ["IMS", _selected_unit] call BIS_fnc_inString))) } do {
        _selected_unit = selectRandom militia_squad;
    };
    _units pushBack ([_selected_unit, getPos _vehicle, _grp] call KPLIB_fnc_createManagedUnit);
};

// Assign to vehicle
(_units select 0) moveInDriver _vehicle;
(_units select 1) moveInGunner _vehicle;
(_units select 2) moveInCommander _vehicle;

// Remove possible leftovers
{
    if (isNull objectParent _x) then {
        deleteVehicle _x;
    };
} forEach _units;

true
