diag_log format ["Executing killcivmission.sqf"];
if (isServer) then {
    _difficulty       = _this select 0;
    _misGroup         = createGroup independent;
    _marker           = [] call getRandomMarker;
    _civSpawnLocation = getMarkerPos _marker;
    _winCivilian      = _misGroup createUnit ["C_man_1", _civSpawnLocation, [], 0, "NONE"];

    waitUntil{
        not isNull _winCivilian
    };

    _winCivilian setVariable ["_difficulty", _difficulty];
    _winCivilian setVariable ["_marker", _marker];
    _winCivilian disableAI "MOVE";

    killCivMissionThreatGroupId = [] call generateThreatGroupId;
    _infAmount                  = [0] call calculateInfantrySpawnAmount;
    _vehAmount                  = [0] call calculateVehicleSpawnAmount;

    _spawnInit = """this addEventHandler ['killed',{_this execVM 'scripts\tug\tug_threat_dies.sqf'}];""";
    [_difficulty, _civSpawnLocation,_infAmount,_vehAmount,killCivMissionThreatGroupId,3720,_spawnInit] call spawnThreatAtLocation;

    [format ["KillCivilianTraitor%1", _difficulty],"Eliminate the traitor","Intelligence found out a traitor is giving information to the enemy, eliminate him.  He will only be in the area for the next hour so be quick !",true,[format ["KillCivilianMarker%1", _difficulty],_civSpawnLocation]] call SHK_Taskmaster_add;

    _winEventHandler = _winCivilian addMPEventHandler ["mpkilled",{
                                                        _difficulty = ((_this select 0) getVariable "_difficulty");
                                                        _marker = ((_this select 0) getVariable "_marker");
                                                        missionResult = [_difficulty,"WON"];
                                                        [format ["KillCivilianTraitor%1", _difficulty],"succeeded"] call SHK_Taskmaster_upd;
                                                        [50] call changeFundsAllPlayers;
                                                        deleteMarker format ["KillCivilianMarker%1", _difficulty];
                                                        missionMarkers pushBack _marker;
                                                    }];


    _missionLoseTime = serverTime + 3600;
    while {serverTime <= _missionLoseTime && alive _winCivilian} do {
        sleep 0.5;
    };

    diag_log format ["killcivmission lost handling the cleanup"];
    if(alive _winCivilian) then {
        [format ["KillCivilianTraitor%1", _difficulty],"failed"] call SHK_Taskmaster_upd;
        missionResult = [_difficulty,"LOST"];
        _winCivilian removeMPEventHandler ["mpkilled", _winEventHandler];
        deleteMarker format ["KillCivilianMarker%1", _difficulty];
        missionMarkers pushBack _marker;
    };

    [killCivMissionThreatGroupId] call removeThreatBySpawnId;
    {
        if(alive _x) then {
            deleteVehicle _x;
        };
    } forEach units _misGroup;
    deleteGroup _misGroup;
};