/*
    Description:
    Adds airscore to existing player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: NUMBER - Airscore to add

    Returns:
    BOOL
*/

private _air_medals = ["am", "dfc"];
private _air_medal_thresholds = [1250, 2250];
private _air_medal_strings = [
    "(%1) For heroic achievements while participating in aerial flight in combat at %2.",
    "(%1) For extraordinary heroism and achievement while participating in aerial flight in combat at %2."
];

params ["_uid", "_airscore"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//First, figure out final total
_current_airscore = [_uid] call get_ranked_airscore;

_new_airscore = _current_airscore + _airscore;

if (_new_airscore < 0) then { _new_airscore = 0 };


//Also figure out totals for medal score
_current_medal_score = [_uid] call get_medal_airscore;

_new_medal_score = _current_medal_score + _airscore;
if (_new_medal_score < 0) then { _new_medal_score = 0 };
//Set medal score
[_uid, _new_medal_score] call set_medal_airscore;

//Medal logic
private _curDate = date;
_curMonth = "";

switch (_curDate select 1) do {
    case 1: { _curMonth = "Jan"; };
    case 2: { _curMonth = "Feb"; };
    case 3: { _curMonth = "Mar"; };
    case 4: { _curMonth = "Apr"; };
    case 5: { _curMonth = "May"; };
    case 6: { _curMonth = "Jun"; };
    case 7: { _curMonth = "Jul"; };
    case 8: { _curMonth = "Aug"; };
    case 9: { _curMonth = "Sep"; };
    case 10: { _curMonth = "Oct"; };
    case 11: { _curMonth = "Nov"; };
    case 12: { _curMonth = "Dec"; };
    default { _curMonth = "???"; };
};

private _dateString = format ["%3 %2 %1",
	_curDate select 0,
	_curMonth,
	(if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)
];

_medal_loc = [getPos (_uid call BIS_fnc_getUnitByUID)] call KPLIB_fnc_getLocationName;
if (_medal_loc isEqualTo "") then {
    _medal_loc = "an unmarked location";
};

for "_i" from 0 to ((count _air_medals) - 2) do {
    if (_new_medal_score >= (_air_medal_thresholds select _i) && _new_medal_score < (_air_medal_thresholds select (_i + 1))) then {
        //Give the medal
        _medal_str = format [_air_medal_strings select _i, _dateString, _medal_loc];
        [_uid, [_air_medals select _i, _medal_str]] call add_ranked_medal;
    };
};

_final_index = ((count _air_medals) - 1);
if (_new_medal_score >= (_air_medal_thresholds select _final_index)) then {
    _medal_str = format [_air_medal_strings select _final_index, _dateString, _medal_loc];
    [_uid, [_air_medals select _final_index, _medal_str]] call add_ranked_medal;
};


//Finally, set the airscore
[_uid, _new_airscore] call set_ranked_airscore