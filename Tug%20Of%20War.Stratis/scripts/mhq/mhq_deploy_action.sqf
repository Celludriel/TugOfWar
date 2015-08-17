diag_log format ["Calling mhq_deploy_action with %1", _this];
_mhq      = _this select 0;
_actionId = _this select 1;

_isDeployed = _mhq getVariable "MhqDeployed";
if(!_isDeployed)then{

    _mhq setVehicleLock "LOCKED";
    _mhq setVariable ["MhqDeployed", true, true];

    _pos          = getpos _mhq;
    _dist         = random 5;
    _dir          = random 360;
    _spawnPostion = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];

    _respawnId = [west, _spawnPostion, vehicleVarName _mhq] call BIS_fnc_addRespawnPosition;
    _mhq setVariable ["RespawnId", _respawnId, true];

    _mhq addAction ["Undeploy", {[[[_this select 0, _this select 2], "scripts\mhq\mhq_undeploy_action.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;}];
    _mhq removeAction _actionId;
};