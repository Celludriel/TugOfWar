diag_log format ["Executing tug_player_respawn.sqf"];

player addaction ["eyeon", "scripts\eye.sqf"];
player addaction ["eyeoff", "EYE_run = false;"];

if(isServer)then{
    if((west countSide allPlayers) > 1) then {
        if(difficulty == 1)then{
            [-1] call updateWarProgress;
        };

        if(difficulty == 2)then{
            [-2] call updateWarProgress;
        };

        if(difficulty == 3)then{
            [-5] call updateWarProgress;
        };

        [warProgress] call setBalanceBarValue;
        if(hasInterface) then {
            [] call balanceBarUpdateEvent;
        };

        warResult = call getWarResult;
        diag_log format ["warResult: %1", warResult];
        if(warResult == "LOST") then {
            diag_log format ["Ending the mission with Defeat and calling all clients"];
            [["Defeat",false,2],"BIS_fnc_endMission", true] call BIS_fnc_MP;
        };
    };
};