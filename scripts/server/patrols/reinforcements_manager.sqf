params ["_targetsector"];

if (combat_readiness > 15) then {

    private _init_units_count = (([markerPos _targetsector, GRLIB_capture_size, GRLIB_side_enemy] call KPLIB_fnc_getUnitsCount));

    if !(_targetsector in sectors_bigtown) then {
        while {(_init_units_count * 0.75) <= ([markerPos _targetsector, GRLIB_capture_size, GRLIB_side_enemy] call KPLIB_fnc_getUnitsCount)} do {
            sleep 5;
        };
    };

    if (_targetsector in active_sectors) then {

        private _nearestower = [markerpos _targetsector, GRLIB_side_enemy, GRLIB_radiotower_size * 1.4] call KPLIB_fnc_getNearestTower;

        if !(isNil "_nearestower") then {
            private _reinforcements_time = (((((markerpos _nearestower) distance (markerpos _targetsector)) / 1000) ^ 1.66 ) * 120) / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity);
            if (_targetsector in sectors_bigtown) then {
                _reinforcements_time = _reinforcements_time * 0.35;
            };
            private _current_timer = time;

            waitUntil {sleep 1; (_current_timer + _reinforcements_time < time) || (_targetsector in blufor_sectors) || (_nearestower in blufor_sectors)};

            sleep 15;

            if ((_targetsector in active_sectors) && !(_targetsector in blufor_sectors) && !(_nearestower in blufor_sectors) && (!([] call KPLIB_fnc_isBigtownActive) || _targetsector in sectors_bigtown)) then {
                reinforcements_sector_under_attack = _targetsector;
                reinforcements_set = true;
                ["lib_reinforcements",[markertext _targetsector]] remoteExec ["bis_fnc_shownotification"];
                [_targetsector] spawn send_paratroopers;
                
                //COVENANT ASSAULT
                _punished = false;
                
                _position = markerPos _targetsector;
                _directions = [0, 45, 90, 135, 180, 225, 270, 315];
                _scarab_chance = 15;
                if (!_punished && combat_readiness >= 95) then {
                    _punished = true;
                    //Glass the area
                    [_position, selectRandom _directions, 2000, 1000, true] call PHAN_ScifiSupportPlus_fnc_COV_GlassingStrike;
                };
                if (!_punished && (combat_readiness > (40 + (30 / GRLIB_csat_aggressivity)))) then {
                    _punished = true;
                    //Armed covenant cruiser or Scarab
                    if(isClass (configfile >> "CfgPatches" >> "Mechanized_Scarab") && ((random 100) <= _scarab_chance)) then {
                        [_position, selectRandom _directions, selectRandom ["NJP_Scarab_Hull_Base", "NJP_Scarab_Hull_AT", "NJP_Scarab_Hull_AA", "NJP_Scarab_Hull_Cmdr", "NJP_Scarab_Hull_Cmdr_AA"]] call PHAN_ScifiSupportPlus_fnc_COV_ScarabDrop;
                    } else {
                        [_position, selectRandom _directions, 750, "COV_CCS", 1] call PHAN_ScifiSupportPlus_fnc_COV_ArmedCruiser;
                    };
                    
                    
                };
                if (!_punished && (combat_readiness > (20 + (30 / GRLIB_csat_aggressivity)))) then {
                    _punished = true;
                    //SDV Bombardment
                    [_position, selectRandom _directions, 1000, true] call PHAN_ScifiSupportPlus_fnc_COV_SDV_Bombardment;
                };
                if (!_punished && (combat_readiness > (0 + (30 / GRLIB_csat_aggressivity)))) then {
                    _punished = true;
                    //Mortar strikes
                    [_position, 1000, 50] call PHAN_ScifiSupportPlus_fnc_COV_PlasmaMortar;
                };

                stats_reinforcements_called = stats_reinforcements_called + 1;
            };
        };
    };
};
