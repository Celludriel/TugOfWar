generateThreatGroupId = {
    nextThreatGroupId = nextThreatGroupId + 1;
    nextThreatGroupId
};

calculateInfantrySpawnAmount = {
    diag_log format ["Calling calculateInfantrySpawnAmount with %1", _this];

    _playersOnServer = (west countSide allPlayers);
    _spawnAmount = 0;

    if(_playersOnServer > 0 && _playersOnServer <= 5) then {
        _spawnAmount = 10;
    };

    if(_playersOnServer >= 6 && _playersOnServer <= 10) then {
        _spawnAmount = 20;
    };

    if(_playersOnServer >= 11 && _playersOnServer <= 15) then {
        _spawnAmount = 40;
    };

    if(_playersOnServer >= 16 && _playersOnServer <= 20) then {
        _spawnAmount = 50;
    };

    _spawnAmount
};

calculateVehicleSpawnAmount = {
    diag_log format ["Calling calculateVehicleSpawnAmount with %1", _this];

    _playersOnServer = (west countSide allPlayers);
    _spawnAmount     = 0;

    if(_playersOnServer > 0 && _playersOnServer <= 5) then {
        _spawnAmount = 2;
    };

    if(_playersOnServer >= 6 && _playersOnServer <= 10) then {
        _spawnAmount = 4;
    };

    if(_playersOnServer >= 11 && _playersOnServer <= 15) then {
        _spawnAmount = 6;
    };

    if(_playersOnServer >= 16 && _playersOnServer <= 20) then {
        _spawnAmount = 10;
    };

    _spawnAmount
};

spawnThreatAtLocation = {
    diag_log format ["Calling spawnThreatAtLocation with %1", _this];
    private ["_difficulty","_location", "_infantryAmount", "_vehicleAmount", "_spawnId", "_timeToLive", "_custInit"];

    _difficulty     = _this select 0;
    _location       = _this select 1;
    _infantryAmount = _this select 2;
    _vehicleAmount  = _this select 3;
    _spawnId        = _this select 4;
    _timeToLive     = _this select 5;
    _custInit       = _this select 6;

    _aiDifficulty = [_difficulty] call calculateAiDifficulty;
    _trgCommand   = format ["nul = [%1,2,150,[true,false],[true,true,true],false,[%2,0],[%3,0],%4,nil,%5,%6] execVM 'scripts\threatmanager\LV\militarize.sqf'", _location,_infantryAmount,_vehicleAmount,_aiDifficulty,_custInit,_spawnId];
    diag_log format ["Preparing trigger command: %1", _trgCommand];

    _trg = [_spawnId, _location, 600, _trgCommand] call createSpawnTrigger;

    _expirationTime = serverTime + _timeToLive;
    activeThreatGroups pushBack [_spawnId, _trg, _expirationTime];
};

calculateAiDifficulty = {
        _missionDifficulty = _this select 0;
        _retValue          = 0.5;

        if(_missionDifficulty == "EASY") then{
            _retValue = 0.1;
        };

        if(_missionDifficulty == "MEDIUM") then{
            _retVAlue = 0.5;
        };

        if(_missionDifficulty == "HARD") then{
            _retValue = 0.8;
        };
        diag_log format ["AiDifficulty is %1", _retValue];
        _retValue
};

createSpawnTrigger = {
    diag_log format ["Calling createSpawnTrigger with %1", _this];

    _spawnId    = _this select 0;
    _location   = _this select 1;
    _area       = _this select 2;
    _trgCommand = _this select 3;

    _trg = createTrigger [format ["EmptyDetector", _spawnId], _location];
    sleep 1;
    _trg setTriggerArea [_area, _area, 0, false];
    _trg setTriggerActivation ["WEST", "PRESENT", false];
    _trg setTriggerStatements ["this", _trgCommand, ""];
    _trg
};

removeThreatBySpawnId = {
    diag_log format ["Calling removeThreatGroup with %1", _this];
    private ["_spawnId"];

    _spawnId = _this select 0;
    _threatGroup = missionNamespace getVariable ("LVgroup" + str _spawnId);

    if(!isNil "_threatGroup")then{
        nul = [_threatGroup] execVM "scripts\threatmanager\LV\LV_functions\LV_fnc_removeGroupV2.sqf";
        [_spawnId] call removeThreatFromActiveThreatGroupsBySpawnId;
    };
};

removeThreatFromActiveThreatGroupsBySpawnId = {
    diag_log format ["Calling removeThreatFromActiveThreatGroupsBySpawnId with %1", _this];
    private ["_spawnId"];

    _spawnId = _this select 0;

    _newArray = [];
    {
        if(_x select 0 != _spawnId) then {
            _newArray pushBack _x;
        }else{
            //removing the threat trigger
            deletevehicle _x select 1;
        };
    } forEach activeThreatGroups;
    activeThreatGroups = _newArray;
};