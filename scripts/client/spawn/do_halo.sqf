private [ "_dialog", "_backpack", "_backpackcontents" ];

if ( isNil "GRLIB_last_halo_jump" ) then { GRLIB_last_halo_jump = -6000; };

if ( GRLIB_halo_param > 1 && ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) >= time ) exitWith {
    hint format [ localize "STR_HALO_DENIED_COOLDOWN", ceil ( ( ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) - time ) / 60 ) ];
};

_dialog = createDialog "liberation_halo";
dojump = 0;
halo_position = getpos player;

_backpackcontents = [];

[ "halo_map_event", "onMapSingleClick", { halo_position = _pos } ] call BIS_fnc_addStackedEventHandler;

"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM");

waitUntil { dialog };
while { dialog && alive player && dojump == 0 } do {
    "spawn_marker" setMarkerPosLocal halo_position;

    sleep 0.1;
};

if ( dialog ) then {
    closeDialog 0;
    sleep 0.1;
};

"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";

[ "halo_map_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

if ( dojump > 0 ) then {
    GRLIB_last_halo_jump = time;
    halo_position = halo_position getPos [random 250, random 360];
    halo_position = [ halo_position select 0, halo_position select 1, GRLIB_halo_altitude + (random 200) ];
    halojumping = true;
    sleep 0.1;
    cutRsc ["fasttravel", "PLAIN", 1];
    playSound "parasound";
    sleep 2;
    
    _HEV = createVehicle ["OPTRE_HEV", halo_position, [], 0, "FLY"];
    [player, _HEV] remoteExec ["moveInGunner", 0, false]; 
    [_HEV, "LOCKED"] remoteExec ["setVehicleLock", _HEV];
    _HEV setVariable ["HEV_hasPilot", true, true];
    
    [_HEV, halo_position, false] remoteExec ["tts_fnc_HEV_launchHevPos", 2, false];
    
    sleep 4;
    halojumping = false;
};
