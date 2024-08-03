/*
    Description:
    Sets the rank of a player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: NUMBER - New rank

    Returns:
    BOOL
*/

params ["_uid", "_rank"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//Check previous rank for reference
_prev_rank = [_uid] call get_ranked_rank;

//Skip the setting if the rank is already the same

//Set the rank
KP_liberation_playerRanks select _index set [2, _rank];

//Also set the player's rank
_ranks = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
_weapon_sways = [1, 0.85, 0.7, 0.55, 0.4, 0.25, 0.1];
_speeds = [1, 1.05, 1.1, 1.15, 1.2, 1.23, 1.25];

_player = _uid call BIS_fnc_getUnitByUID;
if (_rank > ((count _ranks) - 1)) then { _rank = (count _ranks) - 1}; 
if !(_player isEqualTo objNull) then {
    _player setUnitRank (_ranks select _rank);
    
    //Set the sway
    [_player, (_weapon_sways select _rank)] remoteExec ["setCustomAimCoef", 0];
    [_player, (_speeds select _rank)] remoteExec ["setAnimSpeedCoef", 0];
    
    if (_prev_rank == _rank) exitWith {true};
    if (_rank < _prev_rank) then {
        [name _player + " has been demoted to " + (_ranks select _rank)] remoteExec ["systemChat", 0];
    } else {
        [name _player + " has been promoted to " + (_ranks select _rank)] remoteExec ["systemChat", 0];
    };
    
};


true