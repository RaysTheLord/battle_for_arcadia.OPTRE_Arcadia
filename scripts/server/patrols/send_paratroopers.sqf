params [
    ["_targetsector", "", ["",[]]],
    ["_chopper_type", objNull, [objNull]]
];

if (_targetsector isEqualTo "" || opfor_choppers isEqualTo []) exitWith {false};

private _targetpos = _targetsector;
if (_targetpos isEqualType "") then {
    _targetpos = markerPos _targetsector;
};
private _spawnsector = ([sectors_airspawn, [_targetpos], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
private _newvehicle = objNull;
private _pilot_group = grpNull;
if (isNull _chopper_type) then {
    _chopper_type = selectRandom opfor_choppers;

    while {!(_chopper_type in opfor_troup_transports)} do {
        _chopper_type = selectRandom opfor_choppers;
    };

    _newvehicle = createVehicle [_chopper_type, markerpos _spawnsector, [], 0, "FLY"];
    createVehicleCrew _newvehicle;
    
    _crew = crew _newvehicle;

    sleep 0.1;

    _pilot_group = createGroup [GRLIB_side_enemy, true];
    (_crew) joinSilent _pilot_group;

    _newvehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    {_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];} forEach (crew _newvehicle);
} else {
    _newvehicle = _chopper_type;
    _pilot_group = group _newvehicle;
};


while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
sleep 0.2;
{_x doFollow leader _pilot_group} forEach units _pilot_group;
sleep 0.2;

_newvehicle flyInHeight 100;



_waypoint = _pilot_group addWaypoint [_targetpos, 25];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 25];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_pilot_group setCurrentWaypoint [_pilot_group, 1];

_newvehicle flyInHeight 100;

waitUntil {sleep 1;
    !(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance _targetpos < 1500)
};

_newvehicle flyInHeight 100;

//DROP THE SOAP
doStop leader _pilot_group;
_newvehicle setFuel 0;

waitUntil {sleep 1;
    !(alive _newvehicle) || isTouchingGround _newvehicle;
};

//Spawn the bad guys directly
private _para_group = createGroup [GRLIB_side_enemy, true];
private _para_group_grunt = createGroup [GRLIB_side_enemy, true];

if (alive _newvehicle) then {

    _units_arr = [opfor_squad_leader, opfor_sentry, opfor_sentry, opfor_rifleman, opfor_rifleman, opfor_rifleman, opfor_rifleman, opfor_grenadier]; //Ordered list of units to spawn in a paratrooper group

    while {(count (units _para_group)) < 8} do {
        _selected_unit = _units_arr select count (units _para_group);
        if (["WBK", _selected_unit] call BIS_fnc_inString || ["OPTREW", _selected_unit] call BIS_fnc_inString || ["IMS", _selected_unit] call BIS_fnc_inString) then {
            [_selected_unit, getPos _newvehicle, _para_group_grunt] call KPLIB_fnc_createManagedUnit;
        } else {
            [_selected_unit, getPos _newvehicle, _para_group] call KPLIB_fnc_createManagedUnit;
        };        
    };

    _newvehicle setFuel 1;
    _newvehicle flyInHeight 100;
};

sleep 0.2;
while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
while {(count (waypoints _para_group_grunt)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
sleep 0.2;
{_x doFollow leader _pilot_group} foreach units _pilot_group;
{_x doFollow leader _para_group} foreach units _para_group;
{_x doFollow leader _para_group_grunt} foreach units _para_group_grunt;
sleep 0.2;

_newvehicle flyInHeight 100;

_waypoint = _pilot_group addWaypoint [_targetpos, 200];
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _pilot_group addWaypoint [_targetpos, 200];
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _pilot_group addWaypoint [_targetpos, 200];
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _pilot_group addWaypoint [_targetpos, 200];
_waypoint setWaypointType "SAD";
_waypoint = _pilot_group addWaypoint [_targetpos, 200];
_waypoint setWaypointType "SAD";
_pilot_group setCurrentWaypoint [_pilot_group, 1];

_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";

_waypoint = _para_group_grunt addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group_grunt addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group_grunt addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group_grunt addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group_grunt addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";

_pilot_group setCurrentWaypoint [_para_group, 1];
