waituntil {!isnil "serverInitialized"};

diag_log format ["Executing init.sqf"];

call compileFinal preprocessFileLineNumbers "scripts\shk_taskmaster\shk_taskmaster.sqf";
call compileFinal preprocessFileLineNumbers "scripts\far_revive\FAR_revive_init.sqf";
execVM "scripts\gvs\gvs_init.sqf";

if(hasInterface) then {
    [] execVM "controls\balancebar\balancebar_init.sqf";
    [] execVM "scripts\fn_statusBar.sqf";
    [] execVM "scripts\MGI\MGI_init.sqf";
    [] execVM "scripts\warchest\warchest_client_init.sqf";

    player addaction ["eyeon", "scripts\eye.sqf"];
    player addaction ["eyeoff", "EYE_run = false;"];

    player addaction ["warchest content", "scripts\call_warchest_content.sqf"];

    [[
        ["TugOfWarTask","Tug Of War","Win enough missions to push the war effort to 100%, but beware being killed or losing missions will turn the war into the enemies favor"]
    ],[
        ["Credits","Made by: Celludriel"]
    ]] execvm "scripts\shk_taskmaster\shk_taskmaster.sqf";

    //init fatigue settings
    _fatigue_setting = "Fatigue" call BIS_fnc_getParamValue;
    if (local player && _fatigue_setting == 0) then {
        player enableFatigue false;
        player addMPEventhandler ["MPRespawn", {player enableFatigue false;}];
    };
};
