/*
    Description:
    Sets the name of a player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: STRING - New name to store

    Returns:
    BOOL
*/

params ["_uid", "_name"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//Else set the name
KP_liberation_playerRanks select _index set [0, _name];

true