/*
    Description:
    Gets the ranked score of a player.

    Parameter(s):
        0: STRING - Steam UID of the player

    Returns:
    NUMBER
*/

params ["_uid"];


private _index = [_uid] call get_player_index;
//Return -1 if not found
if (_index == -1) exitWith {-1};

(KP_liberation_playerRanks select _index) select 5