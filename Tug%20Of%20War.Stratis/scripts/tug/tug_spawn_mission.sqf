diag_log format ["Executing tug_spawn_mission.sqf"];
if (isServer) then {
    missionResult  = nil;

    [0, "EASY"] call spawnMission;
	sleep 2;
    [1, "MEDIUM"] call spawnMission;
	sleep 2;
    [2, "HARD"] call spawnMission;
};