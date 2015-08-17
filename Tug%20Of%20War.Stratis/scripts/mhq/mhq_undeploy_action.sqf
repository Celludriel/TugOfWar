diag_log format ["Calling mhq_undeploy_action with %1", _this];
_mhq      = _this select 0;
_actionId = _this select 1;

_isDeployed = _mhq getVariable "MhqDeployed";
if(_isDeployed)then{

    _mhq setVehicleLock "UNLOCKED";
    _mhq setVariable ["MhqDeployed", false, true];
    _respawnId = _mhq getVariable "RespawnId";
    _respawnId call BIS_fnc_removeRespawnPosition;

    _mhq removeAction _actionId;
    _mhq addAction ["Deploy", {[[[_this select 0, _this select 2], "scripts\mhq\mhq_deploy_action.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;}];
};