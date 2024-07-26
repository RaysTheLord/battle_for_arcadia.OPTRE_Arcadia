/***
	
	'tts_fnc_lifeboat_launchLifeboat'
	
	Author: TheTimidShade
	
	Description:
	Launches OPTRE lifeboat.
	
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

_lifeboat = _this select 0;
_launchHeight = _this select 1;
_crashParticles = _this select 2;
_crashAlarm = _this select 3;

[_lifeboat] remoteExec ["tts_fnc_PE_lifepodSparks", 0];

_lifePos = getPos _lifeboat;

detach _lifeboat;

_lifeboat setPosASL [_lifePos select 0, _lifePos select 1, _launchHeight];

_dir = getDir _lifeboat;
[[_dir, _lifeboat],{_dir = _this select 0; _lifeboat = _this select 1; _lifeboat setVelocity [(sin _dir) * 80, (cos _dir) * 80, 0]}] remoteExec ["spawn", _lifeboat];

//[_lifeboat, [(sin _dir) * 80, (cos _dir) * 80, 0]] remoteExec ["setVelocity", 0];

waitUntil {(isTouchingGround _lifeboat && (getPosATL _lifeboat select 2) < 8) || (getPosASL _lifeboat select 2) < 1};

_pos = getPos _lifeboat;

if (!(surfaceIsWater _pos)) then {
	_crater = createVehicle ["CraterLong", [_pos select 0, _pos select 1, 0], [], 0, "NONE"];

	_crater setDir (getDir _lifeboat);
	_crater setVectorUp surfaceNormal position _crater;

	_lifeboat attachTo [_crater, [0,0.5,1.5]];

	_crater2 = createVehicle ["CraterLong_small", [_pos select 0, _pos select 1, 0.3], [], 0, "NONE"];
	_crater2 setDir (getDir _lifeboat);
	_crater2 attachTo [_crater, [0,-6,-0.2]];
	_crater2 setVectorUp surfaceNormal position _crater2;

	_crater3 = createVehicle ["CraterLong_small", [_pos select 0, _pos select 1, 0.3], [], 0, "NONE"];
	_crater3 setDir (getDir _lifeboat);
	_crater3 attachTo [_crater, [0,-8,-0.2]];
	_crater3 setVectorUp surfaceNormal position _crater3;
	
	if (_crashParticles) then {
		[_lifeboat, 6, 120, true, 0.8, 0.5] remoteExec ["tts_fnc_PE_impactRocks", 0];
		[_lifeboat] remoteExec ["tts_fnc_PE_landingDust2", 0];
	};
}
else {
	[_lifeboat] remoteExec ["tts_fnc_PE_waterSplash", 0];
};

[_lifeboat] remoteExec ["tts_fnc_lifeboat_crashEffects", 0];

[[_lifeboat],{_lifeboat = _this select 0; _lifeboat setVehicleLock "UNLOCKED";}] remoteExec ["spawn", _lifeboat];
//_lifeboat setVehicleLock "UNLOCKED";

if (_crashAlarm) then {
	[_lifeboat] remoteExec ["tts_fnc_lifeboat_initCrashLoop", 0, true];
};
