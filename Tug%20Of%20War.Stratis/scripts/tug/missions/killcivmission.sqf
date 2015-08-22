diag_log format ["Executing killcivmission.sqf"];
if (isServer) then {
    _difficulty       = _this select 0;
    _misGroup         = createGroup independent;
    _marker           = missionMarkers call BIS_fnc_selectRandom;
    _civSpawnLocation = getMarkerPos _marker;
    _winCivilian      = _misGroup createUnit ["C_man_1", _civSpawnLocation, [], 0, "NONE"];

    waitUntil{
        not isNull _winCivilian
    };

    killCivMissionThreatGroupId = [] call generateThreatGroupId;
    _infAmount                  = [0] call calculateInfantrySpawnAmount;
    _vehAmount                  = [0] call calculateVehicleSpawnAmount;

    _spawnInit = """this addEventHandler ['killed',{_this execVM 'scripts\tug\tug_threat_dies.sqf'}];""";
    [_difficulty, _civSpawnLocation,_infAmount,_vehAmount,killCivMissionThreatGroupId,3720,_spawnInit] call spawnThreatAtLocation;

    ["KillCivilianTraitor","Eliminate the traitor","Intelligence found out a traitor is giving information to the enemy, eliminate him.  He will only be in the area for the next hour so be quick !",true,["KillCivilianMarker",_civSpawnLocation]] call SHK_Taskmaster_add;

    _winEventHandler = _winCivilian addMPEventHandler ["mpkilled",{
                                                        missionResult = "WON";
                                                        ["KillCivilianTraitor","succeeded"] call SHK_Taskmaster_upd;
                                                        [50] call changeFundsAllPlayers;
                                                    }];


    _missionLoseTime = serverTime + 3600;
    while {serverTime <= _missionLoseTime && alive _winCivilian} do {
        sleep 0.5;
    };

    diag_log format ["killcivmission lost handling the cleanup"];
    if(alive _winCivilian) then {
        ["KillCivilianTraitor","failed"] call SHK_Taskmaster_upd;
        missionResult = "LOST";
        _winCivilian removeMPEventHandler ["mpkilled", _winEventHandler];
    };

    [killCivMissionThreatGroupId] call removeThreatBySpawnId;
    {
        if(alive _x) then {
            deleteVehicle _x;
        };
    } forEach units _misGroup;
    deleteGroup _misGroup;
};