/*
    reset_ranked_stats

    Description:
    Reset's all of a player's entries to their defaults.

    Parameter(s):
        0: STRING - Steam UID of the player (default: uid of current player)

    Returns:
    BOOL
*/

if (!isServer) exitWith {false};

waitUntil{!isNil "KP_liberation_playerRanks"};

params [["_uid", ""]];

if (_uid isEqualTo "") exitWith {false};

private _index = [_uid] call get_player_index;

// Return false, if uid wasn't found in the players array
if (_index == -1) exitWith {false};

// Set attributes to defaults
[_uid, 0] call set_ranked_rank;
[_uid, []] call set_ranked_medals;
[_uid, 0] call set_ranked_score;
[_uid, 0] call set_ranked_airscore;
[_uid, 0] call set_medal_score;
[_uid, 0] call set_medal_airscore;

//Shouldn't need to reset session ID because the medal progress will be wiped
//[_uid, ""] call set_session_id;



true
