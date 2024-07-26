//Crash effects for lifeboat passengers

_lifeboat = _this select 0;

if (player in _lifeboat) then {
	enableCamShake true;
	playSound "crashlanding";
	playSound "crashringing";
	
	cutText ["", "WHITE IN", 1];
	addCamShake [8,3,25];

	"DynamicBlur" ppEffectEnable true;   
	"DynamicBlur" ppEffectAdjust [10];
	"DynamicBlur" ppEffectCommit 0;     
	"DynamicBlur" ppEffectAdjust [0];
	"DynamicBlur" ppEffectCommit 6;  
	sleep 6;
	"radialBlur" ppEffectEnable false;
}
else {
	_lifeboat say3D ["crashlanding", 300];
};
