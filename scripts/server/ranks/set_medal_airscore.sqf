/*
    Description:
    Sets the airscore of a player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: NUMBER - New medal airscore, which is reset every session (for medal tracking)

    Returns:
    BOOL
*/

params ["_uid", "_airscore"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//Else set the airscore
KP_liberation_playerRanks select _index set [7, _airscore];

true