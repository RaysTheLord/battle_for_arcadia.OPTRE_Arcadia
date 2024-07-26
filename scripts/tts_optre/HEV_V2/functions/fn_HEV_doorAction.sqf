//Handles the action for ejecting the door of the HEV

_HEV = _this select 0;

if (isPlayer (gunner _HEV)) then {
	[
		_HEV,																	// Object the action is attached to
		"Eject Door",														// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Progress icon shown on screen
		"_target getVariable 'HEV_isLanded'",																// Condition for the action to be shown
		"true",																// Condition for the action to progress
		{},																	// Code executed when action starts
		{},																	// Code executed on every progress tick
		{
			
			_HEV = _this select 0;
			_id = clientOwner;
				
			playSound "steam_hiss";
			[_HEV, ["steam_hiss", 100]] remoteExec ["say3D",-_id];
			[_HEV] remoteExec ["tts_fnc_PE_podSteam", 0];
				
			sleep 2;
			[_HEV, 0, true] spawn OPTRE_Fnc_HEVDoor;
			[_HEV] remoteExec ["tts_fnc_PE_doorSparks", 0];
			[_HEV, "UNLOCKED"] remoteExec ["setVehicleLock", _HEV];
		},													// Code executed on completion
		{},													// Code executed on interrupted
		[],												// Arguments passed to the scripts as _this select 3
		1,													// Action duration [s]
		6,													// Priority
		true,												// Remove on completion
		false												// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd", gunner _HEV];
}
else {
	waitUntil {_HEV getVariable "HEV_isLanded";};
	
	sleep 5 + random 5;
	
	[_HEV, ["steam_hiss", 100]] remoteExec ["say3D",0];
	[_HEV] remoteExec ["tts_fnc_PE_podSteam", 0];
	
	sleep 2;
	
	[_HEV, 0, true] spawn OPTRE_Fnc_HEVDoor;
	[_HEV] remoteExec ["tts_fnc_PE_doorSparks", 0];
	_HEV setVehicleLock "UNLOCKED";
    
    _HEV setVariable ["HEV_isLanded", false, true];
};

