#include "defines.hpp"

diag_log format ["Calling tug_threat_dies with %1", _this];

_victim = _this select 0;
_killer = _this select 1;

if(isPlayer _killer) then {
    if (_victim isKindOf "Ship" or _victim isKindOf "Air" or _victim isKindOf "LandVehicle") then {
        [getPlayerUID _killer, VEH_KILL_VALUE] call changeFunds;
    } else {
        [getPlayerUID _killer, INF_KILL_VALUE] call changeFunds;
    }
}