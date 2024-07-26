/***
	
	***SHOULD ONLY BE EXECUTED INSIDE OF 'tts_fnc_HEV_launchControl'***
	
	'tts_fnc_HEV_launchHEV'
	
	Author: TheTimidShade
	
	Description:
	Launches invidivual HEV and handles descent + effects.
	
	Execution:
	Should only be executed on server/host player.
	
	Parameter(s):
	Passed by tts_fnc_HEV_launchControl.
	
	Returns:
	NONE
	
***/

_HEV = _this select 0;
_marker = _this select 1;
_startHeight = _this select 2;
_radius = _this select 3;
_landingEffects = _this select 4;

_CHUTE_HEIGHT = 500;

_hasPilot = _HEV getVariable "HEV_hasPilot";
if (_hasPilot && isPlayer (gunner _HEV)) then {
	[] remoteExec ["tts_fnc_HEV_launchEffects", gunner _HEV];
};

sleep 1;

if (_hasPilot && isPlayer (gunner _HEV)) then {
	[] remoteExec ["tts_fnc_HEV_transitionFade", gunner _HEV];
};

sleep 1;

_displaceHeading = round (random 360);
_displaceDistance = round (random _radius);

_insertionPos = (getMarkerPos _marker) getPos [_displaceDistance, _displaceHeading];
_insertionX = _insertionPos select 0;
_insertionY = _insertionPos select 1;

detach _HEV;
_HEV setVariable ["HEV_isLanded", false, true];

if (_hasPilot) then {
	[_HEV] remoteExec ["tts_fnc_HEV_doorAction", gunner _HEV];
};

_direction = round (random 360);
_HEV setDir _direction;

_HEV setPosATL [_insertionX, _insertionY, _startHeight];
_HEV setVelocity [0, 0, -15];

//Until the chute deploys, max speed of 100ms
[_HEV, _CHUTE_HEIGHT] spawn {
	_HEV = _this select 0;
	_CHUTE_HEIGHT = _this select 1;
	
	while {((getPosATL _HEV) select 2) > _CHUTE_HEIGHT} do {
		if (((velocity _HEV) select 2) < -150) then {
			_xVel = (velocity _HEV) select 0;
			_yVel = (velocity _HEV) select 1;
			
			_HEV setVelocity [_xVel, _yVel, -145];
		};
		
		sleep 0.1;
	};
};

[_HEV] call tts_fnc_HEV_handleLaunchBooster;

waitUntil {((getPosATL _HEV) select 2) < (_startHeight * 0.75)};

if (_hasPilot && isPlayer (gunner _HEV)) then {
	[_HEV, _startHeight] remoteExec ["tts_fnc_HEV_reentryEffects", gunner _HEV];
};

[_HEV, _startHeight] call tts_fnc_HEV_handleReentryFire;

waitUntil {((getPosATL _HEV) select 2) < _CHUTE_HEIGHT};

[_HEV] call tts_fnc_HEV_handleChute;

waitUntil {isTouchingGround _HEV && (getPosATL _HEV select 2) < 2.5 || (getPosASL _HEV) select 2 < 1};

_pos = getPos _HEV;

if (!(surfaceIsWater _pos)) then {
	_anchor = createVehicle ["Sign_Sphere10cm_F", [_pos select 0, _pos select 1, 0], [], 0, "NONE"];
	_anchor hideObjectGlobal true;

	_anchor setDir (getDir _HEV);
	_anchor setPosATL [_pos select 0, _pos select 1, 0];

	_HEV attachTo [_anchor, [0,0,1.3]];
	
	if (_landingEffects) then {
		[_HEV] remoteExec ["tts_fnc_PE_impactRocks", 0];
		[_HEV] remoteExec ["tts_fnc_PE_landingDust", 0];
	};
	
}
else {
	[_HEV] remoteExec ["tts_fnc_PE_waterSplash", 0];
};

_HEV setVariable ["HEV_isLanded", true, true];

if (_hasPilot && isPlayer (gunner _HEV)) then {
	[_HEV] remoteExec ["tts_fnc_HEV_crashEffects", gunner _HEV];
};