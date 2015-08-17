if (!isServer) exitWith {};

diag_log format ["Executing initserver.sqf"];
_handle = [] execVM "controls\balancebar\balancebar_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\threatmanager\threatmanager_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\tug\tug_init.sqf";
waitUntil { scriptDone _handle };
_handle = [] execVM "scripts\time_setup.sqf";
waitUntil { scriptDone _handle };
_handle = [[mhq1,mhq2]] execVM "scripts\mhq\mhq_init.sqf";
waitUntil { scriptDone _handle };

[60,5*60,3*60,2*60,10*60,0] execVM 'scripts\repetitive_cleanup.sqf';