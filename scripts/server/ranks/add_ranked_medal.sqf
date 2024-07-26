/*
    Description:
    Adds a medal to existing player.
    
    Parameter(s):
        0: STRING - Steam UID of the player
        1: ARRAY - Medal information, in the form of [Medal ID, Description String]

    Returns:
    BOOL
*/

//NOTE: Medals stored in the form
//[Medal ID, Medal Level, Description Array, Session ID]

//Medals in the "kill enemies" medal tree
private _kill_medal_precedence = ["nam", "ncm", "bs", "ss", "nc", "loh"];
//Medals in the "air kills" medal tree
private _air_medal_precedence = ["am", "dfc"];
//Medals that are individual and have no ranking counterpart
private _no_precedence_medals = ["ph", "ndsm", "lom", "cc"];

params ["_uid", "_medalinfo"];

private _index = [_uid] call get_player_index;

//Return -1 if not found
if (_index == -1) exitWith {false};

//First, find the index of precedence
private _current_medals = [_uid] call get_ranked_medals;
_precedence = -1;

_indices_to_delete = []; //Medal indices that we will delete if necessary
_rank_up = -1; //whether or not we will be ranking up an existing medal
_abort_session = false; //Whether or not we will abort after the cleanup process

if ((_medalinfo select 0) in _kill_medal_precedence) then {
    _precedence = _kill_medal_precedence findIf {_x == (_medalinfo select 0)};
    {
        _prev_medal_id = _x select 0;
        _prev_medal_session = _x select 3;
        _prev_medal_isCurrent = (_prev_medal_session isEqualTo ([_uid] call get_session_id));
        if (_prev_medal_id in _kill_medal_precedence) then {
            _prev_medal_prec = _kill_medal_precedence findIf {_x == _prev_medal_id};
            
            
            //If lower ranked medal from CURRENT SESSION, slot for deletion
            if((_prev_medal_prec < _precedence) && _prev_medal_isCurrent) then {
                _indices_to_delete pushBackUnique _prev_medal_id;
            };
            
            //If same ranked medal or higher ranked medal from current session, set the abort flag
            if(((_prev_medal_prec == _precedence) || (_prev_medal_prec > _precedence)) && _prev_medal_isCurrent) then {
                _abort_session = true;
            };
            
            //If we have a same rank medal from a different session, rank up that medal instead of deleting it
            if((_prev_medal_prec == _precedence)  && !_prev_medal_isCurrent) then {
                _rank_up = _forEachIndex;
            };
        };
        
    } forEach _current_medals;
};

//Do the same for air medals
if ((_medalinfo select 0) in _air_medal_precedence) then {
    _precedence = _air_medal_precedence findIf {_x == (_medalinfo select 0)};
    {
        _prev_medal_id = _x select 0;
        _prev_medal_session = _x select 3;
        _prev_medal_isCurrent = (_prev_medal_session isEqualTo ([_uid] call get_session_id));
        if (_prev_medal_id in _air_medal_precedence) then {
            _prev_medal_prec = _air_medal_precedence findIf {_x == _prev_medal_id};
            
            
            //If lower ranked medal from CURRENT SESSION, slot for deletion
            if((_prev_medal_prec < _precedence) && _prev_medal_isCurrent) then {
                _indices_to_delete pushBackUnique _prev_medal_id;
            };
            
            //If same ranked medal or higher ranked medal from current session, set the abort flag
            if(((_prev_medal_prec == _precedence) || (_prev_medal_prec > _precedence)) && _prev_medal_isCurrent) then {
                _abort_session = true;
            };
            
            //If we have a same rank medal from a different session, rank up that medal instead of deleting it
            if((_prev_medal_prec == _precedence)  && !_prev_medal_isCurrent) then {
                _rank_up = _forEachIndex;
            };
        };
        
    } forEach _current_medals;
};

//If it's a no precedence medal, then just check if we rank up or not
if ((_medalinfo select 0) in _no_precedence_medals) then {
    {
        _prev_medal_id = _x select 0;
        _prev_medal_session = _x select 3;
        _prev_medal_isCurrent = (_prev_medal_session isEqualTo ([_uid] call get_session_id));
        if (_prev_medal_id isEqualTo (_medalinfo select 0)) then {
            
            //If same medal from current session, set the abort flag
            if(_prev_medal_isCurrent) then {
                _abort_session = true;
            } else {
                //Same medal, different session, rank up
                _rank_up = _forEachIndex;
            };            
        };   
    } forEach _current_medals;
};

//First, delete the indexed medals
//systemChat "DELETING INDICES";
//systemChat (str _indices_to_delete);
{ [_uid, _x] call remove_ranked_medal} forEach _indices_to_delete;

//Check for abort flag
if (_abort_session) exitWith {true};


//Refresh current medals selection
_current_medals = [_uid] call get_ranked_medals;

//Send the chat message
_medal_resolutions = createHashMapFromArray [
    ["nam", "Navy Achievement Medal"], 
    ["ncm", "Navy Commendation Medal"], 
    ["am", "Air Medal"], 
    ["dfc", "Distinguished Flying Cross"],
    ["ph", "Purple Heart"],
    ["ndsm", "Navy Distinguished Service Medal"],
    ["lom", "Legion of Merit"],
    ["bs", "Bronze Star"],
    ["ss", "Silver Star"],
    ["nc", "Navy Cross"],
    ["loh", "Legion of Honor"],
    ["cc", "Colonial Cross"]
];

[name (_uid call BIS_fnc_getUnitByUID) + " has been awarded the " + (_medal_resolutions get (_medalinfo select 0))] remoteExec ["systemChat", 0];


//Handle logic for ranking up or adding medal
if (_rank_up > -1) then {
    _rank_up_medal = _current_medals select _rank_up;
    //Increase the rank by 1
    if ((_current_medals select _rank_up select 1) < 26) then {
        (_current_medals select _rank_up) set [1, (_current_medals select _rank_up select 1) + 1];
    };
    //Add the description to the array
    (_current_medals select _rank_up select 2) pushBack (_medalinfo select 1);
    
    //Set the session ID
    (_current_medals select _rank_up) set [3, [_uid] call get_session_id];
} else {
    //Push the medal back
    _new_medal = [_medalinfo select 0, 1, [_medalinfo select 1], [_uid] call get_session_id];
    _current_medals pushBack _new_medal;
};

[_uid, +_current_medals] call set_ranked_medals
