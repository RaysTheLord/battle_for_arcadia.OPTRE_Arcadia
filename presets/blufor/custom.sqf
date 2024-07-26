/*
    Needed Mods:
    - None

    Optional Mods:
    - BWMod
    - RHSUSAF
    - F-15C
    - F/A-18
    - CUP Weapons
    - CUP Vehicles
    - USAF Main Pack
    - USAF Fighters Pack
    - USAF Utility Pack
*/

/*
    --- Support classnames ---
    Each of these should be unique.
    The same classnames for different purposes may cause various unpredictable issues with player actions.
    Or not, just don't try!
*/
FOB_typename = "Land_Cargo_HQ_V1_F";                                    // This is the main FOB HQ building.
FOB_box_typename = "B_Slingload_01_Cargo_F";                            // This is the FOB as a container.
FOB_truck_typename = "OPTRE_m1087_stallion_device_unsc";                                // This is the FOB as a vehicle.
Arsenal_typename = "B_supplyCrate_F";                                   // This is the virtual arsenal as portable supply crates.
Respawn_truck_typename = "OPTRE_M12_FAV_APC_MED";                        // This is the mobile respawn (and medical) truck.
huron_typename = "OPTRE_Pelican_unarmed";                       // This is Spartan 01, a multipurpose mobile respawn as a helicopter.
crewman_classname = "OPTRE_UNSC_Marine_Soldier_Crewman";                                         // This defines the crew for vehicles.
pilot_classname = "OPTRE_UNSC_Navy_Soldier_Olive";                                      // This defines the pilot for helicopters.
KP_liberation_little_bird_classname = "OPTRE_UNSC_falcon";              // These are the little birds which spawn on the Freedom or at Chimera base.
KP_liberation_boat_classname = "optre_catfish_mg_f";                 // These are the boats which spawn at the stern of the Freedom.
KP_liberation_truck_classname = "OPTRE_m1087_stallion_unsc";               // These are the trucks which are used in the logistic convoy system.
KP_liberation_small_storage_building = "ContainmentArea_02_sand_F";     // A small storage area for resources.
KP_liberation_large_storage_building = "ContainmentArea_01_sand_F";     // A large storage area for resources.
KP_liberation_recycle_building = "Land_RepairDepot_01_tan_F";           // The building defined to unlock FOB recycling functionality.
KP_liberation_air_vehicle_building = "B_Radar_System_01_F";             // The building defined to unlock FOB air vehicle functionality.
KP_liberation_heli_slot_building = "Land_HelipadSquare_F";              // The helipad used to increase the GLOBAL rotary-wing cap.
KP_liberation_plane_slot_building = "Land_TentHangar_V1_F";             // The hangar used to increase the GLOBAL fixed-wing cap.
KP_liberation_supply_crate = "CargoNet_01_box_F";                       // This defines the supply crates, as in resources.
KP_liberation_ammo_crate = "B_CargoNet_01_ammo_F";                      // This defines the ammunition crates.
KP_liberation_fuel_crate = "CargoNet_01_barrels_F";                     // This defines the fuel crates.

/*
    --- Friendly classnames ---
    Each array below represents one of the 7 pages within the build menu.
    Format: ["vehicle_classname",supplies,ammunition,fuel],
    Example: ["B_APC_Tracked_01_AA_F",300,150,150],
    The above example is the NATO IFV-6a Cheetah, it costs 300 supplies, 150 ammunition and 150 fuel to build.
    IMPORTANT: The last element inside each array must have no comma at the end!
*/
infantry_units = [
	["OPTRE_UNSC_Marine_Soldier_Rifleman_AR",0,0,0],
	["OPTRE_UNSC_Marine_Soldier_Rifleman_AT",10,0,0],
	["OPTRE_UNSC_Marine_Soldier_Corpsman",0,0,0],
	["OPTRE_UNSC_Marine_Soldier_Autorifleman",0,0,0],
	["OPTRE_UNSC_Marine_Soldier_Grenadier",5,0,0],
	["OPTRE_UNSC_Marine_Soldier_Engineer",5,0,0],
	["OPTRE_UNSC_Marine_Soldier_Demolitions",5,0,0],
	["OPTRE_UNSC_Marine_Soldier_AT_Specialist",20,0,0],
	["OPTRE_UNSC_Marine_Soldier_AA_Specialist",20,0,0],
	["OPTRE_UNSC_Marine_Soldier_Marksman",25,0,0],
	["OPTRE_UNSC_Marine_Soldier_Sniper",75,0,0],
	["OPTRE_UNSC_Navy_Soldier_Olive",5,0,0],
	["OPTRE_UNSC_ODST_Soldier_TeamLeader",15,0,0]
];

