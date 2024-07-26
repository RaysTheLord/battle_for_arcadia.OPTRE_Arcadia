class HEVmain
{
	file = "scripts\tts_optre\HEV_V2\functions\main";
	class HEV_initHEV {};
	class HEV_launchControl {};
	class HEV_launchHEV {};
	class HEV_launchHEVPos {};
	class HEV_HEVmenu {};
	class HEV_HEVmenuDia {};
	class HEV_HEVmenuWrap {};
	class HEV_HEVFrigateLaunch {};
};
class HEV
{
	file = "scripts\tts_optre\HEV_V2\functions";
	class HEV_prepEffects {};
	class HEV_transitionFade {};
	class HEV_launchEffects {};
	class HEV_reentryEffects {};
	class HEV_handleLaunchBooster {};
	class HEV_handleReentryFire {};
	class HEV_handleChute {};
	class HEV_doorAction {};
	class HEV_crashEffects {};
};
class pEffects
{
	file = "scripts\tts_optre\HEV_V2\functions\particles";
	class PE_impactRocks {};
	class PE_fire {};
	class PE_launchBooster {};
	class PE_landingDust {};
	class PE_landingDust2 {};
	class PE_podSteam {};
	class PE_doorSparks {};
	class PE_lifepodSparks {};
	class PE_waterSplash {};
};
class lifeboat
{
	file = "scripts\tts_optre\lifeboat\functions";
	class lifeboat_initLifeboat {};
	class lifeboat_launchLifeboat {};
	class lifeboat_crashEffects {};
	class lifeboat_initCrashLoop {};
};