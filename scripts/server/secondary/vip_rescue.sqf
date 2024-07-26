/*
	Creates a secondary objective mission to rescue captured friendly commanders for half the intel gain of SAR (but a much lower cost)
	Configurable options (kp_liberation_config):
	GRLIB_secondary_missions_costs select 4 = intel cost for mission (default 3)
*/

//VIP units aren't really defined anywhere else, so I'm defining them now 
_vip_units =  ["OPTRE_UNSC_Navy_Soldier_Olive_Unarmed", "OPTRE_UNSC_Navy_Soldier_Blue_Unarmed", "OPTRE_UNSC_Navy_Soldier_Gray_Unarmed", "OPTRE_UNSC_Navy_Soldier_White_Unarmed", "OPTRE_UNSC_Navy_Soldier_Red_Unarmed", "OPTRE_UNSC_Navy_Officer_Dress", "OPTRE_ONI_Researcher", "OPTRE_UNSC_ONI_Soldier_Naval_Unarmed"];

//select random OPFOR owned town
_opfor_towns = [];

//check if opfor_sectors item is contained within sectors_capture and push into array
{
	if !(_x in blufor_sectors) then {
		_opfor_towns pushBack _x;
	};
} forEach sectors_allSectors;

// Check if town array is empty
if(count _opfor_towns == 0) exitWith {
	//if empty, throw error in log and call proper intel notification
	["No enemy-controlled sector to spawn VIP mission! (wtf)", "ERROR"] call KPLIB_fnc_log; 
};

_objective_town = selectRandom _opfor_towns;


//create 1500m radius marker at town
secondary_objective_position = getMarkerPos _objective_town;
secondary_objective_position_marker = secondary_objective_position;
publicVariable "secondary_objective_position_marker";
sleep 1;

//start secondary mission
GRLIB_secondary_in_progress = 4; publicVariable "GRLIB_secondary_in_progress";
[11] remoteExec ["remote_call_intel"];

//create note in log
diag_log format ["Starting VIP objective in %1",_objective_town];

//Time to spawn in the VIPs
private _pilotsGrp = createGroup [GRLIB_side_enemy, true];
[selectRandom _vip_units, secondary_objective_position, _pilotsGrp, "LIEUTENANT", 0.5] call KPLIB_fnc_createManagedUnit;
sleep 0.2;

[selectRandom _vip_units, secondary_objective_position, _pilotsGrp, "LIEUTENANT", 0.5] call KPLIB_fnc_createManagedUnit;
sleep 2;

private _pilotUnits = units _pilotsGrp;
{
    [ _x, true ] spawn prisonner_ai;
    _x setDir (random 360);
    sleep 0.5
} foreach (_pilotUnits);

//Now the baddies
private _grppatrol = createGroup [GRLIB_side_enemy, true];
private _grppatrolGrunts = createGroup [GRLIB_side_enemy, true];

{
    if (["WBK", _x] call BIS_fnc_inString || ["OPTREW", _x] call BIS_fnc_inString || ["IMS", _x] call BIS_fnc_inString) then {
        [_x, secondary_objective_position, _grppatrolGrunts, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
    } else {
        [_x, secondary_objective_position, _grppatrol, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
    };
} foreach ([] call KPLIB_fnc_getSquadComp);


//Get a building within the 1500 m sector to put them in
private _buildings = nearestObjects [secondary_objective_position, ["house"], 1500] select {       
  [_x, (count (units _grppatrol)) + (count _pilotUnits) + (count (units _grppatrolGrunts))] call BIS_fnc_isBuildingEnterable
}; 

//If there's a building, put them inside, otherwise let them chill
if (count _buildings > 0) then {
    _house = selectRandom _buildings;
    _house = _house buildingPos -1;       
    _house = _house call BIS_fnc_arrayShuffle;
    {       
        _x disableAI "PATH";       
        _x setUnitPos selectRandom ["UP","UP","MIDDLE"];       
        _x setPos (_house select _forEachIndex);       
        _x addEventHandler["Fired",{params ["_unit"];_unit enableAI "PATH";_unit setUnitPos "AUTO";_unit removeEventHandler ["Fired",_thisEventHandler];}];       
        _x triggerDynamicSimulation false;      
    } foreach (units _grppatrol); 
    //Move VIPs into position
    {       
        _x setPos (_house select (_forEachIndex + (count (units _grppatrol))));       
    } foreach _pilotUnits;
    //Move grunts in
    {       
        _x disableAI "PATH";       
        _x setUnitPos selectRandom ["UP","UP","MIDDLE"];       
        _x setPos (_house select (_forEachIndex + ((count (units _grppatrol)) + (count _pilotUnits)) ));       
        _x addEventHandler["Fired",{params ["_unit"];_unit enableAI "PATH";_unit setUnitPos "AUTO";_unit removeEventHandler ["Fired",_thisEventHandler];}];       
        _x triggerDynamicSimulation false;      
    } foreach (units _grppatrolGrunts); 
};

//Wait until the pilots are rescued
waitUntil {
    sleep 5;
    { ( alive _x ) && ( _x distance ( [ getpos _x ] call KPLIB_fnc_getNearestFob ) > 50 ) } count _pilotUnits == 0
};

sleep 5;
//Give rewards
private _alive_crew_count = { alive _x } count _pilotUnits;
if ( _alive_crew_count == 0 ) then {
    [13] remoteExec ["remote_call_intel"];
} else {
    [12] remoteExec ["remote_call_intel"];
    private _grp = createGroup [GRLIB_side_friendly, true];
    { [_x ] joinSilent _grp; } foreach _pilotUnits;
    while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
    {_x doFollow (leader _grp)} foreach units _grp;
    { [ _x ] spawn { sleep 600; deleteVehicle (_this select 0) } } foreach _pilotUnits;
};

resources_intel = resources_intel + (5 * _alive_crew_count);

//Add to secondary objective stats
stats_secondary_objectives = stats_secondary_objectives + 1;

//Run save
sleep 1;
[] spawn KPLIB_fnc_doSave;
sleep 3;

//declare secondary mission completed
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";

//create note in log
diag_log format ["VIPs rescue mission complete at %1.",_objective_town];