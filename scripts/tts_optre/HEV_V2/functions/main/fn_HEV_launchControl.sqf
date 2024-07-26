/***
	
	***SHOULD ONLY BE EXECUTED INSIDE OF 'tts_fnc_HEV_initHev'***
	
	'tts_fnc_HEV_launchControl'
	
	Author: TheTimidShade
	
	Description:
	Controls the deployment of OPTRE HEV pods.
	
	Execution:
	Should only be executed on server/host player.
	
	Parameter(s):
	Passed by tts_fnc_HEV_initHev.
	
	Returns:
	NONE
	
***/

_HEVgroup = _this select 0;
_marker = _this select 1;
_startHeight = _this select 2;
_radius = _this select 3;
_landingEffects = _this select 4;

{
	[_x] spawn {
		_HEV = _this select 0;
		
		_HEV animate ["main_door_rotation",0];
		_HEV animate ["left_door_rotation",0];
		_HEV animate ["right_door_rotation",0];
		[_HEV, "LOCKED"] remoteExec ["setVehicleLock", _HEV];
		
		sleep 2;
		
		if (count (crew _HEV) > 0) then {
			_HEV setVariable ["HEV_hasPilot", true, true];
			
			if (isPlayer (gunner _HEV)) then {
				[] remoteExec ["tts_fnc_HEV_prepEffects", gunner _HEV];
			};
		}
		else {
			_HEV setVariable ["HEV_hasPilot", false, true];
		};
	};

} forEach _HEVgroup;

//Engine idle
sleep 3;

{
	sleep 0.2;
	
	[_x, _marker, _startHeight, _radius, _landingEffects] spawn tts_fnc_HEV_launchHev;

} forEach _HEVgroup;