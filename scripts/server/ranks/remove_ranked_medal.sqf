/*
    Description:
    Remove medal from the existing player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: STRING - Medal ID to remove

    Returns:
    BOOL
*/

//NOTE: Medals stored in the form
//[Medal ID, Medal Level, Description Array, Session ID]

params ["_uid", "_medal_id"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

private _current_medals = [_uid] call get_ranked_medals;

//Find the medal
_medal_index = _current_medals findIf {(_x select 0) == _medal_id};

if(_medal_index == -1) exitWith {false};

//Assuming we have the medal, just rank down and remove one element from the text description
if ((_current_medals select _medal_index select 1) > 1) then {
    (_current_medals select _medal_index select 2) deleteAt ((count (_current_medals select _medal_index select 2)) - 1);
    (_current_medals select _medal_index) set [1, (_current_medals select _medal_index select 1) - 1];
    //Set the session ID to a failsafe to prevent it from being deleted again
    (_current_medals select _medal_index) set [3, "343"];
} else {
    //Delete the whole entry
    _current_medals deleteAt _medal_index;
};

[_uid, +_current_medals] call set_ranked_medals
