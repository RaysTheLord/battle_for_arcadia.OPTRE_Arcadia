/*
    Needed Mods:
    - None

    Optional Mods:
    - None
*/

/* Classnames of the guerilla faction which is friendly or hostile, depending on the civil reputation
Standard loadout of the units will be replaced with a scripted one, which depends on the guerilla strength, after spawn */
//NOTE: Guerilla Units and loadouts are overridden by spawnGuerillaGroup.sqf 
KP_liberation_guerilla_units = [
    "OPTRE_CPD_Officer", 
    "OPTRE_CPD_Officer_M392", 
    "OPTRE_CPD_Officer_M45", 
    "OPTRE_CPD_Officer_M7", 
    "OPTRE_CPD_Officer_MA37K"
];

// Armed vehicles
KP_liberation_guerilla_vehicles = [
    "OPTRE_M12_FAV_APC_PD", 
    "OPTRE_M12_LRV_PD", 
    "OPTRE_M12_TD_CMA", 
    "OPTRE_M12_FAV_PD"
];

//BELOW IS IGNORED, but keeping for legacy purposes
/* Guerilla Equipment
There are 3 tiers for every category. If the strength of the guerillas will increase, they'll have higher tier equipment. */

/* Weapons - You've to add the weapons as array like
["Weaponclassname","Magazineclassname","magazine amount","optic","tripod"]
You can leave optic and tripod empty with "" */
KP_liberation_guerilla_weapons_1 = [
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5A","OPTRE_60Rnd_762x51_Mag",4,"",""]
];

KP_liberation_guerilla_weapons_2 = [
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5A","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_M392_DMR","OPTRE_60Rnd_762x51_Mag",4,"OPTRE_M392_Scope",""],
    ["OPTRE_M73","OPTRE_100Rnd_95x40_Box_Tracer_Yellow",4,"",""],
    ["OPTRE_M41_SSR_G","OPTRE_M41_Twin_HEAT_G",2,"",""]
];

KP_liberation_guerilla_weapons_3 = [
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5AGL","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_MA5A","OPTRE_60Rnd_762x51_Mag",4,"",""],
    ["OPTRE_M392_DMR","OPTRE_60Rnd_762x51_Mag",4,"OPTRE_M392_Scope",""],
    ["OPTRE_M73","OPTRE_100Rnd_95x40_Box_Tracer_Yellow",4,"",""],
    ["OPTRE_M41_SSR_G","OPTRE_M41_Twin_HEAT_G",2,"",""],	
    ["OPTRE_SRS99D","OPTRE_4Rnd_145x114_APFSDS_Mag",5,"OPTRE_SRS99_Scope",""],
    ["OPTRE_BR55HB","OPTRE_36Rnd_95x40_Mag_Tracer_Yellow",5,"OPTRE_BR55HB_Scope",""],	
    ["OPTRE_BR55HB","OPTRE_36Rnd_95x40_Mag_Tracer_Yellow",5,"OPTRE_BR55HB_Scope",""],	
    ["OPTRE_BR55HB","OPTRE_36Rnd_95x40_Mag_Tracer_Yellow",5,"OPTRE_BR55HB_Scope",""]
];

// Uniforms
KP_liberation_guerilla_uniforms_1 = [
    "U_O_R_Gorka_01_F",
	"OPTRE_Ins_ER_uniform_GAtan",
	"U_C_CBRN_Suit_01_Blue_F",
	"U_BG_Guerrilla_6_1",
	"U_O_R_Gorka_01_black_F",
	"OPTRE_Ins_ER_uniform_GAtan"
];

KP_liberation_guerilla_uniforms_2 = [
    "U_O_R_Gorka_01_F",
	"OPTRE_Ins_ER_uniform_GAtan",
	"U_C_CBRN_Suit_01_Blue_F",
	"U_BG_Guerrilla_6_1",
	"U_O_R_Gorka_01_black_F",
	"OPTRE_Ins_ER_uniform_GAtan"
];

KP_liberation_guerilla_uniforms_3 = [
    "U_O_R_Gorka_01_F",
	"OPTRE_Ins_ER_uniform_GAtan",
	"U_C_CBRN_Suit_01_Blue_F",
	"U_BG_Guerrilla_6_1",
	"U_O_R_Gorka_01_black_F",
	"OPTRE_Ins_ER_uniform_GAtan"
];

// Vests
KP_liberation_guerilla_vests_1 = [
    "V_SmershVest_01_F",
	"V_BandollierB_blk",
	"V_Chestrig_blk",
	"OPTRE_UNSC_M52A_Armor_Soft",
	"V_SmershVest_01_F"

];

KP_liberation_guerilla_vests_2 = [
    "V_SmershVest_01_F",
	"V_BandollierB_blk",
	"V_Chestrig_blk",
	"OPTRE_UNSC_M52A_Armor_Soft",
	"V_SmershVest_01_F"

];

KP_liberation_guerilla_vests_3 = [
    "V_SmershVest_01_F",
	"V_BandollierB_blk",
	"V_Chestrig_blk",
	"OPTRE_UNSC_M52A_Armor_Soft",
	"V_SmershVest_01_F"

];

// Headgear
KP_liberation_guerilla_headgear_1 = [
    "",
    "",
    "",
    "",
    "H_Booniehat_khk",
	"H_ShemagOpen_tan",
	"H_PASGT_basic_black_F",
	"H_Shemag_olive_hs",
	"OPTRE_h_PatrolCap_Brown",
	"H_Beret_EAF_01_F",
	"H_Bandanna_cbr",
	"H_Cap_blk"

];

KP_liberation_guerilla_headgear_2 = [
    "H_Booniehat_khk",
	"H_ShemagOpen_tan",
	"H_PASGT_basic_black_F",
	"H_Shemag_olive_hs",
	"OPTRE_h_PatrolCap_Brown",
	"H_Beret_EAF_01_F",
	"H_Bandanna_cbr",
	"H_Cap_blk"

];

KP_liberation_guerilla_headgear_3 = [
    "H_Booniehat_khk",
	"H_ShemagOpen_tan",
	"H_PASGT_basic_black_F",
	"H_Shemag_olive_hs",
	"OPTRE_h_PatrolCap_Brown",
	"H_Beret_EAF_01_F",
	"H_Bandanna_cbr",
	"H_Cap_blk"

];

// Facegear. Applies for tier 2 and 3.
KP_liberation_guerilla_facegear = [
    "",
    "",
    "",
    "G_Balaclava_blk",
    "OPTRE_EyePiece",
    "G_Bandanna_beast",
    "G_Combat",
	"G_Bandanna_blk",
	"G_Bandanna_aviator",
	"G_AirPurifyingRespirator_01_F",
	"G_Bandanna_khk"

];