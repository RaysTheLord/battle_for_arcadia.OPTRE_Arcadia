/*
    Needed Mods:
    - None

    Optional Mods:
    - None
*/

/* Classnames of the guerilla faction which is friendly or hostile, depending on the civil reputation
Unlike normal liberation, they will spawn as-is and have different unit types between tiers */

//IMPORTANT: For the time being, INDFOR does not have WBK shielding!  Try not to mix WBK units with normal units here.

//OFFICER POOLS: Each tier has a pool.  These are the leaders of each guerilla group, and they spawn in pairs.
t1_officer_pool = ["OPTRE_CPD_Officer_M392", "OPTRE_CPD_Officer_M45", "OPTRE_CPD_Officer_M7", "OPTRE_CPD_Officer_MA37K"];
t2_officer_pool = ["OPTRE_CPD_Riot_Officer"];
t3_officer_pool = ["OPTRE_CPD_SWAT_Bulldog", "OPTRE_CPD_SWAT_M392", "OPTRE_CPD_SWAT_M45", "OPTRE_CPD_SWAT_M7", "OPTRE_CPD_SWAT_MA37K", "OPTRE_CPD_SWAT_RIOTCQQS48", "OPTRE_CPD_SWAT_RIOTM7", "OPTRE_CPD_SWAT_SRS99", "OPTRE_CPD_SWAT_Tactical_Sniper", "OPTRE_CPD_SWAT_VK78"];

//GRUNT POOLS: These are the low-ranking guerilla units that spawn more numerously under the leadership of officers.
grunts_pool = ["OPTRE_CPD_Officer"];

//HUNTER POOL: Special heavy units that may spawn as part of the group.  You can set the chance they spawn as a percent (which is per-tier, meaning tier 3 will have 3 * hunter_chance to spawn)
hunter_pool = ["OPTRE_CPD_Juggernaut"];
hunter_chance = 5;


// Armed vehicles
KP_liberation_guerilla_vehicles = [
    "OPTRE_M12_FAV_APC_PD", 
    "OPTRE_M12_LRV_PD", 
    "OPTRE_M12_TD_CMA", 
    "OPTRE_M12_FAV_PD"
];
