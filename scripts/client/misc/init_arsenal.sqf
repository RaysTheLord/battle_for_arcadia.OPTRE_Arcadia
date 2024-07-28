if (KP_liberation_arsenalUsePreset) then {
    private _crawled = [] call KPLIB_fnc_crawlAllItems;
    private _weapons = [];
    private _magazines = [];
    private _items = [];
    private _backpacks = [];
    KP_liberation_allowed_items = [];

    if (isNil "GRLIB_arsenal_weapons") then {GRLIB_arsenal_weapons = []};
    if (isNil "GRLIB_arsenal_magazines") then {GRLIB_arsenal_magazines = []};
    if (isNil "GRLIB_arsenal_items") then {GRLIB_arsenal_items = []};
    if (isNil "GRLIB_arsenal_backpacks") then {GRLIB_arsenal_backpacks = []};
    if (isNil "blacklisted_from_arsenal") then {blacklisted_from_arsenal = []};
    
    //Set new variables to track without overriding the defaults
    _used_arsenal_weapons = +GRLIB_arsenal_weapons;
    _used_arsenal_magazines = +GRLIB_arsenal_magazines;
    _used_arsenal_items = +GRLIB_arsenal_items;
    _used_arsenal_backpacks = +GRLIB_arsenal_backpacks;
    
    //Add arsenal from defaults
    _correct_arsenal = [];

    if !(isNil "default_arsenal_1") then {
      //Get the correct arsenal first
      if (["ODST", typeOf player] call BIS_fnc_inString) then {
        switch ((rankId player) + 1) do {
            case 1: { _correct_arsenal = odst_arsenal_1; };
            case 2: { _correct_arsenal = odst_arsenal_2; };
            case 3: { _correct_arsenal = odst_arsenal_3; };
            case 4: { _correct_arsenal = odst_arsenal_4; };
            case 5: { _correct_arsenal = odst_arsenal_5; };
            case 6: { _correct_arsenal = odst_arsenal_6; };
            case 7: { _correct_arsenal = odst_arsenal_7; };
            default { systemChat "Invalid rank info!" };
        };
      };
      if (["Spartan", typeOf player] call BIS_fnc_inString) then {
        switch ((rankId player) + 1) do {
            case 1: { _correct_arsenal = spartan_arsenal_1; };
            case 2: { _correct_arsenal = spartan_arsenal_2; };
            case 3: { _correct_arsenal = spartan_arsenal_3; };
            case 4: { _correct_arsenal = spartan_arsenal_4; };
            case 5: { _correct_arsenal = spartan_arsenal_5; };
            case 6: { _correct_arsenal = spartan_arsenal_6; };
            case 7: { _correct_arsenal = spartan_arsenal_7; };
            default { systemChat "Invalid rank info!" };
        };
      };
      if !(["Spartan", typeOf player] call BIS_fnc_inString || ["ODST", typeOf player] call BIS_fnc_inString) then {
        switch ((rankId player) + 1) do {
            case 1: { _correct_arsenal = default_arsenal_1; };
            case 2: { _correct_arsenal = default_arsenal_2; };
            case 3: { _correct_arsenal = default_arsenal_3; };
            case 4: { _correct_arsenal = default_arsenal_4; };
            case 5: { _correct_arsenal = default_arsenal_5; };
            case 6: { _correct_arsenal = default_arsenal_6; };
            case 7: { _correct_arsenal = default_arsenal_7; };
            default { systemChat "Invalid rank info!" };
        };
      };
    };
    //Add items from each default arsenal intelligently
    {
        /*
        if ( isClass (configFile >> "CfgWeapons" >> _x)) then {
           //is weapon
           _used_arsenal_weapons pushBackUnique _x;
           continue;
        };
        if ( isClass (configFile >> "CfgMagazines" >> _x)) then {
           //is weapon
           _used_arsenal_magazines pushBackUnique _x;
           continue;
        };
        //Imperfect solution, but should handle most things, and if it's in the ace arsenal we should be ok anyway
        if (["bag", _x] call BIS_fnc_inString || ["pack", _x] call BIS_fnc_inString || ["sack", _x] call BIS_fnc_inString) then {
            //Is a backpack (probably)
            _used_arsenal_backpacks pushBackUnique _x;
            continue;
        };
        //None of those?  Then it's an item
        _used_arsenal_items pushBackUnique _x;
        */
        //Screw smart adding, add everything!
        _used_arsenal_weapons pushBackUnique _x;
        _used_arsenal_magazines pushBackUnique _x;
        _used_arsenal_backpacks pushBackUnique _x;
        _used_arsenal_items pushBackUnique _x;
        
    } forEach _correct_arsenal;

    if ((count _used_arsenal_weapons) == 0) then {
        if ((count blacklisted_from_arsenal) == 0) then {
            _weapons = _crawled select 0;
        } else {
            {if (!(_x in blacklisted_from_arsenal)) then {_weapons pushBack _x};} forEach (_crawled select 0);
        };
        [missionNamespace, _weapons] call BIS_fnc_addVirtualWeaponCargo;
        KP_liberation_allowed_items append _weapons;
    } else {
        [missionNamespace, _used_arsenal_weapons] call BIS_fnc_addVirtualWeaponCargo;
        KP_liberation_allowed_items append _used_arsenal_weapons;
    };

    // Support for CBA disposable launchers, https://github.com/CBATeam/CBA_A3/wiki/Disposable-Launchers
    if !(configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) then {
        private _disposableLaunchers = ["CBA_FakeLauncherMagazine"];
        {
            private _loadedLauncher = cba_disposable_LoadedLaunchers getVariable _x;
            if (!isNil "_loadedLauncher") then {
                _disposableLaunchers pushBack _loadedLauncher;
            };

            private _normalLauncher = cba_disposable_NormalLaunchers getVariable _x;
            if (!isNil "_normalLauncher") then {
                _normalLauncher params ["_loadedLauncher"];
                _disposableLaunchers pushBack _loadedLauncher;
            };
        } forEach KP_liberation_allowed_items;
        KP_liberation_allowed_items append _disposableLaunchers;
    };

    if ((count _used_arsenal_magazines) == 0) then {
        if ((count blacklisted_from_arsenal) == 0) then {
            _magazines = _crawled select 1;
        } else {
            {if (!(_x in blacklisted_from_arsenal)) then {_magazines pushBack _x};} forEach (_crawled select 1);
        };
        [missionNamespace, _magazines] call BIS_fnc_addVirtualMagazineCargo;
        KP_liberation_allowed_items append _magazines;
    } else {
        [missionNamespace, _used_arsenal_magazines] call BIS_fnc_addVirtualMagazineCargo;
        KP_liberation_allowed_items append _used_arsenal_magazines;
    };

    if ((count _used_arsenal_items) == 0) then {
        if ((count blacklisted_from_arsenal) == 0) then {
            _items = _crawled select 2;
        } else {
            {if (!(_x in blacklisted_from_arsenal)) then {_items pushBack _x};} forEach (_crawled select 2);
        };
        [missionNamespace, _items] call BIS_fnc_addVirtualItemCargo;
        KP_liberation_allowed_items append _items;
    } else {
        [missionNamespace, _used_arsenal_items] call BIS_fnc_addVirtualItemCargo;
        KP_liberation_allowed_items append _used_arsenal_items;
    };

    if ((count _used_arsenal_backpacks) == 0) then {
        if ((count blacklisted_from_arsenal) == 0) then {
            _backpacks = _crawled select 3;
        } else {
            {if (!(_x in blacklisted_from_arsenal)) then {_backpacks pushBack _x};} forEach (_crawled select 3);
        };
        [missionNamespace, _backpacks] call BIS_fnc_addVirtualBackpackCargo;
        KP_liberation_allowed_items append _backpacks;
    } else {
        [missionNamespace, _used_arsenal_backpacks] call BIS_fnc_addVirtualBackpackCargo;
        KP_liberation_allowed_items append _used_arsenal_backpacks;
    };

    {
        if ((_x find "rhs_acc") == 0) then {
            KP_liberation_allowed_items_extension append [_x + "_3d", _x + "_pip"];
        };
        if ((_x find "rhsusf_acc") == 0) then {
            KP_liberation_allowed_items_extension append [_x + "_3d", _x + "_pip"];
        };
    } forEach KP_liberation_allowed_items;

    if ((count KP_liberation_allowed_items_extension) > 0) then {
        KP_liberation_allowed_items append KP_liberation_allowed_items_extension;
    };

    if (KP_liberation_ace && KP_liberation_arsenal_type) then {
        [player, KP_liberation_allowed_items, false] call ace_arsenal_fnc_addVirtualItems;
    };

    // Lowercase all classnames
    KP_liberation_allowed_items = KP_liberation_allowed_items apply {toLower _x};
} else {
    [missionNamespace, true] call BIS_fnc_addVirtualWeaponCargo;
    [missionNamespace, true] call BIS_fnc_addVirtualMagazineCargo;
    [missionNamespace, true] call BIS_fnc_addVirtualItemCargo;
    [missionNamespace, true] call BIS_fnc_addVirtualBackpackCargo;

    if (KP_liberation_ace && KP_liberation_arsenal_type) then {
        [player, true, false] call ace_arsenal_fnc_addVirtualItems;
    };
};
