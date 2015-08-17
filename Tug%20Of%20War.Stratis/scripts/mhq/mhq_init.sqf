diag_log format ["Executing mhq_init.sqf with %1", _this];
if(isServer)then{
    mhqList = _this select 0;
    if(isnil("mhqList")) exitWith {diag_log format ["ERROR: No mhq list given"]};

    {
        _x execVM "scripts\mhq\mhq_respawn_init.sqf";
    }forEach mhqList;
};