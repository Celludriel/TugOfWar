diag_log format ["Executing tug_srv_functions.sqf"];
if (isServer) then {
    diag_log format ["Initializing server functions"];
    
    spawnMission = {
        private ["_index, _difficulty"];
        
        _index  = _this select 0;
        _difficulty = _this select 1;
        
        if(isNull activeMissions[_index]) then {
            _missionToSpawn = missions call BIS_fnc_selectRandom;
            [_difficulty] execVM (format ["scripts\tug\missions\%1.sqf", _missionToSpawn]);
            activeMissions set [_index, true];
        };
    };
    
    clearCompletedMission = {
        diag_log format ["Calling clearCompletedMission, with %1", _this];
        private ["_missionDifficulty"];

        _missionDifficulty = _this select 0;

        if(_missionDifficulty == "EASY") then {
            activeMissions set [0, objNull];
        };

        if(_missionDifficulty == "MEDIUM") then {
            activeMissions set [1, objNull];
        };

        if(_missionDifficulty == "HARD") then {
            activeMissions set [2, objNull];
        };
    };
    
    setWarProgress = {
        diag_log format ["Calling setWarProgress with %1", _this];

        warProgress = _this select 0;
        publicVariable  "warProgress";
    };

    updateWarProgress = {
        diag_log format ["Calling updateWarProgress with %1", _this];

        warProgress = warProgress + (_this select 0);
        publicVariable  "warProgress";
    };

    getWarResult = {
        diag_log format ["Calling getWarResult, warProgress: %1", warProgress];
        private ["_retValue"];

        _retValue = "ONGOING";
        if(warProgress >= 100) then {
            _retValue = "WON";
        } else {
            if(warProgress <= -100) then {
                _retValue = "LOST";
            };
        };
        diag_log format ["WarResult is %1", _retValue];
        _retValue
    };

    calculateMissionResult = {
        diag_log format ["Calling calculateMissionResult, with %1", _this];
        private ["_retValue", "_missionDifficulty", "_hasWon"];

        _missionDifficulty = _this select 0;
        _hasWon            = _this select 1;
        _retValue          = 0;

        if(_missionDifficulty == "EASY") then{
            if(_hasWon)then{
                _retValue = 5;
            }else{
                _retValue = -15;
            };
        };

        if(_missionDifficulty == "MEDIUM") then{
            if(_hasWon)then{
                _retValue = 10;
            }else{
            _retValue = -10;
            };
        };

        if(_missionDifficulty == "HARD") then{
            if(_hasWon)then{
                _retValue = 20;
            }else{
            _retValue = -5;
            };
        };
        _retValue
    };
    
    cacheMissionMarkers = {
        diag_log format ["Calling cacheMissionMarkers, with %1", _this];
        missionMarkers = [];
        _markers       = allMapMarkers;
        diag_log format ["_markers %1", _markers];
        {
            if(["mismark_", _x, true] call BIS_fnc_inString)then{
                missionMarkers pushBack _x;
            }
        }forEach _markers;
        diag_log format ["Cached markers: %1", missionMarkers];
    };
};