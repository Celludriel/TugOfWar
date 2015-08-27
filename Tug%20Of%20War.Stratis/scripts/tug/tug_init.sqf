diag_log format ["Executing tug_init.sqf"];

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

    //cache places where missions can spawn
    missionMarkers = [];
    [] call cacheMissionMarkers;

    //list of all available missions
    missions        = ["killcivmission"];
    //setup active missions
    activeMissions = [false,false,false];

    //start the mission engine
    [] execVM "scripts\tug\tug_engine.sqf";
};

if (hasInterface) then {
    player addMPEventhandler ["MPRespawn", {["scripts\tug\tug_player_respawn.sqf","BIS_fnc_execVM",true,true ] call BIS_fnc_MP}];
};