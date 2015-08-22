diag_log format ["Executing tug_srv_functions.sqf"];
if (isServer) then {
    diag_log format ["Initializing server functions"];
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
        missionMarkers = [];
        _markers       = allMapMarkers;
        {
            if([_x, "mismark_", true] call BIS_fnc_inString)then{
                missionMarkers pushBack _x;
            }            
        }forEach _markers;
    };
};