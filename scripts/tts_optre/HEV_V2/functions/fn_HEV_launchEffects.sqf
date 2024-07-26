//Local HEV launch effects

playSound "launch_beep";
sleep 2;
playSound "pod_detach";
enableCamShake true;
addCamShake [5, 10, 25];
addCamShake [1, 30, 20];
playSound "engine_boost";