light_vehicles = [
	["OPTRE_m1087_stallion_unsc",0,0,0],		
	["OPTRE_M813_TT",0,0,0],
	["OPTRE_M12_FAV",0,0,0],
	["OPTRE_M12_FAV_APC",0,0,0],
	["OPTRE_M12_FAV_APC_MED",0,0,0],
	["OPTRE_M12_LRV",10,0,0],
	["OPTRE_M274_ATV",10,0,0],
	["OPTRE_M12A1_LRV",10,10,0],
	["OPTRE_M12G1_LRV",10,10,0],
	["OPTRE_M12R_AA",10,25,10],
	["B_Boat_Transport_01_F",0,0,0],									//Assault Boat
	["optre_catfish_mg_f",10,0,0]							
];

heavy_vehicles = [
	["OPTRE_M412_IFV_UNSC",200,40,100],
	["OPTRE_M413_MGS_UNSC",250,50,100],
	["OPTRE_M494",210,50,100],
	["OPTRE_M808B_UNSC",300,100,100],
	["OPTRE_M808BM_UNSC",300,100,100],
	["OPTRE_M808S",300,100,100],
	["OPTRE_M808B2",300,70,100],
	["OPTRE_M850_UNSC",350,200,100],
	["OPTRE_M875_SPH",600,500,300],
	["OPTRE_M808L",600,500,300]
];

air_vehicles = [
	["OPTRE_Wombat_S",50,0,20],
	["OPTRE_Wombat_B",50,20,50],
	["OPTRE_Wombat",50,20,50],
	["OPTRE_AV22_Sparrowhawk",170,150,100],								// sparowhawk
	["OPTRE_AV22A_Sparrowhawk",170,150,100],
	["OPTRE_AV22B_Sparrowhawk",170,150,100],
	["OPTRE_AV22C_Sparrowhawk",170,150,100],
	["OPTRE_YSS_1000_A",250,350,150],
	["OPTRE_YSS_1000_A_VTOL",300,500,250],
	["OPTRE_Pelican_armed",0,30,50],
	["OPTRE_Pelican_unarmed",0,0,0],
	["OPTRE_UNSC_hornet",30,30,50],
	["OPTRE_UNSC_hornet_CAP",30,30,50],
	["OPTRE_UNSC_hornet_CAS",30,30,50],
	["OPTRE_UNSC_falcon_unarmed",0,0,0],
	["OPTRE_UNSC_falcon",0,10,15]
];

static_vehicles = [
	["OPTRE_Static_M247T_Tripod",25,20,0],	
	["OPTRE_Static_M247H_Tripod",25,30,0],												
	["OPTRE_LAU65D_pod",35,40,0],	
	["OPTRE_Static_M41",35,40,0],
	["OPTRE_Static_Gauss",35,40,0],
	["OPTRE_Static_AA",35,40,0],
	["OPTRE_Static_FG75_CMA",35,40,0],
    ["OPTRE_Lance",250,500,0],       
    ["OPTRE_Scythe",250,350,0],  	
	["B_GMG_01_F",35,60,0],												//Mk32A GMG 20mm
	["B_GMG_01_high_F",35,60,0],										//Mk32 GMG 20mm (Raised)
	["B_GMG_01_A_F",45,60,0],											//Mk32 GMG 20mm (Autonomous)
	["B_Mortar_01_F",80,150,0],											//Mk6 Mortar
    ["RHS_M119_WD",100,200,0],                                          // M119A2
    ["B_SAM_System_03_F",250,500,0]                                     // MIM-145 Defender
];

