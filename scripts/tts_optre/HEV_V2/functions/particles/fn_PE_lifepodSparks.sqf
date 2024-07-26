/**
	'tts_fnc_PE_lifepodSparks'
	
	***MODIFIED***
	
	Author: TheTimidShade
	
	Description:
	LAUNCH SPARKS FOR LIFEPOD SCRIPT
	
	Execution:
	Should be executed on all clients including server using remoteExec.
	
	Parameter(s):
	0	_sourceObj - OBJECT: Object which is used as the reference position for creating the effect (pod).
	
	Returns:
	NONE

**/

params [
	["_sourceObj", objNull, [objNull]]
];

_particle = "#particlesource" createVehicleLocal (getPosATL _sourceObj);
_particleDir = (getDir _sourceObj) + 180;
_partXvel = sin _particleDir;
_partYvel = cos _particleDir;

_particle setParticleRandom [
	0, //Lifetime randomness
	[0.01, 0.01, 0.01], //Position variance
	[1, 1, 1], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0.2, //? randomDirectionPeriodVar
	0.2, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle setParticleCircle [
	0.01,	//Circle Radius
	[0.3, 0.3, 0.3] //Circle Velocity
];

_particle setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"SpaceObject", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	1, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[_partXvel*2, _partYvel*2, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	10, //Weight of particles
	7.6, //Volume of particles
	0, //Wind influence
	[3,2,0], //Particles sizes (particles seem to change size over time)
	[[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.5]], //Particle colours Array of Array of RGBA Numbers
	[1], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false, -1 = disable collisions)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle setDropInterval 0.001;

_particle_2 = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle_2 setParticleRandom [
	0, //Lifetime randomness
	[0.01, 0.01, 0.01], //Position variance
	[1, 1, 1], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0.2, //? randomDirectionPeriodVar
	0.2, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle_2 setParticleCircle [
	0.01,	//Circle Radius
	[0.3, 0.3, 0.3] //Circle Velocity
];

_particle_2 setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"SpaceObject", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	1, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[_partXvel*2, _partYvel*2, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	10, //Weight of particles
	7.6, //Volume of particles
	0, //Wind influence
	[3,2,0], //Particles sizes (particles seem to change size over time)
	[[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.5]], //Particle colours Array of Array of RGBA Numbers
	[1], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle_2, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false, -1 = disable collisions)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle_2 setDropInterval 0.001;

_particle_3 = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle_3 setParticleRandom [
	0, //Lifetime randomness
	[0.01, 0.01, 0.01], //Position variance
	[1, 1, 1], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0.2, //? randomDirectionPeriodVar
	0.2, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle_3 setParticleCircle [
	0.01,	//Circle Radius
	[0.3, 0.3, 0.3] //Circle Velocity
];

_particle_3 setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"SpaceObject", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	1, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[_partXvel*2, _partYvel*2, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	10, //Weight of particles
	7.6, //Volume of particles
	0, //Wind influence
	[3,2,0], //Particles sizes (particles seem to change size over time)
	[[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.5]], //Particle colours Array of Array of RGBA Numbers
	[1], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle_3, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false, -1 = disable collisions)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle_3 setDropInterval 0.001;

_particle_4 = "#particlesource" createVehicleLocal (getPosATL _sourceObj);

_particle_4 setParticleRandom [
	0, //Lifetime randomness
	[0.01, 0.01, 0.01], //Position variance
	[1, 1, 1], //Velocity variance
	0.5, //Rotation velocity variance
	0.5, //Size variance
	[0, 0, 0, 0], //Colour variance
	0.2, //? randomDirectionPeriodVar
	0.2, //? randomDirectionIntensityVar
	0, //? angleVar
	0 //Do particles bounce?
];

_particle_4 setParticleCircle [
	0.01,	//Circle Radius
	[0.3, 0.3, 0.3] //Circle Velocity
];

_particle_4 setParticleParams [
	/* String or Array - If string then the name of the particleShape. And following default values are used:
		particleFSNtieth = 1
		particleFSIndex = 0
		particleFSFrameCount = 1
		particleFSLoop = 1
	*/
	[
		"\A3\data_f\proxies\muzzle_flash\muzzle_flash_silencer.p3d", //Name of the particle model
		1, 
		0, 
		1, 
		0 
	],
	"", //Animation name
	"SpaceObject", // 'Billboard' or 'SpaceObject'
	1, //Timer period
	1, //Particle lifetime
	[0,0,0], //Array as relative position of emmission to particle source
	[_partXvel*2, _partYvel*2, 0], //Move velocity of particles [x,y,z]
	1, //Rotational velocity of particles
	10, //Weight of particles
	7.6, //Volume of particles
	0, //Wind influence
	[3,2,0], //Particles sizes (particles seem to change size over time)
	[[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 0.5]], //Particle colours Array of Array of RGBA Numbers
	[1], //Animation speed (rate at which particles change (size/animation/etc)))
	1, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", //Script run on timer end (SQF path)
	"", //Script run before particle deletion (SQF path)
	_particle_4, //Object that particle is emmitted on?
	0, // Angle ? Optional
	false, //Whether or not particles are created at surface height (terrain)
	0 //, //Whether or not particles bounce on surfaces (1 = true, 0 = false, -1 = disable collisions)
	//emissiveColor, //Emissive colour Optional Array of Array of RGBA Numbers*/
	//vectorDir /*Optional 3D Array Vector dir. Since Arma 3 v1.92 it is possible to set the initial direction of the SpaceObject */
];

_particle_4 setDropInterval 0.001;

_particle attachTo [_sourceObj, [0.8,-3,0.5]];
_particle_2 attachTo [_sourceObj, [-0.8,-3,0.5]];
_particle_3 attachTo [_sourceObj, [0.8,-3,-1.5]];
_particle_4 attachTo [_sourceObj, [-0.8,-3,-1.5]];

playSound "pod_detach";

sleep 0.1;

deleteVehicle _particle;
deleteVehicle _particle_2;
deleteVehicle _particle_3;
deleteVehicle _particle_4;
