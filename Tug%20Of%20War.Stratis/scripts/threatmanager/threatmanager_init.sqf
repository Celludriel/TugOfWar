diag_log format ["Executing threatmanager_init.sqf"];

if (!isServer) exitWith {};

call compileFinal preprocessFileLineNumbers "scripts\threatmanager\threatmanager_functions.sqf";

nextThreatGroupId = 0;
// format arrays [groupId,trigger the group is active for,time the group should be removed]
activeThreatGroups = [];

[] execVM "scripts\threatmanager\threatmanager_engine.sqf";