/*
    Description:
    Gets the index of a given player in the Players array. Identified by the Steam UID.
    Returns the index as number. If the Steam UID wasn't found it returns -1.

    Parameter(s):
        0: STRING - Steam UID of the player

    Returns:
    NUMBER
*/

params ["_uid"];

KP_liberation_playerRanks findIf {_x select 1 == _uid}