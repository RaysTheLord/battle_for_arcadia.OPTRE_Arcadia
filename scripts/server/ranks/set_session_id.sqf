/*
    Description:
    Sets the session ID, which is used to track individual medals
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: STRING - The session ID for the player, used to track unique medals per session.

    Returns:
    BOOL
*/

params ["_uid", "_session"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//Else set the score
KP_liberation_playerRanks select _index set [8, _session];

true