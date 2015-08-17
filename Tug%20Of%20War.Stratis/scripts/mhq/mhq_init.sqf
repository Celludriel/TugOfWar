diag_log format ["Executing mhq_init.sqf with %1", _this];
if(isServer)then{
    mhqList = _this select 0;
    if(isnil("mhqList")) exitWith {diag_log format ["ERROR: No mhq list given"]};

    {
        _x setVariable ["MhqDeployed", false, true];
        _x addAction ["Deploy", {[[[_this select 0, _this select 2], "scripts\mhq\mhq_deploy_action.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;}];
        _x addMPEventHandler ["MPRespawn", {_this addAction ["Deploy", "scripts\mhq\mhq_deploy_action.sqf"];}];
    }forEach mhqList;
};