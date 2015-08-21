diag_log format ["Executing tug_init.sqf"];

[] execVM "scripts\warchest\warchest_init.sqf";

if (isServer) then {
    diag_log format ["TUG server side init"];
    //this code will run only once on the server PC
    //initialize all serverside functions
    call compileFinal preprocessFileLineNumbers "scripts\tug\tug_srv_functions.sqf";

    //initialize the war
    warCompleted = false;
    if(isNil "warProgress") then {
        [0] call setWarProgress;
        [warProgress] call setBalanceBarValue;
    };

    //start the mission engine
    [] execVM "scripts\tug\tug_engine.sqf";
};

if (hasInterface) then {    
    player addMPEventhandler ["MPRespawn", {["scripts\tug\tug_player_respawn.sqf","BIS_fnc_execVM",true,true ] call BIS_fnc_MP}];
};