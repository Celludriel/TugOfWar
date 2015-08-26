#include "defines.hpp"

diag_log format ["Calling tug_threat_dies with %1", _this];

_victim = _this select 0;
_killer = _this select 1;

if(isPlayer _killer) then {
    _value = 0;
    if (_victim isKindOf "Ship" or _victim isKindOf "Air" or _victim isKindOf "LandVehicle") then {
        _value = VEH_KILL_VALUE;
    } else {
    _value = INF_KILL_VALUE;
    };

    _uid = getPlayerUID _killer;
    [_uid, _value] call changeFunds;
};