diag_log format ["Executing tug_spawn_mission.sqf"];
if (isServer) then {
    missionResult   = nil;
    missions        = ["killcivmission"];
    _missionToSpawn = missions call BIS_fnc_selectRandom;

    ["EASY"] execVM (format ["scripts\tug\missions\%1.sqf", _missionToSpawn]);
};