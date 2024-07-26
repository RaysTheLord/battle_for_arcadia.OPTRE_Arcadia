//Local HEV reentry effects

_HEV = _this select 0;
_startHeight = _this select 1;
	
enableCamShake true;
addCamShake [3,30,25];
		
while {(getPosATL _HEV) select 2 > (_startHeight * 0.5)} do {
	sleep 0.5;
	playSound "reentry_loop";
	addCamShake [2,3,25];
};