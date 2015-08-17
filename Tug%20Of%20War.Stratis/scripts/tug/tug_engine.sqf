diag_log format ["Executing tug_engine.sqf"];
if (isServer) then {
    diag_log format ["Starting TUG engine"];
    //spawn mission
    [] execVM "scripts\tug\tug_spawn_mission.sqf";

    waitUntil {
        sleep 5;
        !(isNil "missionResult")
    };

    diag_log format ["MissionResult: %1", missionResult];
    if(missionResult == "WON") then {
        [["EASY", true] call calculateMissionResult] call updateWarProgress;

        // balancebar code
        [warProgress] call setBalanceBarValue;
        if(hasInterface) then {
            [] call balanceBarUpdateEvent;
        };

        warResult = call getWarResult;
        if(warResult == "ONGOING") then {
            // grace time so missions can clean up and the engine gets a bit of a breather before starting a new mission
            sleep 30;
            execVM "scripts\tug\tug_engine.sqf";
        } else {
            if(warResult == "WON") then {
                diag_log format ["Ending the mission with Victory and calling all clients"];
                [["Victory",true,2],"BIS_fnc_endMission", true] call BIS_fnc_MP
            } else {
                diag_log format ["warResult in invalid state after missionResult: %1", missionResult];
                forceEnd
            };
        };
    } else {
        if(missionResult == "LOST") then {
            [["EASY", false] call calculateMissionResult] call updateWarProgress;

            // balancebar code
            [warProgress] call setBalanceBarValue;
            if(hasInterface) then {
                [] call balanceBarUpdateEvent;
            };

            warResult = call getWarResult;
            diag_log format ["warResult: %1", warResult];
            if(warResult == "ONGOING") then {
                execVM "scripts\tug\tug_engine.sqf";
            } else {
                if(warResult == "LOST") then {
                    diag_log format ["Ending the mission with Defeat and calling all clients"];
                    [["Defeat",false,2],"BIS_fnc_endMission", true] call BIS_fnc_MP
                } else {
                    diag_log format ["warResult in invalid state after missionResult: %1", missionResult];
                    forceEnd
                };
            };
        } else {
            diag_log format ["Invalid mission result: %1", missionResult];
            forceEnd
        };
    };
};