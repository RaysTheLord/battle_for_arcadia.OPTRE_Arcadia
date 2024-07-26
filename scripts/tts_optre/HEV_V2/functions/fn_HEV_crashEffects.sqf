//Crash effects for HEV script

_HEV = _this select 0;
_id = clientOwner;
	
enableCamShake true;
playSound "crashlanding";

[_HEV, ["crashlanding", 300]] remoteExec ["say3D", -_id];
		
addCamShake [8,3,25];

"DynamicBlur" ppEffectEnable true;   
"DynamicBlur" ppEffectAdjust [10];
"DynamicBlur" ppEffectCommit 0;     
"DynamicBlur" ppEffectAdjust [0];
"DynamicBlur" ppEffectCommit 0.5;  
sleep 0.5;
"radialBlur" ppEffectEnable false;

[[_HEV], 300] remoteExec ["OPTRE_fnc_HEVCleanUp", 2, false];