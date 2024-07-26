/*
	Creates a secondary objective mission to assassinate an enemy commander to lower alert level by half of the level that FOBs do (but for much less cost)
	Configurable options (kp_liberation_config):
	GRLIB_secondary_missions_costs select 3 = intel cost for mission (default 5)
*/

_bodyguard_amount = floor (random [2, 4, 8]);

_bodyguard_types = [opfor_squad_leader, opfor_paratrooper, opfor_marksman, opfor_sharpshooter];

//select random OPFOR owned town (capture)

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
	["No enemy-controlled sector to spawn HVT mission! (wtf)", "ERROR"] call KPLIB_fnc_log; 
};

_objective_town = selectRandom _opfor_towns;


//create 1500m radius marker at town
secondary_objective_position = getMarkerPos _objective_town;
secondary_objective_position_marker = secondary_objective_position;
publicVariable "secondary_objective_position_marker";
sleep 1;

//start secondary mission
GRLIB_secondary_in_progress = 3; publicVariable "GRLIB_secondary_in_progress";
[9] remoteExec ["remote_call_intel"];

//create note in log
diag_log format ["Starting HVT Kill objective in %1",_objective_town];

//Time to spawn in the baddies
private _grppatrol = createGroup [GRLIB_side_enemy, true];

//Spawn in the HVT, which will be an officer
_hvt = [opfor_officer, secondary_objective_position, _grppatrol, "COLONEL", 0.5] call KPLIB_fnc_createManagedUnit;

//Now spawn in however many bodyguards we need
for "_i" from 1 to _bodyguard_amount do {
    [selectRandom _bodyguard_types, secondary_objective_position, _grppatrol, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
};

//Get a building within the 1500 m sector to put them in
private _buildings = nearestObjects [secondary_objective_position, ["house"], 1500] select {       
  [_x, count (units _grppatrol)] call BIS_fnc_isBuildingEnterable
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
};

//Wait until the bad guy is dead
waitUntil {
    sleep 5;
    !alive _hvt
};

//Give rewards
combat_readiness = round (combat_readiness * (GRLIB_secondary_objective_impact/2));

//Add to secondary objective stats
stats_secondary_objectives = stats_secondary_objectives + 1;

//Run save
sleep 1;
[] spawn KPLIB_fnc_doSave;
sleep 3;

//End notification
[10] remoteExec ["remote_call_intel"];

//declare secondary mission completed
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";

//create note in log
diag_log format ["HVT Killed at %1.",_objective_town];