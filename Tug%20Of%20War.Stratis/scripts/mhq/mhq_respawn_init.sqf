_this setVariable ["MhqDeployed", false, true];
_this addAction ["Deploy", {[[[_this select 0, _this select 2], "scripts\mhq\mhq_deploy_action.sqf"], "BIS_fnc_execVM", true, true] call BIS_fnc_MP;},nil,1.5,true,true,"","{alive _x} count crew _target == 0"];
_this addMPEventHandler ["MPKilled", { _respawnId = (_this select 0) getVariable "RespawnId";
                                       _respawnId call BIS_fnc_removeRespawnPosition;}];
_this addMPEventHandler ["MPRespawn", {_this addAction ["Deploy", "scripts\mhq\mhq_deploy_action.sqf"];}];