/*
    Description:
    Sets the medals of a player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: ARRAY - New medals array

    Returns:
    BOOL
*/

params ["_uid", "_medals"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//Else set the medals
KP_liberation_playerRanks select _index set [3, _medals];

true