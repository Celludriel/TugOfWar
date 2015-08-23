if (!isServer) exitWith {};

diag_log format ["Executing initserver.sqf"];
call compileFinal preprocessFileLineNumbers "scripts\shk_taskmaster\shk_taskmaster.sqf";

_handle = [] execVM "controls\balancebar\balancebar_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\threatmanager\threatmanager_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\tug\tug_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\time_setup.sqf";
waitUntil { scriptDone _handle };
_handle = [[MHQ1,MHQ2]] execVM "scripts\mhq\mhq_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\warchest\warchest_server_init.sqf";
waitUntil { scriptDone _handle };

[60,5*60,3*60,2*60,10*60,0] execVM 'scripts\repetitive_cleanup.sqf';