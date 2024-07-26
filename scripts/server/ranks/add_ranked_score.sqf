/*
    Description:
    Adds score to existing player.  Also handles rank up when adding scores.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: NUMBER - Score to add

    Returns:
    BOOL
*/

private _ranks = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
private _score_ranks = [0, 500, 1500, 2500, 3500, 5000, 7500];

private _kill_medals = ["nam", "ncm", "bs", "ss", "nc", "loh"];
private _kill_medal_thresholds = [500, 875, 1500, 1875, 2250, 2500];
private _kill_medal_strings = [
    "(%1) For achievements in combat at %2.",
    "(%1) For outstanding achievements in combat at %2.",
    "(%1) For acts of heroism in combat at %2.",
    "(%1) For gallantry of action in combat at %2.",
    "(%1) For extraordinary heroism in combat at %2.",
    "(%1) For conspicuous gallantry and intrepidity at the risk of life, above and beyond the call of duty, in combat at %2."
];

params ["_uid", "_score"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//First, figure out final total
_current_score = [_uid] call get_ranked_score;
_new_score = _current_score + _score;

if (_new_score < 0) then { _new_score = 0 };

//Also figure out totals for medal score
_current_medal_score = [_uid] call get_medal_score;
_new_medal_score = _current_medal_score + _score;
if (_new_medal_score < 0) then { _new_medal_score = 0 };
//Set medal score
[_uid, _new_medal_score] call set_medal_score;

//Set rank
for "_i" from 0 to ((count _ranks) - 2) do {
    if (_new_score >= (_score_ranks select _i) && _new_score < (_score_ranks select _i + 1)) then {
        [_uid, _i] call set_ranked_rank;
    };
};

_final_index = ((count _ranks) - 1);
if (_new_score >= (_score_ranks select _final_index)) then {
    [_uid, _final_index] call set_ranked_rank;
};

//Add medal if needed
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

for "_i" from 0 to ((count _kill_medals) - 2) do {
    if (_new_medal_score >= (_kill_medal_thresholds select _i) && _new_medal_score < (_kill_medal_thresholds select (_i + 1))) then {
        //Give the medal
        _medal_str = format [_kill_medal_strings select _i, _dateString, _medal_loc];
        [_uid, [_kill_medals select _i, _medal_str]] call add_ranked_medal;
    };
};

_final_index = ((count _kill_medals) - 1);
if (_new_medal_score >= (_kill_medal_thresholds select _final_index)) then {
    _medal_str = format [_kill_medal_strings select _final_index, _dateString, _medal_loc];
    [_uid, [_kill_medals select _final_index, _medal_str]] call add_ranked_medal;
};


//Finally, set the score
[_uid, _new_score] call set_ranked_score