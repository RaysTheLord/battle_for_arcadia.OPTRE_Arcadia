/*
    add_ranked_player

    Description:
    Adds a player to the player list.

    Parameter(s):
        0: ARRAY - Array of player data, e.g [Name, Steam UID, Rank, Medals Array, Score, Airscore, Medal Score, Medal Airscore, Session ID]

    Returns:
    BOOL
*/

if (!isServer) exitWith {};

waitUntil{!isNil "KP_liberation_playerRanks"};

params [["_newPlayer", []]];

if (_newPlayer isEqualTo []) exitWith {false};

//Check if player already in playerlist
_uid =  _newPlayer select 1;

_index = [_uid] call get_player_index;
if (_index == -1) then {
    KP_liberation_playerRanks pushBack +_newPlayer;
} else {
    //Check for a name change
    if !((KP_liberation_playerRanks select _index select 0) isEqualTo (_newPlayer select 0)) then {
        //Set name
        [_uid, _newPlayer select 0] call set_ranked_name;
    };
    //Reset medal score, medal airscore
    [_uid, 0] call set_medal_score;
    [_uid, 0] call set_medal_airscore;
    //Set the passed session ID of the player
    [_uid, _newPlayer select 8] call set_session_id;
    
    //Set the rank of the player
    [_uid, [_uid] call get_ranked_rank] call set_ranked_rank;
};


true
