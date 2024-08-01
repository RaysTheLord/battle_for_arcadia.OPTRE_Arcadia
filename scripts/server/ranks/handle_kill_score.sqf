/*
    Description:
    Handles score additions for a player kill, called in kill_manager.

    Parameter(s):
        0: OBJECT - Killed unit
        1: OBJECT - Killer

    Returns:
    BOOL
*/

if (!isServer) exitWith {};


waitUntil{!isNil "KP_liberation_playerRanks"};

params ["_killed", "_killer"];

//Get player's index
private _index = [getPlayerUID _killer] call get_player_index;

if (_index == -1) exitWith {false};


//Modifiers for scoring
_airkill = false;
_in_vehicle_modifier = 1;
if ((toLower (typeOf (vehicle _killer))) in KPLIB_allAirVeh_classes) then {
    _airkill = true;
};

if ((toLower (typeOf (vehicle _killer))) in KPLIB_allLandVeh_classes) then  {
    _in_vehicle_modifier = 0.25; //Get a quarter of the xp you would for infantry kills 
};

//Distance scoring
_distance_modifier = 1;
if ((vehicle _killer isEqualTo _killer) && (_killer distance _killed) > 500) then {
    _distance_modifier = _distance_modifier + ((_killer distance _killed)/1000);
};

_base_score = 50;


_score_multiplier = 1;
if !(_killed isKindOf "Man") then {
    if ((toLower (typeOf (vehicle _killed))) in KPLIB_allLandVeh_classes) then {
        _score_multiplier = 1.5;
    };
    if ((toLower (typeOf (vehicle _killed))) in KPLIB_allAirVeh_classes) then {
        _score_multiplier = 2;
    };
};
//special unit logic
if (["Elite", typeOf _killed] call BIS_fnc_inString || ["Brute", typeOf _killed] call BIS_fnc_inString) then {
    _score_multiplier = 1.5;
};
//Hunter logic
if (["Hunter", typeOf _killed] call BIS_fnc_inString) then {
    _score_multiplier = 5;
};


//Final modifier to subtract if not an enemy
_side_modifier = 1;

if (side (group _killed) != GRLIB_side_enemy) then {
    _side_modifier = -1;
};
//Calculate winnings
_final_score = _base_score * _score_multiplier * _in_vehicle_modifier * _side_modifier * _distance_modifier;

//Melee kill logic that overrides above
_melee_weapons = ["Casey_Gravity_Hammer_1","Casey_Energy_Sword_2","Casey_Energy_Sword_1","WBK_BrassKnuckles","WBK_axe","Pipe_aluminium","Bat_Clear","Bat_Spike","WBK_brush_axe","WBK_craftedAxe","Crowbar","CrudeAxe","FireAxe","WBK_survival_weapon_2","WBK_survival_weapon_1","IceAxe","WBK_Katana","Weap_melee_knife","Knife_kukri","Knife_m3","Police_Bat","WBK_pipeStyledSword","Rod","Shovel_Russian","Sashka_Russian","Shovel_Russian_Rotated","Axe","WBK_SmallHammer","WBK_ww1_Club","UNSC_Knife","UNSC_Knife_reversed","WBK_survival_weapon_4","WBK_survival_weapon_4_r","WBK_survival_weapon_3_r","WBK_survival_weapon_3"];

if (currentWeapon _killer in _melee_weapons) then {
    private _curDate = date;
    _curMonth = "";

    switch (_curDate select 1) do {
        case 1: { _curMonth = "Jan"; };
        case 2: { _curMonth = "Feb"; };
        case 3: { _curMonth = "Mar"; };
        case 4: { _curMonth = "Apr"; };
        case 5: { _curMonth = "May"; };
        case 6: { _curMonth = "Jun"; };
        case 7: { _curMonth = "Jul"; };
        case 8: { _curMonth = "Aug"; };
        case 9: { _curMonth = "Sep"; };
        case 10: { _curMonth = "Oct"; };
        case 11: { _curMonth = "Nov"; };
        case 12: { _curMonth = "Dec"; };
        default { _curMonth = "???"; };
    };

    private _dateString = format ["%3 %2 %1",
        _curDate select 0,
        _curMonth,
        (if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)
    ];

    _medal_loc = [getPos (_uid call BIS_fnc_getUnitByUID)] call KPLIB_fnc_getLocationName;
    if (_medal_loc isEqualTo "") then {
        _medal_loc = "an unmarked location";
    };
    
    if (["Elite", typeOf _killed] call BIS_fnc_inString || ["Brute", typeOf _killed] call BIS_fnc_inString) then {
        //Immediate Bronze Star
        _medal_str = format ["(%1) For heroic initiative in eliminating a fearsome enemy in single combat at %2.", _dateString, _medal_loc];
        [getPlayerUID _killer, ["bs", _medal_str]] call add_ranked_medal;
        
    };
    if (["Hunter", typeOf _killed] call BIS_fnc_inString) then {
        //Immediate Silver Star
        _medal_str = format ["(%1) For gallantry in combat in eliminating a Hunter in single combat at %2.", _dateString, _medal_loc];
        [getPlayerUID _killer, ["ss", _medal_str]] call add_ranked_medal;
    };
};


//Add to the score
if !(_airkill) then {
    //Add to normal score
    [getPlayerUID _killer, _final_score] call add_ranked_score;
} else {
    //Add 25% to the normal score and the full amount to airscore
    [getPlayerUID _killer, _final_score * 0.25] call add_ranked_score;
    [getPlayerUID _killer, _final_score] call add_ranked_airscore;
};


true
