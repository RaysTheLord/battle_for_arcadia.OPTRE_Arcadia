_lifeboat = _this select 0;

while {alive _lifeboat} do {
	if (player in _lifeboat) then {
		playSound "crash_alarm_1";
		sleep 0.8;
	}
	else {
		_lifeboat say3D ["crash_alarm_1", 30];
		sleep 0.8;
	};
};