private ["_units","_allHEVs","_frigate","_aiHevOverWater","_chuteArray"];

_pos							= ([_this,0,[0,0,0]] call BIS_fnc_param) call BIS_fnc_position; // The central position, where the ship will spawn (if wanted).

_units 							= [_this,1,[]] call BIS_fnc_param;								// Units that will be effected
_shipDeployment 				= [_this,2,"Frigate Lowering Arm"] call BIS_fnc_param;			// Lanch Sequence: "No Frigate" or "Frigate Lowering Arm"
_launchDelay	 				= [_this,3,10] call BIS_fnc_param;								// Launch Count Down, this will be set to 30 seconds if the mission is MP and the game has been running for less than 30 seconds to allow smooth start.
_randomXYVelocity 				= [_this,4,0.5] call BIS_fnc_param;								// Randomised Velocity 
_launchSpeed 					= [_this,5,-1] call BIS_fnc_param;								// Speed HEVs will be launched at
_manualControl					= [_this,6,1] call BIS_fnc_param;								// Can the player take manual control of the HEV? 0: No, 1: Rotate Only 2: Full Control (Not Implemented).

_startHeight 					= [_this,7,5500] call BIS_fnc_param;							// The Height your start at and the ship your are deployed from will spawn (if wanted)
_startHeight = 5000;
_hevDropArmtmosphereStartHeight = [_this,8,3000] call BIS_fnc_param;							// The height atmospheric entry effects start at
_hevDropArmtmosphereEndHeight 	= [_this,9,2000] call BIS_fnc_param;							// The height atmospheric entry effects end at
_chuteDeployHeightHeight 		= [_this,10,1000] call BIS_fnc_param;							// The height HEvs chute deploy at, the height engines switch off at
_chuteDetachHeight				= [_this,11,500] call BIS_fnc_param;							// The height the HEVs chute detaches at
_boasterHeight 					= [_this,12,100] call BIS_fnc_param;							// The height for the final stage rockets

_deleteFrigate					= [_this,13,true] call BIS_fnc_param;							// Should the frigate be deleted after the drop finished set this value to true, else false (if created). 
_deleteChutesOnDetach			= [_this,14,false] call BIS_fnc_param;							// TRUE chutes are deleted after they are detached fro, HEVs, FALSE they be added to the clean up system. 
_deleteHEVsAfter 				= [_this,15,600] call BIS_fnc_param;							// Number in seconds representing how much time must pass before the HEVs are allowed to be deleted.
						
_DirOfShip = 0; // direction ship faces WIP. 

if (str _pos == "[0,0,0]" or {alive _x} count _units < 1) exitWith {};
waitUntil {time > 0};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// Spawn HEVs //////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Spawn Frigate & HEVs
_allHEVs = switch _shipDeployment do {
	case "Frigate Lowering Arm": {
		_pos = [_pos, 100, _DirOfShip] call BIS_fnc_relPos;
		_frigate = createVehicle ["OPTRE_Frigate_UNSC", [(_pos select 0), (_pos select 1), _startHeight], [], 0, "none"];
		_frigate setDir _DirOfShip;
		([_frigate,_units] call OPTRE_Fnc_SpawnHEVsFrigate);
	};
	case "No Frigate": {
		([_units,_startHeight] call OPTRE_Fnc_SpawnHEVsNoFrigate);
	};
	case "ODST Frigate Room": {

	};
	default {
		([_units,_startHeight] call OPTRE_Fnc_SpawnHEVsNoFrigate);
	};
};

_hevArray = _allHEVs select 0;			// All hevs created
_hevArrayPlayer = _allHEVs select 1;	// All hevs created	for players
_hevArrayAi = _allHEVs select 2;		// All hevs created for ai
_listOfPlayers = _allHEVs select 3;		// All players units 
_listOfAi = _allHEVs select 4; 			// All ai units
_objectsToAlwaysBeDeleted = [_allHEVs,5,[]] call BIS_fnc_param; 
	

sleep 5;
{	
    _x setVariable ["HEV_hasPilot", true, true];
    [_x, _pos, false] remoteExec ["tts_fnc_HEV_launchHevPos", 2, false];	
} forEach _hevArray; 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Clean Up //////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
sleep 30;
if (!isNil "_frigate" AND _deleteFrigate) then {{deleteVehicle _x;} forEach [_frigate];};
{deleteVehicle _x;} forEach _objectsToAlwaysBeDeleted; 
[_hevArray,_deleteHEVsAfter] remoteExec ["OPTRE_fnc_HEVCleanUp", 2, false];


true;