//Handles execution of fire particles

_HEV = _this select 0;
_startHeight = _this select 1;

[_HEV, 4, _startHeight] remoteExec ["tts_fnc_PE_fire", 0];