//Remove any previous records
if (player diarySubjectExists "myMedals") then {
    player removeDiarySubject "myMedals";
};

if (player diarySubjectExists "allMedals") then {
    player removeDiarySubject "allMedals";
};

//Refresh the subject page for reconstruction
player createDiarySubject ["myMedals", "My Medals"];
player createDiarySubject ["allMedals", "All Player Medals"];


//Create the Diary record for each medal
_my_medals = [getPlayerUID player] call get_ranked_medals;

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

//Zoom through the medals
{
    _record_title = (_medal_resolutions get (_x select 0)) + " (" + str(_x select 1) + ")";
    _image_link = "res\medals\" + (_x select 0) + "\" + (_x select 0) + "_" + str(_x select 1) + ".jpg";
    _text_description = (_x select 2) joinString "<br />";
    player createDiaryRecord ["myMedals", [_record_title, "<img image='" + _image_link + "' /><br /><br />" + _text_description]];
} forEach _my_medals;

//Display for Medals for each player

for "_i" from 0 to ((count KP_liberation_playerRanks) - 1) do {
    _medal_count = 0; 
    _this_player_medals = (KP_liberation_playerRanks select _i) select 3;
    _entry_text = "";
    {
        _record_title = (_medal_resolutions get (_x select 0)) + " (" + str(_x select 1) + ")";
       _entry_text = _entry_text + ("<img image='" + "res\medals\" + (_x select 0) + "\" + (_x select 0) + "_" + str(_x select 1) + ".jpg" + "' width='70' title='" + _record_title + "' />");
       _medal_count = _medal_count + 1;
       if ((_medal_count mod 5) == 0 ) then {
            _entry_text = _entry_text + "<br />";
       };
    } forEach _this_player_medals;
    player createDiaryRecord ["allMedals", [(KP_liberation_playerRanks select _i) select 0, _entry_text]];
};