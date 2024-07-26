/**
	'tts_fnc_PE_fire'
	
	***MODIFIED***
	
	Author: TheTimidShade
	
	Description:
	Creates fire and smoke particles on the given object.
	
	Execution:
	Should be executed on all clients including server using remoteExec.
	
	Parameter(s):
	0	_sourceObj - OBJECT: Object which is used as the reference position for creating the effect (object on fire).
	1	_effectSize (OPTIONAL) - NUMBER: Size of the fire effect (smoke scales as well). Default = 2.
	2	_startHeight (MODIFIED) - NUMBER: Height that HEV started at.
	
	Returns:
	NONE

**/

params [
	["_sourceObj", objNull, [objNull]],
	["_effectSize", 2, [0]],
	["_startHeight", 8000, [0]]
];

//FIRE PARTICLE
_particle = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle setParticleRandom [
	0, //Lifetime randomness
	[0.1, 0.1, 0.1], //Position variance
	[0.3, 0.3, 0.5], //Velocity variance
	0.5, //Rotation velocity variance
	_effectSize*0.25, //Size variance
	[0, 0, 0, 0], //Colour variance
	0, //? randomDirectionPeriodVar
	0, //? randomDirectionIntensityVar
	0, //? angleVar
	1 //Do particles bounce?
];

_particle setParticleCircle [
	0.1,	//Circle Radius
	[0.2, 0.2, random 1] //Circle Velocity
];

_particle setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\ParticleEffects\Universal\Universal_02.p3d", //Name of the particle model
		16, 
		15, 
		16, 
		1 
	],
	"", //Animation name
	"Billboard", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	0.3, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[0, 0, -20], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	1, //Weight of particles
	1, //Volume of particles
	0.5, //Wind influence
	[_effectSize, _effectSize*0.05], //Particles sizes (particles seem to change size over time)
	[[1,1,1,1], [1,1,1,0]], //Particle colours Array of Array of RGBA Numbers
	[3,0.5], //Animation speed (rate at which particles change (size/animation/etc)))
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

_particle setDropInterval 0.01;

//SMOKE PARTICLE
_particle_2 = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle_2 setParticleRandom [
	0, //Lifetime randomness
	[0.1, 0.1, 0.1], //Position variance
	[0.3, 0.3, 0.5], //Velocity variance
	0.5, //Rotation velocity variance
	_effectSize*0.25, //Size variance
	[0, 0, 0, 0], //Colour variance
	0, //? randomDirectionPeriodVar
	0, //? randomDirectionIntensityVar
	0, //? angleVar
	1 //Do particles bounce?
];

_particle_2 setParticleCircle [
	0.3,	//Circle Radius
	[0.2, 0.2, random 1] //Circle Velocity
];

_particle_2 setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\ParticleEffects\Universal\Universal_02.p3d", //Name of the particle model
		8, 
		0, 
		40, 
		1 
	],
	"", //Animation name
	"Billboard", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	0.6, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[0, 0, -20], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	1, //Weight of particles
	1, //Volume of particles
	0.5, //Wind influence
	[_effectSize, _effectSize*0.05], //Particles sizes (particles seem to change size over time)
	[[0.5,0.2,0.2,0],[0,0,0,0.5],[1,1,1,0]], //Particle colours Array of Array of RGBA Numbers
	[1], //Animation speed (rate at which particles change size)
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

_particle_2 setDropInterval 0.01;

_particle attachTo [_sourceObj, [0,0,-5]];
_particle_2 attachTo [_sourceObj, [0,0,-5]];

waitUntil {((getPosATL _sourceObj) select 2) < (_startHeight * 0.5)};

deleteVehicle _particle;
deleteVehicle _particle_2;