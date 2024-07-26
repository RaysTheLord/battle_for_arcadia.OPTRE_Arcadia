/***
	
	'tts_fnc_lifeboat_initLifeboat'
	
	Author: TheTimidShade
	
	Description:
	Performs setup of OPTRE lifeboat.
	
	Execution:
	Should only be executed on server/host player.
	
	Parameter(s):
	0	_lifeboat - OBJECT: The lifeboat object being set up.
	1	_launchHeight (OPTIONAL) - NUMBER: The height at which the pod is launched from.
	2	_crashParticles (OPTIONAL) - BOOLEAN: Whether or not particles are created when the pod collides with the ground. Default = true.
	3	_crashAlarm (OPTIONAL) - BOOLEAN: Whether or not the pod's impact alarm sounds after crashing. Default = true.
	
	Returns:
	NONE
	
***/

params [
	["_lifeboat", objNull, [objNull]],
	["_launchHeight", 3000, [0]],
	["_crashParticles", true, [true]],
	["_crashAlarm", true, [true]]
];

if (isNull _lifeboat) exitWith {
	["No lifeboat object provided in params, script terminated"] remoteExec ["systemChat", 0];
};

if (typeOf _lifeboat != "OPTRE_EscapePod") exitWith {
	["Object provided in params is not an OPTRE lifeboat, script terminated"] remoteExec ["systemChat", 0];
};

[_lifeboat, false] remoteExec ["allowDamage", 0];

_anchor = createVehicle ["Sign_Sphere10cm_F", getPosATL _lifeboat, [], 0, "NONE"];
_anchor hideObjectGlobal true;

_anchor setDir (getDir _lifeboat);
_anchor setPosATL (getPosATL _anchor);

_lifeboat attachTo [_anchor];

_lifeboat setVariable ["lifeboatIsLaunched", false, true];

[
	_lifeboat,											// Object the action is attached to
	"Launch lifeboat",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",	// Progress icon shown on screen
	"!(_target getVariable 'lifeboatIsLaunched') && driver _target == _this",						// Condition for the action to be shown
	"true",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{
		_pod = _this select 0;
		_launchHeight = (_this select 3) select 0;
		_crashParticles = (_this select 3) select 1;
		_crashAlarm = (_this select 3) select 2;
		
		[_pod, _launchHeight, _crashParticles, _crashAlarm] remoteExec ["tts_fnc_lifeboat_launchLifeboat", 2];
		
		_pod setVariable ["lifeboatIsLaunched", true, true];
		
		[_pod, "LOCKED"] remoteExec ["setVehicleLock", 0];
		//_pod setVehicleLock "LOCKED";
	},													// Code executed on completion
	{},													// Code executed on interrupted
	[_launchHeight, _crashParticles, _crashAlarm],													// Arguments passed to the scripts as _this select 3
	1,													// Action duration [s]
	6,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];		// MP compatible implementation