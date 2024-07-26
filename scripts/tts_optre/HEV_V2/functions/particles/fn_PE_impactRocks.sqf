/**
	'tts_fnc_PE_impactRocks'
	
	Author: TheTimidShade
	
	Description:
	Shoots rocks out from a point on the ground below the particle source. (Particles are created on terrain.)
	
	Execution:
	Should be executed on all clients including server using remoteExec.
	
	Parameter(s):
	0	_sourceObj - OBJECT: Object which is used as the reference position for creating the effect (object hitting ground/crater point).
	1	_launchSpeed (OPTIONAL) - NUMBER: Velocity at which rocks are projected from the impact point. Default = 4.
	2	_deleteTimer (OPTIONAL) - NUMBER: Length after which particles are deleted. Default = 120.
	3	_playSound (OPTIONAL) - BOOL: Whether or not the rock sound effect is played. Default = true.
	4	_rockSize (OPTIONAL) - NUMBER: Size of rock particles (size is randomised slightly for variation). Default = 0.5.
	5	_rockVariance (OPTIONAL) - NUMBER: If size = 1, variance = 0.5 sizes will range from 0.5 to 1.5. Default = 0.5.
	
	Returns:
	NONE
	
	Examples:
	[player] remoteExec ["tts_fnc_PE_impactRocks", 0];
	Creates impact rocks effect on player with default parameters.
	
	[player, 6, 30, false, 2, 1] remoteExec ["tts_fnc_PE_impactRocks", 0];
	Creates impact rocks effect on player with rocks launched outwards at 6m/s, deleting particles after 30s
	without playing sound. Rock sizes range from 1 to 3.

**/

params [
	["_sourceObj", objNull, [objNull]],
	["_launchSpeed", 4, [0]],
	["_deleteTimer", 120, [0]],
	["_playSound", true, [true]],
	["_rockSize", 0.5, [0]],
	["_rockVariance", 0.5, [0]]
];

_particle = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

if (_playSound && isServer) then {
	[_sourceObj, ["rockfall", 60]] remoteExec ["say3D", 0];
};

_particle setParticleRandom [
	10, //Lifetime randomness
	[0.1, 0.1, 0.1], //Position variance
	[3, 3, (random 6)-3], //Velocity variance
	0.5, //Rotation velocity variance
	_rockVariance, //Size variance
	[0, 0, 0, 0], //Colour variance
	0, //? randomDirectionPeriodVar
	0, //? randomDirectionIntensityVar
	0, //? angleVar
	1 //Do particles bounce?
];

_particle setParticleCircle [
	0.5,	//Circle Radius
	[_launchSpeed, _launchSpeed, random 1] //Circle Velocity
];

_particle setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\ParticleEffects\Universal\Mud.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		1 
	],
	"", //Animation name
	"SpaceObject", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	_deleteTimer, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[0, 0, 5], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	100, //Weight of particles
	1, //Volume of particles
	1, //Wind influence
	[_rockSize], //Particles sizes (particles seem to change size over time)
	[[0, 0, 0, 1]], //Particle colours Array of Array of RGBA Numbers
	[0.125], //Animation speed (rate at which particles change size)
	0.5, // randomDirectionPeriod
	1, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle, //Object that particle is emmitted on?
	0, // Angle ? Optional
	true, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle setDropInterval 0.001;

sleep 0.1;

deleteVehicle _particle;