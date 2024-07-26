/**
	'tts_fnc_PE_waterSplash'
	
	***MODIFIED***
	
	Author: TheTimidShade
	
	Description:
	WATER SPLASH FOR LIFEPOD/HEV SCRIPT
	
	Execution:
	Should be executed on all clients including server using remoteExec.
	
	Parameter(s):
	0	_sourceObj - OBJECT: Object which is used as the reference position for creating the effect.
	
	Returns:
	NONE

**/

params [
	["_sourceObj", objNull, [objNull]]
];

//FIRE PARTICLE
_particle = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle setParticleRandom [
	0, //Lifetime randomness
	[3, 3, 1], //Position variance
	[2, 2, 2], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0, //? randomDirectionPeriodVar
	0, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle setParticleCircle [
	0.5,	//Circle Radius
	[5, 5, 10] //Circle Velocity
];

_particle setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\cl_basic.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"Billboard", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	2, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[0, 0, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	30, //Weight of particles
	1, //Volume of particles
	0, //Wind influence
	[1, 2, 3], //Particles sizes (particles seem to change size over time)
	[[0.9, 0.9, 1, 0.1], [0.9, 0.9, 1, 0]], //Particle colours Array of Array of RGBA Numbers
	[0.08], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle setDropInterval 0.0005;

_particle_2 = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle_2 setParticleRandom [
	0, //Lifetime randomness
	[0.5, 0.5, 3], //Position variance
	[2, 2, 2], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0, //? randomDirectionPeriodVar
	0, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle_2 setParticleCircle [
	0.5,	//Circle Radius
	[0.5, 0.5, 15] //Circle Velocity
];

_particle_2 setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\cl_basic.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"Billboard", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	3, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[0, 0, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	30, //Weight of particles
	1, //Volume of particles
	0, //Wind influence
	[2, 2, 3], //Particles sizes (particles seem to change size over time)
	[[0.9, 0.9, 1, 0.1], [0.9, 0.9, 1, 0]], //Particle colours Array of Array of RGBA Numbers
	[0.08], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle_2, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle_2 setDropInterval 0.001;

_particle attachTo [_sourceObj, [0,0,-2]];
_particle_2 attachTo [_sourceObj, [0,0,-2]];

sleep 0.3;

deleteVehicle _particle_2;

waitUntil {(speed _sourceObj) < 10};

deleteVehicle _particle;