buildings = [
	["Land_OPTRE_blast_barrier",0,0,0],
	["Land_optre_milwall_segment",0,0,0],
	["Land_optre_milwall_hub",0,0,0],
	["Land_optre_milwall_corner",0,0,0],
	["Land_optre_milwall_gateXL",0,0,0],	
	["Land_optre_milwall_gate",0,0,0],
	["OPTRE_Land_ModularOutPostBuildingEmpty_Snow",0,0,0],
	["Land_OPTRE_M72_barrier",0,0,0],
	["Land_OPTRE_M72S_barrier",0,0,0],	
	["Land_OPTRE_ONI_barrier",0,0,0],
	["Land_OPTRE_medical_tent_grn",0,0,0],
	["Land_OPTRE_medical_tent_gry",0,0,0],
    ["Land_OPTRE_medical_tent_tan",0,0,0],
	["Land_OPTRE_hard_tent_des",0,0,0],
	["Land_OPTRE_hard_tent_grn",0,0,0],
    ["Land_OPTRE_hard_tent_urban",0,0,0],
	["Land_OPTRE_watchtower_woodland",0,0,0],
	["Land_OPTRE_ODST_Grave",0,0,0],
	["Land_OPTRE_Soldier_Grave",0,0,0],
	["Land_OPTRE_mil_antenna_mast",0,0,0],
    ["Land_Cargo_House_V1_F",0,0,0],
    ["Land_Cargo_Patrol_V1_F",0,0,0],
    ["Land_Cargo_Tower_V1_F",0,0,0],
    ["Land_Cargo_House_V1_F",0,0,0],
    ["Land_Cargo_Patrol_V1_F",0,0,0],
    ["Land_Cargo_Tower_V1_F",0,0,0],
    ["Flag_UNO_F",0,0,0],
    ["FlagCarrierBLUFOR_EP1",0,0,0],
    ["Land_Medevac_house_V1_F",0,0,0],
    ["Land_Medevac_HQ_V1_F",0,0,0],
    ["CamoNet_BLUFOR_F",0,0,0],
    ["CamoNet_BLUFOR_open_F",0,0,0],
    ["CamoNet_BLUFOR_big_F",0,0,0],
    ["Land_PortableLight_single_F",0,0,0],
    ["Land_PortableLight_double_F",0,0,0],
    ["Land_LampSolar_F",0,0,0],
    ["Land_LampHalogen_F",0,0,0],
    ["Land_LampStreet_small_F",0,0,0],
    ["Land_LampAirport_F",0,0,0],
    ["Land_HelipadCircle_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["Land_HelipadRescue_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["PortableHelipadLight_01_blue_F",0,0,0],
    ["PortableHelipadLight_01_green_F",0,0,0],
    ["PortableHelipadLight_01_red_F",0,0,0],
    ["Land_CampingChair_V1_F",0,0,0],
    ["Land_CampingChair_V2_F",0,0,0],
    ["Land_CampingTable_F",0,0,0],
    ["MapBoard_altis_F",0,0,0],
    ["MapBoard_stratis_F",0,0,0],
    ["MapBoard_seismic_F",0,0,0],
    ["Land_Pallet_MilBoxes_F",0,0,0],
    ["Land_PaperBox_open_empty_F",0,0,0],
    ["Land_PaperBox_open_full_F",0,0,0],
    ["Land_PaperBox_closed_F",0,0,0],
    ["Land_DieselGroundPowerUnit_01_F",0,0,0],
    ["Land_ToolTrolley_02_F",0,0,0],
    ["Land_WeldingTrolley_01_F",0,0,0],
    ["Land_Workbench_01_F",0,0,0],
    ["Land_GasTank_01_blue_F",0,0,0],
    ["Land_GasTank_01_khaki_F",0,0,0],
    ["Land_GasTank_01_yellow_F",0,0,0],
    ["Land_GasTank_02_F",0,0,0],
    ["Land_BarrelWater_F",0,0,0],
    ["Land_BarrelWater_grey_F",0,0,0],
    ["Land_WaterBarrel_F",0,0,0],
    ["Land_WaterTank_F",0,0,0],
    ["Land_BagFence_Round_F",0,0,0],
    ["Land_BagFence_Short_F",0,0,0],
    ["Land_BagFence_Long_F",0,0,0],
    ["Land_BagFence_Corner_F",0,0,0],
    ["Land_BagFence_End_F",0,0,0],
    ["Land_BagBunker_Small_F",0,0,0],
    ["Land_BagBunker_Large_F",0,0,0],
    ["Land_BagBunker_Tower_F",0,0,0],
    ["Land_HBarrier_1_F",0,0,0],
    ["Land_HBarrier_3_F",0,0,0],
    ["Land_HBarrier_5_F",0,0,0],
    ["Land_HBarrier_Big_F",0,0,0],
    ["Land_HBarrierWall4_F",0,0,0],
    ["Land_HBarrierWall6_F",0,0,0],
    ["Land_HBarrierWall_corner_F",0,0,0],
    ["Land_HBarrierWall_corridor_F",0,0,0],
    ["Land_HBarrierTower_F",0,0,0],
    ["Land_CncBarrierMedium_F",0,0,0],
    ["Land_CncBarrierMedium4_F",0,0,0],
    ["Land_Concrete_SmallWall_4m_F",0,0,0],
    ["Land_Concrete_SmallWall_8m_F",0,0,0],
    ["Land_CncShelter_F",0,0,0],
    ["Land_CncWall1_F",0,0,0],
    ["Land_CncWall4_F",0,0,0],
    ["Land_Sign_WarningMilitaryArea_F",0,0,0],
    ["Land_Sign_WarningMilAreaSmall_F",0,0,0],
    ["Land_Sign_WarningMilitaryVehicles_F",0,0,0],
    ["Land_Razorwire_F",0,0,0],
    ["Land_ClutterCutter_large_F",0,0,0]
];

support_vehicles = [
	["OPTRE_M914_RV",30,25,25],
	["OPTRE_m1087_stallion_unsc_resupply",0,0,0],
	["OPTRE_m1087_stallion_unsc_refuel",0,0,0],
	["OPTRE_m1087_stallion_unsc_repair",0,0,0],
	["OPTRE_m1087_stallion_unsc_medical",0,0,0],
	["OPTRE_M313_UNSC",250,0,150],
    [Arsenal_typename,100,200,0],
    [Respawn_truck_typename,10,0,0],
    [FOB_box_typename,300,500,0],
    [FOB_truck_typename,300,500,75],
    [KP_liberation_small_storage_building,0,0,0],
    [KP_liberation_large_storage_building,0,0,0],
    [KP_liberation_recycle_building,250,0,0],
    [KP_liberation_air_vehicle_building,1000,0,0],
    [KP_liberation_heli_slot_building,250,0,0],
    [KP_liberation_plane_slot_building,500,0,0],
    ["ACE_medicalSupplyCrate_advanced",50,0,0],
    ["ACE_Box_82mm_Mo_HE",50,40,0],
    ["ACE_Box_82mm_Mo_Smoke",50,10,0],
    ["ACE_Box_82mm_Mo_Illum",50,10,0],
    ["ACE_Wheel",10,0,0],
    ["ACE_Track",10,0,0],
    ["USAF_missileCart_W_AGM114",50,150,0],                             // Missile Cart (AGM-114)
    ["USAF_missileCart_AGMMix",50,150,0],                               // Missile Cart (AGM-65 Mix)
    ["USAF_missileCart_AGM1",50,150,0],                                 // Missile Cart (AGM-65D)
    ["USAF_missileCart_AGM2",50,150,0],                                 // Missile Cart (AGM-65E)
    ["USAF_missileCart_AGM3",50,150,0],                                 // Missile Cart (AGM-65K)
    ["USAF_missileCart_AA1",50,150,0],                                  // Missile Cart (AIM-9M/AIM-120)
    ["USAF_missileCart_AA2",50,150,0],                                  // Missile Cart (AIM-9X/AIM-120)
    ["USAF_missileCart_GBU12_green",50,150,0],                          // Missile Cart (GBU12 Green)
    ["USAF_missileCart_GBU12_maritime",50,150,0],                       // Missile Cart (GBU12 Maritime)
    ["USAF_missileCart_GBU12",50,150,0],                                // Missile Cart (GBU12)
    ["USAF_missileCart_Gbu31",50,150,0],                                // Missile Cart (GBU31)
    ["USAF_missileCart_GBU39",50,150,0],                                // Missile Cart (GBU39)
    ["USAF_missileCart_Mk82",50,150,0],                                 // Missile Cart (Mk82)
    ["CUP_B_TowingTractor_NATO",50,0,25],                               // Towing Tractor
    ["B_APC_Tracked_01_CRV_F",500,250,350],                             // CRV-6e Bobcat
    ["B_Truck_01_Repair_F",325,0,75],                                   // HEMTT Repair
    ["B_Truck_01_fuel_F",125,0,275],                                    // HEMTT Fuel
    ["B_Truck_01_ammo_F",125,200,75],                                   // HEMTT Ammo
    ["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",325,0,75],                   // M977A4 Repair
    ["rhsusf_M978A4_BKIT_usarmy_wd",125,0,275],                         // M978A4 Fuel
    ["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",125,200,75],                   // M977A4 Ammo
    ["B_Slingload_01_Repair_F",275,0,0],                                // Huron Repair
    ["B_Slingload_01_Fuel_F",75,0,200],                                 // Huron Fuel
    ["B_Slingload_01_Ammo_F",75,200,0]                                  // Huron Ammo
];

/*
    --- Squads ---
    Pre-made squads for the commander build menu.
    These shouldn't exceed 10 members.
*/

// Light infantry squad.
blufor_squad_inf_light = [
	"OPTRE_UNSC_Marine_Soldier_TeamLead",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AT",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Corpsman",
	"OPTRE_UNSC_Marine_Soldier_Engineer"
];

// Heavy infantry squad.
blufor_squad_inf = [
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_AutoRifleman",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Corpsman",
	"OPTRE_UNSC_Marine_Soldier_Engineer"
];

// AT specialists squad.
blufor_squad_at = [
	"OPTRE_UNSC_Marine_Soldier_TeamLead",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Corpsman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light"
];

// AA specialists squad.
blufor_squad_aa = [
	"OPTRE_UNSC_Marine_Soldier_TeamLead",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Corpsman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light"
];

// Force recon squad.
blufor_squad_recon = [
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_Light",
	"OPTRE_UNSC_Marine_Soldier_Sniper",
	"OPTRE_UNSC_Marine_Soldier_Sniper",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Corpsman",
	"OPTRE_UNSC_Marine_Soldier_Demolitions"
];

// Paratroopers squad (For this mission, really just ODSTs)
blufor_squad_para = [
	"OPTRE_UNSC_ODST_Soldier_Scout",
	"OPTRE_UNSC_ODST_Soldier_Scout",
	"OPTRE_UNSC_ODST_Soldier_Scout",
	"OPTRE_UNSC_ODST_Soldier_Scout_AT",
	"OPTRE_UNSC_ODST_Soldier_Marksman",
	"OPTRE_UNSC_ODST_Soldier_Scout_Sniper",
	"OPTRE_UNSC_ODST_Soldier_Scout_Sniper",
	"OPTRE_UNSC_ODST_Soldier_Paramedic",
	"OPTRE_UNSC_ODST_Soldier_DemolitionsExpert"
];

/*
    --- Elite vehicles ---
    Classnames below have to be unlocked by capturing military bases.
    Which base locks a vehicle is randomized on the first start of the campaign.
*/
elite_vehicles = [
	"OPTRE_YSS_1000_A",									//A-164 Wipeout (CAS)
	"OPTRE_YSS_1000_A_VTOL",												//F/A-181 Black Wasp II
	"OPTRE_M808L",
	"OPTRE_M850_UNSC"
];
