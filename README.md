# Halo Battle For Arcadia Liberation

[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3297349876&result=1)

Liberation rewritten for the Halo universe.  Here's a rundown of what you can change to mold the feel to your setting:

### Initial Date/Time

You can set the starting date in init.sqf to match what you'd like.  This is used in the flavor text for medals as well as the cinematic intro screen.

### Weather Patterns

If you'd like rainier weather (e.g. for a glassed planet), that can be controlled in scripts/server/game/manage_weather.sqf.  Just set the array to favor higher options.

### Replacing INDFOR units.

Everything still goes off the presets folder, but "Halo: Battle for" (HBF) Liberation works a bit differently.  Instead of units that get upgraded gear over time, HBF assumes an organized INDFOR party, where the units themselves will upgrade over time.  You place define units based on what tier they appear at, or in what role.

Flavor text is also modified.  If you change the faction from Colonial Police, open up stringtable.xml and use the find-and-replace function of your editor to replace "Colonial Police" with the name of your unit.

### OPFOR Units and Webknights

For all OPFOR spawning, it will now pull WBK units (defined as units with WBK, OPTREW, or IMS in their type) into their own group, which will prevent them from interfering with normal unit AI.  Therefore, you can use Webknights units alongside regular units in your definitions.

### Arsenal Changes

A custom arsenal is defined in arsenal_presets/custom.sqf, to pair with the leveling system, where as units level they will get access to better and better gear.  There are 7 arsenals each for normal units, ODST units, and Spartan units.

IF YOU WANT TO REMOVE THE ARSENAL RESTRICTIONS: It's as easy as leaving all the arrays in the arsenal blank.  You can also disable arsenal restrictions through normal Liberation settings (e.g. by using the default blacklist).

### Unit Changes

To set a unit as an ODST or Spartan, simply open up the mission and editor and change the unit type to any ODST or any Spartan.

# Questions:

You can find me in the [FoddSquad](https://discord.gg/UselessFodder), where I work on cool Arma projects, or in the [OPTRE discord](https://steamcommunity.com/linkfilter/?u=https%3A%2F%2Fdiscord.gg%2FxaK2y32KSu) if there are any questions or issues.

Have fun!
