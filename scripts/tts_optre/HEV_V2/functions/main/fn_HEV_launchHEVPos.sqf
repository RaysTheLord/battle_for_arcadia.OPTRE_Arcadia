_HEV = _this select 0;
_drop_pos = _this select 1;
_use_transition = _this select 2;
_startHeight = 5000;
_radius = 12;
_landingEffects = true;

_CHUTE_HEIGHT = 500;


_hasPilot = _HEV getVariable "HEV_hasPilot";
if (_hasPilot && isPlayer (gunner _HEV)) then {
    [] remoteExec ["tts_fnc_HEV_launchEffects", gunner _HEV];
};

sleep 1;

if (_use_transition && (_hasPilot && isPlayer (gunner _HEV))) then {
    [] remoteExec ["tts_fnc_HEV_transitionFade", gunner _HEV];
    sleep 2;
    [1, "BLACK", 4, 0] remoteExec ["BIS_fnc_fadeEffect", _x, false];
};

sleep 1;
_displaceHeading = round (random 360);
_displaceDistance = round (random _radius);

_insertionPos = ([_drop_pos select 0, _drop_pos select 1, 0]) getPos [_displaceDistance, _displaceHeading];
_insertionX = _insertionPos select 0;
_insertionY = _insertionPos select 1;


detach _HEV;
_HEV setVariable ["HEV_isLanded", false, true];

//Force eject if stuck for too long
_HEV spawn {
    sleep 90;    
    if (isPlayer (gunner _this)) then {
        [_this, 0, true] spawn OPTRE_Fnc_HEVDoor;
    };
};

if (!_use_transition) then {
    _direction = round (random 360);
    _HEV setDir _direction;
    _HEV setPosATL [_insertionX, _insertionY, _startHeight];    
};
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

_future = time + 20;
waitUntil {((getPosATL _HEV) select 2) < (_startHeight * 0.75) || time >= _future};

if (_hasPilot && isPlayer (gunner _HEV)) then {
    [_HEV, _startHeight] remoteExec ["tts_fnc_HEV_reentryEffects", gunner _HEV];
};

[_HEV, _startHeight] call tts_fnc_HEV_handleReentryFire;

_future = time + 15;
waitUntil {((getPosATL _HEV) select 2) < _CHUTE_HEIGHT || time >= _future};

[_HEV] call tts_fnc_HEV_handleChute;

_future = time + 10;
waitUntil {(isTouchingGround _HEV && (getPosATL _HEV select 2) < 2.5) || (getPosASL _HEV) select 2 < 1 || time >= _future};

_pos = getPos _HEV;

if (!(surfaceIsWater _pos)) then {
    _anchor = createVehicle ["Sign_Sphere10cm_F", [_pos select 0, _pos select 1, 0], [], 0, "NONE"];
    _anchor hideObjectGlobal true;

    _anchor setDir (getDir _HEV);
    _anchor setPosATL [_pos select 0, _pos select 1, 0];

    _HEV attachTo [_anchor, [0,0,1.3]];

    if (_landingEffects) then {
        [_HEV] remoteExec ["tts_fnc_PE_landingDust", 0];
    };

}
else {
    [_HEV] remoteExec ["tts_fnc_PE_waterSplash", 0];
};

_HEV setVariable ["HEV_isLanded", true, true];

if (_hasPilot && isPlayer (gunner _HEV)) then {
    [_HEV] remoteExec ["tts_fnc_HEV_crashEffects", gunner _HEV];
    [gunner _HEV, true] remoteExec ["allowDamage", gunner _HEV, false]
};

[_HEV] remoteExec ["tts_fnc_HEV_doorAction", gunner _HEV];


