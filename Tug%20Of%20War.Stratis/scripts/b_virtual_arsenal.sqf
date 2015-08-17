["Open",true] spawn BIS_fnc_arsenal;

player addMPEventhandler ["MPRespawn", {[player, [missionnamespace, "CurrentLoadout"]] call bis_fnc_loadInventory}];

player setVariable [ "VAcatch", [ "VAcatch", "onEachFrame", {
    if ( !( isNil { _this getVariable "VAcatch" } ) && { !( isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) ) } ) then {
        _this setVariable [ "VAcatch", nil ];
        _thread = _this spawn {
            waitUntil { isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )  };
            [player, [missionnamespace, "CurrentLoadout"]] call bis_fnc_saveInventory;
            _this setVariable [ "VAcatch", "VAcatch" ];
        };
    };
}, player ] call BIS_fnc_addStackedEventHandler ];
