/*
    Needed Mods:
    - None

    Optional Mods:
    - None
*/

// Enemy infantry classes
opfor_officer = "OPTRE_FC_Elite_FieldMarshal";                           // Officer
opfor_squad_leader = "WBK_EliteMainWeap_6";                        // Squad Leader
opfor_team_leader = "WBK_EliteMainWeap_2";                                   // Team Leader
opfor_sentry = "OPTRE_Jackal_F";                                      // Rifleman (Lite)
opfor_rifleman = "WBK_Grunt_5";                                         // Rifleman
opfor_rpg = "OPTRE_FC_Elite_MinorAT";                                   // Rifleman (LAT)
opfor_grenadier = "OPTREW_Grunt_3";                                     // Grenadier
opfor_machinegunner = "OPTRE_Jackal_Infantry_F";                                 // Autorifleman
opfor_heavygunner = "WBK_Grunt_1";                                  // Heavy Gunner
opfor_marksman = "OPTRE_Jackal_Marksman_F";                                       // Marksman
opfor_sharpshooter = "OPTRE_Jackal_Sharpshooter_F";                                // Sharpshooter
opfor_sniper = "OPTRE_Jackal_Sniper_F";                                            // Sniper
opfor_at = "WBK_HaloHunter_1";                                            // AT Specialist
opfor_aa = "OPTRE_FC_Elite_MinorAA";                                            // AA Specialist
opfor_medic = "WBK_Grunt_3";                                              // Combat Life Saver
opfor_engineer = "WBK_Grunt_3";                                        // Engineer
opfor_paratrooper = "OPTRE_Jackal_Infantry_F";                                   // Paratrooper

// Enemy vehicles used by secondary objectives.
opfor_mrap = "OPTRE_FC_Spectre_Empty";
opfor_mrap_armed = "OPTRE_FC_Spectre_AI";                                   // Ifrit (HMG)
opfor_transport_helo = "OPTRE_FC_Spirit";                   // Mi-290 Taru (Bench)
opfor_transport_truck = "OPTRE_FC_Spectre_Transport";                         // Tempest Transport (Covered)
opfor_ammobox_transport = "OPTRE_FC_Spectre_Empty";                     // Tempest Transport (Open) -> Has to be able to transport resource crates!
opfor_fuel_truck = "OPTRE_FC_Spectre_Recovery";                                 // Tempest Fuel
opfor_ammo_truck = "OPTRE_FC_Spectre_Recovery";                                 // Tempest Ammo
opfor_fuel_container = "Land_OPTRE_fusion_coil";             // Taru Fuel Pod
opfor_ammo_container = "Land_OPTRE_fusion_coil";             // Taru Ammo Pod
opfor_flag = "OPTRE_CTF_Flag_PurpleCOV";                                             // Flag

/* Adding a value to these arrays below will add them to a one out of however many in the array, random pick chance.
Therefore, adding the same value twice or three times means they are more likely to be chosen more often. */

/* Militia infantry. Lightweight soldier classnames the game will pick from randomly as sector defenders.
Think of them like garrison or military police forces, which are more meant to control the local population instead of fighting enemy armies. */
militia_squad = [
    "OPTRE_FC_Elite_Minor2",
	"OPTRE_Jackal_Infantry2_F",
	"WBK_Grunt_5",
	"WBK_Grunt_1",
	"WBK_Grunt_1",
	"OPTRE_Jackal_F",
	"OPTRE_Jackal_F",
	"WBK_Grunt_1",
	"WBK_Grunt_1",
	"WBK_Grunt_1",
	"WBK_Grunt_1",
	"WBK_Grunt_1"
];

// Militia vehicles. Lightweight vehicle classnames the game will pick from randomly as sector defenders. Can also be empty for only infantry milita.
militia_vehicles = [
    "OPTRE_FC_Ghost",
    "OPTRE_FC_Ghost",
    "OPTRE_FC_Ghost",
	"OPTRE_FC_T26_AI",
	"OPTRE_FC_T26_AT"
];

// All enemy vehicles that can spawn as sector defenders and patrols at high enemy combat readiness (aggression levels).
opfor_vehicles = [
	"OPTRE_FC_Wraith_Tank",
	"OPTRE_FC_Wraith_Tank",
	"OPTRE_FC_Wraith",
	"OPTRE_FC_Wraith",
	"OPTRE_FC_AA_Wraith_NOFLAK",
	"OPTRE_FC_Spectre_Transport",
	"OPTRE_FC_Spectre_AI",
	"OPTRE_FC_Spectre_AT",
	"OPTRE_FC_Spectre_AA"
];

// All enemy vehicles that can spawn as sector defenders and patrols but at a lower enemy combat readiness (aggression levels).
opfor_vehicles_low_intensity = [
	"OPTRE_FC_Wraith",
	"OPTRE_FC_Spectre_AI",
	"OPTRE_FC_Spectre_AI",
	"OPTRE_FC_Spectre_Empty"
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at high enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles = [
	"OPTRE_FC_Spirit",
	"OPTRE_FC_Spirit_Concussion",
	"OPTRE_FC_Type26B_Banshee",
	"OPTRE_FC_Wraith_Tank",
	"OPTRE_FC_Wraith",
	"OPTRE_FC_AA_Wraith_NOFLAK",
	"OPTRE_FC_Spectre_AI",
	"OPTRE_FC_Spectre_AT",
	"OPTRE_FC_Spectre_Transport",
    "OPTRE_FC_Ghost_Armor",
    "OPTRE_FC_Ghost_FuelRod",
	"OPTRE_FC_Spectre_AA"
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at lower enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles_low_intensity = [
	"OPTRE_FC_Spirit",
	"OPTRE_FC_Type26B_Banshee",
	"OPTRE_FC_Wraith",
	"OPTRE_FC_Spectre",
	"OPTRE_FC_Spectre_Transport",
	"OPTRE_FC_Ghost"
];

/* All vehicles that spawn within battlegroups (see the above 2 arrays) and also hold 8 soldiers as passengers.
If something in this array can't hold all 8 soldiers then buggy behaviours may occur.    */
opfor_troup_transports = [
    "OPTRE_FC_Spectre_Transport",
    "OPTRE_FC_Spirit"
];

// Enemy rotary-wings that will need to spawn in flight.
opfor_choppers = [
	"OPTRE_FC_Spirit",
	"OPTRE_FC_Type26B_Banshee"
];

// Enemy fixed-wings that will need to spawn in the air.
opfor_air = [
	"OPTRE_FC_Type26B_Banshee",
	"OPTRE_FC_Type27_Banshee",									//To-199 Neophron (CAS)
	"OPTRE_FC_Type26N_Banshee"												//To-201 Shikra
];
