diag_log format ["Executing tug_spawn_mission.sqf"];
if (isServer) then {
    activeMissions = [objNull,objNull,objNull];
    missionResult  = nil;    

    [0, "EASY"] call spawnMission;
    [1, "MEDIUM"] call spawnMission;
    [2, "HARD"] call spawnMission;
};