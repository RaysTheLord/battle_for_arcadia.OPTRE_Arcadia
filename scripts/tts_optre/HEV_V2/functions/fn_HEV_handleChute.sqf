//Handles the creation and operation of the drag chute

_HEV = _this select 0;
	
_chute = "OPTRE_HEV_Chute" createVehicle [0,0,0]; 
_chute attachTo [_HEV, [0,-0.2,1.961]];
	
_chute animate ["wing1_rotation",1];
_chute animate ["wing2_rotation",1];
_chute animate ["wing3_rotation",1];
_chute animate ["wing4_rotation",1];
	
sleep 0.5;

_hasPilot = _HEV getVariable "HEV_hasPilot";
if (_hasPilot && isPlayer (gunner _HEV)) then {
	["pod_detach"] remoteExec ["playSound", gunner _HEV];
};

_chute animate ["wing1_rotation",0];
_chute animate ["wing2_rotation",0];
_chute animate ["wing3_rotation",0];
_chute animate ["wing4_rotation",0];

_chute_float = time + 15;
//Slow down due to chute
while {((getPosATL _HEV) select 2) > 30 && time < _chute_float} do {
	if (((velocity _HEV) select 2) < -80) then {
		_xVel = (velocity _HEV) select 0;
		_yVel = (velocity _HEV) select 1;
			
		_HEV setVelocity [_xVel, _yVel, -80];
	};
		
	sleep 0.1;
};

waitUntil {((getPosATL _HEV) select 2) < 30 || time >= _chute_float};

deleteVehicle _chute;
if (_hasPilot && isPlayer (gunner _HEV)) then {
	["pod_detach"] remoteExec ["playSound", gunner _HEV];
};