/***
	
	'tts_fnc_HEV_initHEV'
	
	***MODIFIED***
	
	Author: TheTimidShade
	
	Description:
	Performs setup of OPTRE HEV pod group.
	
	Execution:
	Should only be executed on server/host player.
	
	Parameter(s):
	0	_HEVgroup - ARRAY: Array of variable names of pods in launch group.
	1	_marker - STRING: Marker used as centre point for drop pod spread.
	2	_startHeight (OPTIONAL) - NUMBER: Height that the HEV pods are dropped from. Default = 8000.
	3	_radius (OPTIONAL) - NUMBER: Size of the circle that pods are distributed in. Default = 50.
	4	_landingEffects (OPTIONAL) - BOOLEAN: Whether or not dust and rock particles are created on landing. Default = true.
	
	Returns:
	NONE
	
***/

params [
	["_HEVgroup", [], [[]]],
	["_marker", "", [""]],
	["_startHeight", 8000, [0]],
	["_radius", 50, [0]],
	["_landingEffects", true, [true]]
];

//CHECK PARAMS

if ((count _HEVgroup) == 0) exitWith {
	["No HEVs provided in params, script terminated"] remoteExec ["systemChat", 0];
};
if (_marker == "" || getMarkerColor _marker == "") exitWith {
	["No valid marker provided for HEV drop point, script terminated"] remoteExec ["systemChat", 0];
};

{
	_pod = _x;
	
	_anchor = createVehicle ["Sign_Sphere10cm_F", getPosATL _pod, [], 0, "NONE"];
	_anchor hideObjectGlobal true;
	
	_vectorDir = vectorDir _pod;
	_vectorUp = vectorUp _pod;
	
	_pod attachTo [_anchor];
	_pod setVectorDirAndUp [_vectorDir, _vectorUp];
	
	if (_forEachIndex == 0) then { //Addaction to first HEV in list
		[
			_x,																	// Object the action is attached to
			"Launch HEVs",														// Title of the action
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",	// Idle icon shown on screen
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",	// Progress icon shown on screen
			"true",																// Condition for the action to be shown
			"true",																// Condition for the action to progress
			{},																	// Code executed when action starts
			{},																	// Code executed on every progress tick
			{
				_SLHEV = _this select 0;
				
				_HEVgroup = (_this select 3) select 0;
				_marker = (_this select 3) select 1;
				_startHeight = (_this select 3) select 2;
				_radius = (_this select 3) select 3;
				_landingEffects = (_this select 3) select 4;
				
				[_SLHEV] remoteExec ["removeAllActions", 0, "removeAllActionsQueue"];
				
				[_HEVgroup, _marker, _startHeight, _radius, _landingEffects] remoteExec ["tts_fnc_HEV_launchControl", 2, false];
			},													// Code executed on completion
			{},													// Code executed on interrupted
			[_HEVgroup, _marker, _startHeight, _radius, _landingEffects],	// Arguments passed to the scripts as _this select 3
			3,													// Action duration [s]
			6,													// Priority
			true,												// Remove on completion
			false												// Show in unconscious state 
		] remoteExec ["BIS_fnc_holdActionAdd", 0, "removeAllActionsQueue"];		// MP compatible implementation
	};
	
	_x animate ["main_door_rotation",1];
	_x animate ["left_door_rotation",1];
	_x animate ["right_door_rotation",1];
	
	_x setVariable ["OPTRE_PlayerControled",true,true];
	
}forEach _HEVgroup;